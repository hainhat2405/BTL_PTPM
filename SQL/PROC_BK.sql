   Use BTL_PTPM_BanhKeo
----------- tìm id khách hàng------------
create PROCEDURE KhachHangID
    @KhachHangID char(10)
AS
BEGIN
    SELECT *
    FROM KhachHang
    WHERE KhachHangID = @KhachHangID
END


select * from ChiTietHoaDonBan
	---------------  Thêm khách hàng --------------
GO
CREATE PROCEDURE KhachHangCreate
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
CREATE PROCEDURE	
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
CREATE PROCEDURE KhachHangDel
    @KhachHangID char(10)
AS
BEGIN
    DELETE FROM KhachHang
    WHERE KhachHangID = @KhachHangID
END

----------------------------------------------------

alter PROCEDURE khachSreach (@page_index  INT, 
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
							  k.DiaChiKH,
							  k.SdtKH,
							  k.EmailKH
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
							  k.DiaChiKH,
							   k.SdtKH,
							  k.EmailKH
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

-- Execute the stored procedure
EXEC khachSreach  @page_index = 1,@page_size= 10, @ten_khach= N'Nguyễn Thị A',@dia_chi= N'Hà Nội';

---------------------Nhân viên-----------------------------------------
-- tìm kiếm id của nhân viên.
CREATE PROCEDURE nhanvienID
    @NhanVienID char(10)
AS
BEGIN
    SELECT *
    FROM NhanVien
    WHERE NhanVienID = @NhanVienID;
END


-- tạo nhân viên
CREATE PROCEDURE nhanvienCreate
    @NhanVienID char(10),
    @HoTenNV nvarchar(30),
    @GioiTinhNV nvarchar(50),
    @NgaySinhNV date,
    @DiaChiNV nvarchar(50),
    @EmailNV char(30),
    @SdtNV char(10),
    @Matkhau char(10)
AS
BEGIN
    INSERT INTO NhanVien (NhanVienID, HoTenNV, GioiTinhNV, NgaySinhNV, DiaChiNV, EmailNV, SdtNV, Matkhau)
    VALUES (@NhanVienID, @HoTenNV, @GioiTinhNV, @NgaySinhNV, @DiaChiNV, @EmailNV, @SdtNV, @Matkhau);
END

-- sửa thông tin nhân viên
CREATE PROCEDURE nhanvienUp
    @NhanVienID char(10),
    @HoTenNV nvarchar(30),
    @GioiTinhNV nvarchar(50),
    @NgaySinhNV date,
    @DiaChiNV nvarchar(50),
    @EmailNV char(30),
    @SdtNV char(10),
    @Matkhau char(10)
AS
BEGIN
    UPDATE NhanVien
    SET HoTenNV = @HoTenNV, GioiTinhNV = @GioiTinhNV, NgaySinhNV = @NgaySinhNV, DiaChiNV = @DiaChiNV,
        EmailNV = @EmailNV, SdtNV = @SdtNV, Matkhau = @Matkhau
    WHERE NhanVienID = @NhanVienID;
END

--xóa thông tin nhân viên
CREATE PROCEDURE nhanvienDel
    @NhanVienID char(10)
AS
BEGIN
    DELETE FROM NhanVien
    WHERE NhanVienID = @NhanVienID;
END

SET IDENTITY_INSERT ChiTietHoaDonBan OFF
	---------------------Hóa Đơn -------------------------
alter PROCEDURE hoadonID
(
    @MaHoaDonBan int
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

select * from HoaDonBan
select * from ChiTietHoaDonBan
exec hoadonID 20

alter PROCEDURE hoadonCreate
(@KhachHangID       NVARCHAR(50),
@NgayBan			datetime,
@NgayTao			datetime,
 @ThanhTien          float,
 @list_json_chitietdonhangban NVARCHAR(MAX)
)
AS
    BEGIN
		DECLARE @MaHoaDonBan INT;
        INSERT INTO HoaDonBan
                (KhachHangID , 
				NgayBan,
				NgayTao,
                 ThanhTien             
                )
                VALUES
                (@KhachHangID, 
				@NgayBan, 
				@NgayTao,
                 @ThanhTien
                );

				SET @MaHoaDonBan = (SELECT SCOPE_IDENTITY());
                IF(@list_json_chitietdonhangban IS NOT NULL)
                    BEGIN
                        INSERT INTO ChiTietHoaDonBan
						 (MatHangID, 
						  MaHoaDonBan,
                          SoLuong, 
                          GiaBan,
						  TongGia
                        )
                    SELECT JSON_VALUE(p.value, '$.matHangID'), 
                            @MaHoaDonBan, 
                            JSON_VALUE(p.value, '$.soLuong'), 
                            JSON_VALUE(p.value, '$.giaBan'),
							JSON_VALUE(p.value, '$.tongGia')
                    FROM OPENJSON(@list_json_chitietdonhangban) AS p;
                END;
        SELECT '';
    END;

	select * from HoaDonBan
		select * from ChiTietHoaDonBan


alter PROCEDURE hoadonUpdate
(@MaHoaDonBan        int, 
 @KhachHangID       CHAR(10), 
 @NgayBan          datetime,
 @NgayTao			datetime,
 @ThanhTien        float,  
 @list_json_chitietdonhangban NVARCHAR(MAX)
)
AS
    BEGIN
		UPDATE HoaDonBan
		SET
			KhachHangID  = @KhachHangID ,
			NgayBan = @NgayBan,
			NgayTao = @NgayTao,
			ThanhTien = @ThanhTien
		WHERE MaHoaDonBan = @MaHoaDonBan;
		
		IF(@list_json_chitietdonhangban IS NOT NULL) 
		BEGIN
			 -- Insert data to temp table 
		   SELECT
			  JSON_VALUE(p.value, '$.maChiTietHoaDon') as maChiTietHoaDonBan,
			  JSON_VALUE(p.value, '$.maHoaDonBan') as maHoaDonBan,
			  JSON_VALUE(p.value, '$.MatHangID') as matHangID,
			  JSON_VALUE(p.value, '$.SoLuong') as soLuong,
			  JSON_VALUE(p.value, '$.GiaBan') as giaBan,
			  JSON_VALUE(p.value, '$.TongGia') as tongGia,
			  JSON_VALUE(p.value, '$.status') as status
			  INTO #Results 
		   FROM OPENJSON(@list_json_chitietdonhangban) AS p;
		 
		 -- Insert data to table with STATUS = 1;
			INSERT INTO ChiTietHoaDonBan (
						MatHangID, 
						  MaHoaDonBan,
                          SoLuong, 
                          GiaBan,
						  TongGia) 
			   SELECT
				  #Results.matHangID,
				  @MaHoaDonBan,
				  #Results.soLuong,
				  #Results.giaBan,
				  #Results.tongGia	
			   FROM  #Results 
			   WHERE #Results.status = '1' 
			
			-- Update data to table with STATUS = 2
			  UPDATE ChiTietHoaDonBan 
			  SET
				 MatHangID = #Results.matHangID,
				 SoLuong = #Results.soLuong,
				 GiaBan = #Results.giaBan,
				 TongGia = #Results.tongGia
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

	select * from HoaDonBan
			select * from ChiTietHoaDonBan
	EXEC hoadonUpdate 
    @MaHoaDonBan = 22, -- Thay số 123 bằng mã hóa đơn cần cập nhật
    @KhachHangID = 'KH001', -- Thay 'KH001' bằng ID khách hàng mới
    @NgayBan = '2023-12-01', -- Thay '2023-12-01' bằng ngày bán mới
    @NgayTao = '2023-12-01', -- Thay '2023-12-01' bằng ngày tạo mới
    @ThanhTien = 150.5, -- Thay 150.5 bằng số tiền mới
    @list_json_chitietdonhangban = '[
        {"maChiTietHoaDon": "0", "maHoaDonBan": "22", "matHangID": "MH001", "soLuong": 5, "giaBan": 25.5, "tongGia": 127.5}
    ]'; -- Thay phần JSON bằng thông tin chi tiết hóa đơn mới

	-- Tạo thủ tục xóa HoaDonBan
CREATE PROCEDURE hoadonDel
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

----- search hóa đơn
GO
create PROCEDURE hoadonSearch (@page_index  INT, 
                                       @page_size   INT,
									   @ten_khach Nvarchar(50),
									   @fr_NgayTao datetime, 
									   @to_NgayTao datetime
									   )
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
						SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY h.NgayTao ASC)) AS RowNumber, 
                              mh.MatHangID,
							  mh.TenHang,
							  c.SoLuong,
							  c.TongGia,
							  mh.NgayTao,
							  kh.HoTenKH,
							  kh.DiaChiKH
                        INTO #Results1
                        FROM HoaDonBan  h
						inner join ChiTietHoaDonBan c on c.MaHoaDonBan = h.MaHoaDonBan
						inner join MatHang mh on mh.MatHangID = c.MatHangID
						inner join KhachHang kh on kh.KhachHangID = h.KhachHangID
					    WHERE  (@ten_khach = '' Or kh.HoTenKH like N'%'+@ten_khach+'%') and						
						((@fr_NgayTao IS NULL
                        AND @to_NgayTao IS NULL)
                        OR (@fr_NgayTao IS NOT NULL
                            AND @to_NgayTao IS NULL
                            AND mh.NgayTao >= @fr_NgayTao)
                        OR (@fr_NgayTao IS NULL
                            AND @to_NgayTao IS NOT NULL
                            AND mh.NgayTao <= @to_NgayTao)
                        OR (mh.NgayTao BETWEEN @fr_NgayTao AND @to_NgayTao))              
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
                              ORDER BY h.NgayTao ASC)) AS RowNumber, 
                              mh.MatHangID,
							  mh.TenHang,
							  c.SoLuong,
							  c.TongGia,
							  mh.NgayTao,
							  kh.HoTenKH,
							  kh.DiaChiKH
                        INTO #Results2
                        FROM HoaDonBan  h
						inner join ChiTietHoaDonBan c on c.MaHoaDonBan = h.MaHoaDonBan
						inner join MatHang mh on mh.MatHangID = c.MatHangID
						inner join KhachHang kh on kh.KhachHangID = h.KhachHangID
					    WHERE  (@ten_khach = '' Or kh.HoTenKH like N'%'+@ten_khach+'%') and							
						((@fr_NgayTao IS NULL
                        AND @to_NgayTao IS NULL)
                        OR (@fr_NgayTao IS NOT NULL
                            AND @to_NgayTao IS NULL
                            AND mh.NgayTao >= @fr_NgayTao)
                        OR (@fr_NgayTao IS NULL
						AND @to_NgayTao IS NOT NULL
                            AND mh.NgayTao <= @to_NgayTao)
                        OR (mh.NgayTao BETWEEN @fr_NgayTao AND @to_NgayTao))              
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2                        
                        DROP TABLE #Results2; 
        END;
    END;

	EXEC hoadonSearch
    @page_index = 1,  -- Thay thế giá trị này bằng trang muốn truy vấn
    @page_size = 10,  -- Thay thế giá trị này bằng số lượng bản ghi trên mỗi trang
    @ten_khach = 'A',  -- Thay thế bằng tên khách hàng cần tìm kiếm
    @fr_NgayTao = '2020-01-01',  -- Thay thế bằng ngày bắt đầu của khoảng thời gian
    @to_NgayTao = '2023-12-31'  -- Thay thế bằng ngày kết thúc của khoảng thời gian

	select * from KhachHang
	select * from MatHang
	select * from HoaDonBan
	select * from ChiTietHoaDonBan

