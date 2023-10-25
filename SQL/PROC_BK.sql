Use BTL_PTPM_BanhKeo
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

create PROCEDURE khachSreach (@page_index  INT, 
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


	---------------------Hóa Đơn -------------------------
create PROCEDURE hoadonID
(
    @MaHoaDonBan CHAR(10)
)
AS
BEGIN
    SELECT h.*, 
    (
        SELECT c.*
        FROM ChiTietHoaDonBan AS c
        WHERE h.MaHoaDonBan = c.MaHoaDonBan FOR JSON PATH
    ) AS list_json_chitietdonhangban
    FROM HoaDonBan AS h
    WHERE h.MaHoaDonBan = @MaHoaDonBan;
END;

exec hoadonID '1'

create PROCEDURE hoadonCreate
(@KhachHangID              NVARCHAR(50),
@NgayBan			datetime,
 @ThanhTien          float,
 @list_json_chitietdonhangban NVARCHAR(MAX)
)
AS
    BEGIN
		DECLARE @MaHoaDonBan INT;
        INSERT INTO HoaDonBan
                (KhachHangID , 
				NgayBan,
                 ThanhTien             
                )
                VALUES
                (@KhachHangID, 
				@NgayBan, 
                 @ThanhTien
                );

				SET @MaHoaDonBan = (SELECT SCOPE_IDENTITY());
                IF(@list_json_chitietdonhangban IS NOT NULL)
                    BEGIN
                        INSERT INTO ChiTietHoaDonBan
						 (MatHangID, 
						  MaHoaDonBan,
                          SoLuong, 
                          GiaBan               
                        )
                    SELECT JSON_VALUE(p.value, '$.MatHangID'), 
                            @MaHoaDonBan, 
                            JSON_VALUE(p.value, '$.soLuong'), 
                            JSON_VALUE(p.value, '$.giaBan')    
                    FROM OPENJSON(@list_json_chitietdonhangban) AS p;
                END;
        SELECT '';
    END;

	select * from HoaDonBan
		select * from ChiTietHoaDonBan


create PROCEDURE hoadonUpdate
(@MaHoaDonBan        int, 
 @KhachHangID       CHAR(10), 
 @NgayBan          datetime, 
 @ThanhTien        float,  
 @list_json_chitietdonhangban NVARCHAR(MAX)
)
AS
    BEGIN
		UPDATE HoaDonBan
		SET
			KhachHangID  = @KhachHangID ,
			NgayBan = @NgayBan,
			ThanhTien = @ThanhTien
		WHERE MaHoaDonBan = @MaHoaDonBan;
		
		IF(@list_json_chitietdonhangban IS NOT NULL) 
		BEGIN
			 -- Insert data to temp table 
		   SELECT
			  JSON_VALUE(p.value, '$.maChiTietHoaDon') as maChiTietHoaDonBan,
			  JSON_VALUE(p.value, '$.maHoaDonBan') as maHoaDonBan,
			  JSON_VALUE(p.value, '$.matHangID') as matHangID,
			  JSON_VALUE(p.value, '$.soLuong') as soLuong,
			  JSON_VALUE(p.value, '$.giaBan') as giaBan,
			  JSON_VALUE(p.value, '$.status') as status
			  INTO #Results 
		   FROM OPENJSON(@list_json_chitietdonhangban) AS p;
		 
		 -- Insert data to table with STATUS = 1;
			INSERT INTO ChiTietHoaDonBan (MatHangID, 
						  MaHoaDonBan,
                          SoLuong, 
                          GiaBan ) 
			   SELECT
				  #Results.MatHangID,
				  @MaHoaDonBan,
				  #Results.soLuong,
				  #Results.GiaBan			 
			   FROM  #Results 
			   WHERE #Results.status = '1' 
			
			-- Update data to table with STATUS = 2
			  UPDATE ChiTietHoaDonBan 
			  SET
				 SoLuong = #Results.soLuong,
				 GiaBan = #Results.giaBan
			  FROM #Results 
			  WHERE  ChiTietHoaDonBan.maChiTietHoaDonBan = #Results.maChiTietHoaDonban AND #Results.status = '2';
			
			-- Delete data to table with STATUS = 3
			DELETE C
			FROM ChiTietHoaDonBan C
			INNER JOIN #Results R
				ON C.maChiTietHoaDonBan=R.maChiTietHoaDonBan
			WHERE R.status = '3';
			DROP TABLE #Results;
		END;
        SELECT '';
    END;

	-- Tạo thủ tục xóa HoaDonBan
CREATE PROCEDURE XoaHoaDonBan
    @MaHoaDonBan int
AS
BEGIN
    -- Kiểm tra xem MaHoaDonBan có tồn tại không
    IF EXISTS (SELECT 1 FROM HoaDonBan WHERE MaHoaDonBan = @MaHoaDonBan)
    BEGIN
        -- Xóa chi tiết hóa đơn bán liên quan
        DELETE FROM ChiTietHoaDonBan WHERE MaHoaDonBan = @MaHoaDonBan;
        
        -- Xóa hóa đơn bán
        DELETE FROM HoaDonBan WHERE MaHoaDonBan = @MaHoaDonBan;
        
        PRINT 'Hóa đơn bán đã được xóa thành công.';
    END
    ELSE
    BEGIN
        PRINT 'Không tìm thấy hóa đơn bán có MaHoaDonBan = ' + CAST(@MaHoaDonBan AS nvarchar);
    END
END


select * from HoaDonBan
select * from ChiTietHoaDonBan
exec XoaHoaDonBan'8'


-------------------MatHang-----------------
-- Tạo thủ tục tìm kiếm Mặt Hàng 

	alter PROCEDURE TimMatHangID(@MatHangID char(10))
	AS
		BEGIN
			DECLARE @LoaiHangID char(10);
			set @LoaiHangID = (select LoaiHangID from MatHang where MatHangID = @MatHangID);
			SELECT s.*, 
			(
				SELECT top 6 sp.*
				FROM MatHang AS sp
				WHERE sp.LoaiHangID = s.LoaiHangID FOR JSON PATH
			) AS list_json_chitietmathang

			FROM MatHang AS s
			WHERE  s.MatHangID = @MatHangID;
		END;

	exec mathangid 'MH001'

-----------------------------------
create procedure mathangid
(@MatHangID int)
as
begin
	Select * 
		from MatHang
		where MatHangID =@MatHangID
end;

---------------------------------------
create PROCEDURE mathangCreate 
	
(@LoaiHangID char(10),
@MatHangID char(10),
@TenHang nvarchar(50),
@DVTinh nvarchar(10),
@SLTon tinyint
)
as 
	begin
		Insert into MatHang(LoaiHangID, MatHangID, TenHang, DVTinh, SLTon )
		values (@LoaiHangID, @MatHangID, @TenHang, @DVTinh, @SLTon);
	end;
go
	-----------------------------------------
CREATE PROCEDURE mathangUpdate
  (@LoaiHangID char(10),
@MatHangID char(10),
@TenHang nvarchar(50),
@DVTinh nvarchar(10),
@SLTon tinyint)
AS
BEGIN
    UPDATE MatHang
    SET
        LoaiHangID = @LoaiHangID,
        MatHangID = @MatHangID,
        TenHang = @TenHang,
        DVTinh = @DVTinh,
		SLTon = @SLTon
    WHERE
        MatHangID = @MatHangID
END

-------------------------------------
CREATE PROCEDURE mathangDelete
(@MatHangID char(10))
as
	begin
		Delete from MatHang
		where MatHangID = @MatHangID
	end;
go


-----------TaifKhoan--------------------
create PROCEDURE user_login
(@taikhoan nvarchar(50), @matkhau nvarchar(50))
AS
    BEGIN
      SELECT  *
      FROM TaiKhoan
      where TenTaiKhoan= @taikhoan and MatKhau = @matkhau;
    END;

CREATE PROCEDURE taikhoanID
    @MaTaiKhoan int
AS
BEGIN
    SELECT *
    FROM TaiKhoan
    WHERE MaTaiKhoan = @MaTaiKhoan
END

exec taikhoanID '1'

CREATE PROCEDURE userCreate
    @MaTaiKhoan int,
    @MaLoai int,
    @TenTaiKhoan nvarchar(50),
    @MatKhau nvarchar(50),
    @Email  nvarchar(50)
AS
BEGIN
    INSERT INTO TaiKhoan (MaTaiKhoan, MaLoai, TenTaiKhoan, MatKhau, Email)
    VALUES (@MaTaiKhoan, @MaLoai, @TenTaiKhoan, @MatKhau, @Email)
END


---------- cập nhật thông tin khách hàng-------------
CREATE PROCEDURE userUpdate
    @MaTaiKhoan int,
    @MaLoai int,
    @TenTaiKhoan nvarchar(50),
    @MatKhau nvarchar(50),
    @Email  nvarchar(50)
AS
BEGIN
    UPDATE TaiKhoan
    SET
        MaLoai = @MaLoai,
        TenTaiKhoan = @TenTaiKhoan,
        MatKhau = @MatKhau,
		Email = @Email
    WHERE
        MaTaiKhoan = @MaTaiKhoan
END
-----------------xóa thông tin khách hàng------------------------
CREATE PROCEDURE userDelete
    @MaTaiKhoan int
AS
BEGIN
    DELETE FROM TaiKhoan
    WHERE MaTaiKhoan = @MaTaiKhoan
END