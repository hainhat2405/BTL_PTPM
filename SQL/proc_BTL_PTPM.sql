Use BTL_PTPM_BanHang
----------- tìm id khách hàng------------
CREATE PROCEDURE TimKiemKhachHangTheoID
    @KhachHangID char(10)
AS
BEGIN
    SELECT *
    FROM KhachHang
    WHERE KhachHangID = @KhachHangID
END

	
	
	---------------  Thêm khách hàng --------------
GO
CREATE PROCEDURE ThemKhachHang
    @KhachHangID char(10),
    @HoTenKH nvarchar(30),
    @DiaChiKH nvarchar(50),
    @EmailKH char(30),
    @SdtKH char(10)
AS
BEGIN
    INSERT INTO KhachHang (KhachHangID, HoTenKH, DiaChiKH, EmailKH, SdtKH)
    VALUES (@KhachHangID, @HoTenKH, @DiaChiKH, @EmailKH, @SdtKH)
END


---------- cập nhật thông tin khách hàng-------------
CREATE PROCEDURE CapNhatKhachHang
    @KhachHangID char(10),
    @HoTenKH nvarchar(30),
    @DiaChiKH nvarchar(50),
    @EmailKH char(30),
    @SdtKH char(10)
AS
BEGIN
    UPDATE KhachHang
    SET
        HoTenKH = @HoTenKH,
        DiaChiKH = @DiaChiKH,
        EmailKH = @EmailKH,
        SdtKH = @SdtKH
    WHERE
        KhachHangID = @KhachHangID
END
-----------------xóa thông tin khách hàng------------------------
CREATE PROCEDURE XoaKhachHang
    @KhachHangID char(10)
AS
BEGIN
    DELETE FROM KhachHang
    WHERE KhachHangID = @KhachHangID
END

----------------------------------------------------

create PROCEDURE [dbo].[sp_khach_search] (@page_index  INT, 
                                       @page_size   INT,
									   @ten_khach Nvarchar(50),
									   @dia_chi Nvarchar(250)
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY HoTenKH ASC)) AS RowNumber, 
                              k.KhachHangID,
							  k.HoTenKH,
							  k.DiaChiKH
                        INTO #Results1
                        FROM KhachHang AS k
					    WHERE  (@ten_khach = '' Or k.HoTenKH like N'%'+@ten_khach+'%') and						
						(@dia_chi = '' Or k.DiaChiKH like N'%'+@dia_chi+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY HoTenKH ASC)) AS RowNumber, 
                              k.KhachHangID,
							  k.HoTenKH,
							  k.DiaChiKH
                        INTO #Results2
                        FROM KhachHang AS k
					    WHERE  (@ten_khach = '' Or k.HoTenKH like N'%'+@ten_khach+'%') and						
						(@dia_chi = '' Or k.DiaChiKH like N'%'+@dia_chi+'%');                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;                        
                        DROP TABLE #Results1; 
        END;
    END;


-------------------Hóa đơn------------------------------------


USE BTL_PTPM_BanHang
GO