-------------------MatHang-----------------
-----------------------------------
alter procedure mathangid
(@MatHangID char(10))
as
begin
	Select * 
		from MatHang
		where MatHangID =@MatHangID
end;

exec mathangid 'MH001'
---------------------------------------
alter PROCEDURE mathangCreate 
	
(@LoaiHangID char(10),
@MatHangID char(10),
@TenHang nvarchar(50),
@DVTinh nvarchar(10),
@SoLuong tinyint,
@NgayTao datetime,
@Anh nvarchar(200)
)
as 
	begin
		Insert into MatHang(LoaiHangID, MatHangID, TenHang, DVTinh, SoLuong, NgayTao,Anh )
		values (@LoaiHangID, @MatHangID, @TenHang, @DVTinh, @SoLuong, @NgayTao,@Anh);
	end;
go




select * from MatHang
	-----------------------------------------
alter PROCEDURE mathangUpdate
  (@LoaiHangID char(10),
@MatHangID char(10),
@TenHang nvarchar(50),
@DVTinh nvarchar(10),
@SoLuong tinyint,
@NgayTao datetime,
@Anh nvarchar(200))
AS
BEGIN
    UPDATE MatHang
    SET
        LoaiHangID = @LoaiHangID,
        MatHangID = @MatHangID,
        TenHang = @TenHang,
        DVTinh = @DVTinh,
		SoLuong = @SoLuong,
		NgayTao = @NgayTao,
		Anh =  @Anh
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

