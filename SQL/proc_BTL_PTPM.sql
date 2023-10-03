Use BTL_PTPM_BanHang

CREATE PROCEDURE TimKiemKhachHangTheoID
    @KhachHangID char(10)
AS
BEGIN
    SELECT *
    FROM KhachHang
    WHERE KhachHangID = @KhachHangID
END

	
		
	drop proc [dbo].[sp_khach_get_by_id]
	--------------- 
Use BTL_PTPM_BanHang
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