-- Tạo hoặc thay đổi thủ tục lưu trữ
/****** Object: StoredProcedure [dbo].[hoadonID] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE hoadonID
(
    @DonHangBanID CHAR(10)
)
AS
BEGIN
    SELECT h.*, 
    (
        SELECT c.*
        FROM ChiTietDHB AS c
        WHERE h.DonHangBanID = c.DonHangBanID FOR JSON PATH
    ) AS list_json_chitietdonhangban
    FROM DonHangBan AS h
    WHERE h.DonHangBanID = @DonHangBanID;
END;


	drop proc hoadonID




CREATE PROCEDURE hoaDon_update
    @DonHangBanID char(10),
    @NhanVienID char(10),
    @KhachHangID char(10),
	@NgayBan datetime,
	@TrietKhauBan float,
    @list_json_chitiethoadon NVARCHAR(MAX)
AS
BEGIN
    BEGIN TRANSACTION;
    
    BEGIN TRY
        -- Cập nhật thông tin đơn hàng bán
        UPDATE DonHangBan
        SET
            NgayBan = GETDATE()  -- Cập nhật ngày bán (có thể thay đổi theo yêu cầu)
        WHERE DonHangBanID = @DonHangBanID;

        -- Xóa chi tiết đơn hàng bán hiện tại
        DELETE FROM ChiTietDHB
        WHERE DonHangBanID = @DonHangBanID;

        -- Thêm chi tiết đơn hàng bán mới từ dữ liệu JSON
        IF (@list_json_chitiethoadon IS NOT NULL)
        BEGIN
            -- Tạo bảng tạm thời để lưu trữ dữ liệu JSON
            CREATE TABLE #TempChiTietDHB
            (
                DonHangBanID char(10),
                MatHangID char(10),
                SLBan tinyint,
                DGBan float
            );

            -- Insert dữ liệu từ JSON vào bảng tạm thời
            INSERT INTO #TempChiTietDHB (DonHangBanID, MatHangID, SLBan, DGBan)
            SELECT
                JSON_VALUE(p.value, '$.DonHangBanID'),
                JSON_VALUE(p.value, '$.MatHangID'),
                JSON_VALUE(p.value, '$.SLBan'),
                JSON_VALUE(p.value, '$.DGBan')
            FROM OPENJSON(@list_json_chitiethoadon) AS p;

            -- Thêm chi tiết đơn hàng bán từ bảng tạm thời
            INSERT INTO ChiTietDHB (DonHangBanID, MatHangID, SLBan, DGBan)
            SELECT DonHangBanID, MatHangID, SLBan, DGBan
            FROM #TempChiTietDHB;

            -- Xóa bảng tạm thời
            DROP TABLE #TempChiTietDHB;
        END;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
    END CATCH;

    SELECT '';
END
-- Gọi stored procedure hoaDon_update với các tham số
EXEC hoaDon_Update
    @DonHangBanID = 'DHB001',
    @NhanVienID = 'NV002',
    @KhachHangID = 'KH001',
    @NgayBan = '2023-10-20 14:30:00',
    @TrietKhauBan = 0.1,
    @list_json_chitiethoadon = N'{"DonHangBanID":"DHB001","MatHangID":"MH001","SLBan":5,"DGBan":10.5}'

drop proc hoadon_Update

CREATE PROCEDURE XoaDonHangBan
    @DonHangBanID char(10)
AS
BEGIN
    BEGIN TRANSACTION;
    
    BEGIN TRY
        -- Xóa chi tiết đơn hàng bán
        DELETE FROM ChiTietDHB
        WHERE DonHangBanID = @DonHangBanID;

        -- Xóa đơn hàng bán
        DELETE FROM DonHangBan
        WHERE DonHangBanID = @DonHangBanID;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
    END CATCH;
END

GO

USE BTL_PTPM_BanHang;
GO

-- Check if the procedure already exists and drop it
IF OBJECT_ID('hoadon_create', 'P') IS NOT NULL
BEGIN
    DROP PROCEDURE hoadon_create;
END
GO

-- Create the procedure
CREATE PROCEDURE hoadon_create
(
    @NhanVienID NVARCHAR(50),
    @KhachHangID NVARCHAR(50),
    @NgayBan DATETIME,
    @TrietKhauBan FLOAT,
    @list_json_chitiethoadon NVARCHAR(MAX)
)
AS
BEGIN
    DECLARE @DonHangBanID CHAR(10);
    
    -- Insert into DonHangBan
    INSERT INTO DonHangBan
    (
        DonHangBanID,
        NhanVienID,
        KhachHangID,
        NgayBan,
        TrietKhauBan
    )
    VALUES
    (
        'DH' + RIGHT('000' + CAST((SELECT COUNT(*) + 1 FROM DonHangBan) AS VARCHAR(3)), 3), -- Auto-generate DonHangBanID
        @NhanVienID,
        @KhachHangID,
        @NgayBan,
        @TrietKhauBan
    );

    SET @DonHangBanID = 'DH' + RIGHT('000' + CAST((SELECT COUNT(*) FROM DonHangBan) AS VARCHAR(3)), 3);

    -- Insert into ChiTietDHB if JSON data is provided
    IF (@list_json_chitiethoadon IS NOT NULL)
    BEGIN
        INSERT INTO ChiTietDHB
        (
            DonHangBanID,
            MatHangID,
            SLBan,
            DGBan
        )
        SELECT
            @DonHangBanID,
            JSON_VALUE(p.value, '$.MatHangID'),
            JSON_VALUE(p.value, '$.SLBan'),
            JSON_VALUE(p.value, '$.DGBan')
        FROM OPENJSON(@list_json_chitiethoadon) AS p;
    END;

    SELECT 'Invoice created successfully.';
END;
GO




	--------------------------login----------------------------
create PROCEDURE sp_login(@taikhoan nvarchar(50), @matkhau nvarchar(50))
AS
    BEGIN
      SELECT  *
      FROM TaiKhoan
      where TenTaiKhoan= @taikhoan and MatKhau = @matkhau;
    END;

	exec sp_login 'admin1','123'