CREATE PROCEDURE taikhoanCreate
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

drop proc userUpdate
---------- cập nhật thông tin khách hàng-------------
CREATE PROCEDURE taikhoanUp
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
CREATE PROCEDURE taikhoanDel
    @MaTaiKhoan int
AS
BEGIN
    DELETE FROM TaiKhoan
    WHERE MaTaiKhoan = @MaTaiKhoan
END

---------------------------User-----------------------------

create PROCEDURE getAllMH
AS
BEGIN
    SELECT MH.LoaiHangID,MH.MatHangID, MH.DVTinh,MH.SoLuong,MH.Anh, MH.TenHang, CT.GiaBan, SUM(CT.SoLuong) AS SoLuongDaBan
    FROM MatHang AS MH
    INNER JOIN ChiTietHoaDonBan AS CT ON MH.MatHangID = CT.MatHangID
    GROUP BY MH.LoaiHangID,MH.MatHangID, MH.DVTinh,MH.SoLuong,MH.Anh, MH.TenHang, CT.GiaBan
    ORDER BY MH.TenHang;
END;

alter PROCEDURE TimMatHangTheoTenHang
     @TenHang nvarchar(50)
AS
BEGIN
    SELECT mh.*, 
           (SELECT SUM(ct.SoLuong) FROM ChiTietHoaDonBan AS ct WHERE ct.MatHangID = mh.MatHangID) AS SoLuongDaBan,
           (SELECT TOP 1 ct.GiaBan FROM ChiTietHoaDonBan AS ct WHERE ct.MatHangID = mh.MatHangID ORDER BY mh.NgayTao DESC) AS GiaBan
    FROM MatHang AS mh
    WHERE mh.TenHang = @TenHang;
END;
select * from MatHang
exec TimMatHangTheoTenHang N'Sấu Xào Gừng Tiến Thịnh'

------------------------

ALTER PROCEDURE SearchMatHangByLoaiHang
    @LoaiHangID CHAR(10)
AS
BEGIN
    SELECT mh.LoaiHangID,mh.MatHangID, mh.TenHang, mh.DVTinh, mh.SoLuong, ISNULL(ct.GiaBan, 0) AS GiaBan, ISNULL(SUM(ct.SoLuong), 0) AS SoLuongDaBan,mh.Anh
    FROM MatHang AS mh
    LEFT JOIN ChiTietHoaDonBan AS ct ON mh.MatHangID = ct.MatHangID
    WHERE mh.LoaiHangID = @LoaiHangID
    GROUP BY mh.LoaiHangID,mh.MatHangID, mh.TenHang, mh.DVTinh, mh.SoLuong, ct.GiaBan,mh.Anh;
END;

EXEC SearchMatHangByLoaiHang @LoaiHangID = 'LH001';

---------------sản phẩm bán chạy nhất--------------
alter PROCEDURE TopSellingProduct
(@soluong int)
AS
BEGIN
    SELECT TOP (@soluong) MH.MatHangID,MH.LoaiHangID, LH.TenLH, MH.TenHang, MH.DVTinh,MH.SoLuong, MH.Anh,SUM(CTHDB.SoLuong) AS SoLuongDaBan, CTHDB.GiaBan
    FROM MatHang AS MH
    INNER JOIN ChiTietHoaDonBan AS CTHDB ON MH.MatHangID = CTHDB.MatHangID
    INNER JOIN LoaiHang AS LH ON MH.LoaiHangID = LH.LoaiHangID
    GROUP BY MH.MatHangID,MH.LoaiHangID, LH.TenLH, MH.TenHang, MH.DVTinh, MH.SoLuong,MH.Anh,CTHDB.GiaBan
    ORDER BY SoLuongDaBan DESC;
END;

select * from HoaDonBan
select * from ChiTietHoaDonBan

exec TopSellingProduct '3';

---------------tìm kiếm sản phẩm theo giá bán--------------
ALTER PROCEDURE TimSanPhamTheoGiaBan
(
    @GiaBan int
)
AS
BEGIN
    SELECT mh.LoaiHangID, mh.Anh, mh.MatHangID, mh.TenHang, mh.DVTinh, mh.SoLuong AS SoLuong, mh.NgayTao, cthdb.GiaBan, SUM(cthdb.SoLuong) AS SoLuongDaBan
    FROM MatHang AS mh
    INNER JOIN ChiTietHoaDonBan AS cthdb ON mh.MatHangID = cthdb.MatHangID
    WHERE cthdb.GiaBan >= @GiaBan
    GROUP BY mh.LoaiHangID, mh.Anh, mh.MatHangID, mh.TenHang, mh.DVTinh, mh.SoLuong, mh.NgayTao, cthdb.GiaBan
    ORDER BY mh.TenHang;
END;

create PROCEDURE TimSanPhamDuoiGia100000
AS
BEGIN
    SELECT mh.LoaiHangID, mh.Anh, mh.MatHangID, mh.TenHang, mh.DVTinh, mh.SoLuong AS SoLuong, mh.NgayTao, cthdb.GiaBan, SUM(cthdb.SoLuong) AS SoLuongDaBan
    FROM MatHang AS mh
    INNER JOIN ChiTietHoaDonBan AS cthdb ON mh.MatHangID = cthdb.MatHangID
    WHERE cthdb.GiaBan < 100000 -- Lấy các sản phẩm có giá dưới 50000
    GROUP BY mh.LoaiHangID, mh.Anh, mh.MatHangID, mh.TenHang, mh.DVTinh, mh.SoLuong, mh.NgayTao, cthdb.GiaBan
    ORDER BY mh.TenHang;
END;

ALTER PROCEDURE TimSanPhamGia100000_200000
AS
BEGIN
    SELECT mh.LoaiHangID, mh.Anh, mh.MatHangID, mh.TenHang, mh.DVTinh, mh.SoLuong AS SoLuong, mh.NgayTao, cthdb.GiaBan, SUM(cthdb.SoLuong) AS SoLuongDaBan
    FROM MatHang AS mh
    INNER JOIN ChiTietHoaDonBan AS cthdb ON mh.MatHangID = cthdb.MatHangID
    WHERE cthdb.GiaBan >= 100000 and  cthdb.GiaBan <= 200000-- Lấy các sản phẩm có giá dưới 50000
    GROUP BY mh.LoaiHangID, mh.Anh, mh.MatHangID, mh.TenHang, mh.DVTinh, mh.SoLuong, mh.NgayTao, cthdb.GiaBan
    ORDER BY mh.TenHang;
END;




exec TimSanPhamTheoGiaBan '1';

select * from MatHang


---- Top những sản phẩm mới nhất
create PROCEDURE GetTopNNewestMatHang(@New int)
AS
BEGIN
    SELECT TOP (@New)mh.LoaiHangID, mh.MatHangID, mh.TenHang, mh.DVTinh, mh.SoLuong, mh.NgayTao,  ct.GiaBan,
    FROM MatHang as mh, ChiTietHoaDonBan as ct
    ORDER BY NgayTao DESC;
END;


exec giaBanMaxMin;

select * from MatHang

alter PROCEDURE giaBanMinMax
AS
BEGIN
    SELECT mh.LoaiHangID, mh.MatHangID, mh.TenHang, mh.DVTinh, mh.SoLuong, mh.NgayTao,mh.Anh,  CHDB.GiaBan,
           ISNULL(SUM(CHDB.SoLuong), 0) AS SoLuongDaBan
    FROM ChiTietHoaDonBan CHDB
    INNER JOIN MatHang MH ON CHDB.MatHangID = MH.MatHangID
    LEFT JOIN HoaDonBan HDB ON CHDB.MaHoaDonBan = HDB.MaHoaDonBan
    GROUP BY mh.LoaiHangID, mh.MatHangID, mh.TenHang, mh.DVTinh, mh.SoLuong, mh.NgayTao,mh.Anh,  CHDB.GiaBan
    ORDER BY CHDB.GiaBan ASC;
END;

alter PROCEDURE giaBanMaxMin
AS
BEGIN
    SELECT mh.LoaiHangID, mh.MatHangID, mh.TenHang, mh.DVTinh, mh.SoLuong, mh.NgayTao,mh.Anh,  CHDB.GiaBan,
           ISNULL(SUM(CHDB.SoLuong), 0) AS SoLuongDaBan
    FROM ChiTietHoaDonBan CHDB
    INNER JOIN MatHang MH ON CHDB.MatHangID = MH.MatHangID
    LEFT JOIN HoaDonBan HDB ON CHDB.MaHoaDonBan = HDB.MaHoaDonBan
    GROUP BY mh.LoaiHangID, mh.MatHangID, mh.TenHang, mh.DVTinh, mh.SoLuong, mh.NgayTao,mh.Anh,  CHDB.GiaBan
    ORDER BY CHDB.GiaBan DESC;
END;

CREATE PROCEDURE FindTopNewProducts
    @TopProducts int
AS
BEGIN
    SELECT TOP(@TopProducts) mh.*, cthdb.SoLuong AS SoLuongDaBan, cthdb.GiaBan
    FROM MatHang mh
    LEFT JOIN (
        SELECT MatHangID, SUM(SoLuong) AS SoLuong, AVG(GiaBan) AS GiaBan
        FROM ChiTietHoaDonBan
        GROUP BY MatHangID
    ) cthdb ON mh.MatHangID = cthdb.MatHangID
    ORDER BY mh.NgayTao DESC;
END;

exec FindTopNewProducts 6