create database BTL_PTPM_BanHang
use BTL_PTPM_BanHang


go
create table LoaiHang
(
	LoaiHangID char(10) primary key	,
	TenLH nvarchar(60)
)
go
create table MatHang
(
	LoaiHangID char(10) foreign key references LoaiHang(LoaiHangID),
	MatHangID char(10) primary key,
	TenHang nvarchar(50),
	DVTinh nvarchar(10),
	SLTon tinyint,
)
go
create table NhanVien
(
	NhanVienID char(10) primary key,
	HoTenNV nvarchar(30),
	GioiTinhNV nvarchar(50),
	NgaySinhNV date,
	DiaChiNV nvarchar(50),
	EmailNV char(30),	
	SdtNV char(10),
	Matkhau char(10)
)
go
create table NhaCC
(
	NhaCCID char(10) primary key,
	TenNCC nvarchar(30),
	DiaChiNCC nvarchar(50),
	SdtNCC char(10)	
)
go
create table KhachHang
(
	KhachHangID char(10) primary key,
	HoTenKH nvarchar(30),
	DiaChiKH nvarchar(50),
	EmailKH char(30),
	SdtKH char(10)
)

go
create table DonHangBan
(
	DonHangBanID char(10) primary key,
	NhanVienID char(10) foreign key references NhanVien(NhanVienID) on delete cascade on update cascade,	
	KhachHangID char(10) foreign key references KhachHang(KhachHangID) on delete cascade on update cascade,
	NgayBan datetime,
	TrietKhauBan float
)
go
create table ChiTietDHB
(
	DonHangBanID char(10) foreign key references DonHangBan(DonHangBanID) on delete cascade on update cascade,
	MatHangID char(10) foreign key references MatHang(MatHangID) on delete cascade on update cascade,
	SLBan tinyint,
	DGBan float
	constraint P_CTDHN primary key(DonHangBanID,MatHangID)
)


go
create table DonHangNhap
(
	DonHangNhapID char(10) primary key,
	NhanVienID char(10) foreign key references NhanVien(NhanVienID) on delete cascade on update cascade,
	NhaCCID char(10) foreign key references NhaCC(NhaCCID) on delete cascade on update cascade,
	NgayNhap date,
	TrietKhauNhap float
)
go
create table ChiTietDHN
(
	DonHangNhapID char(10),
	MatHangID char(10) foreign key references MatHang(MatHangID) on delete cascade on update cascade,
	SLNhap tinyint,
	DGNhap float
	constraint P_CHDHN primary key(DonHangNhapID,MatHangID)
)

INSERT INTO LoaiHang (LoaiHangID, TenLH)
VALUES
    ('LH001', N'Bánh Quy Homey Mè Gói 100g'),
    ('LH002', N'Snack Lays Vị Khoai Tây Tự Nhiên Classic Gói 95g'),
    ('LH003', N'Snack Bắp Oishi Cay 4 Lớp Sốt Sriracha 39G'),
    ('LH004', N'Bánh Bauli Moonfils Vị Vani 45G'),
    ('LH005', N'Bánh Bauli Moonfils Vị Dâu 45G')

INSERT INTO MatHang (LoaiHangID, MatHangID, TenHang, DVTinh, SLTon)
VALUES
    ('LH001', 'MH001', N'Bánh Quy Homey Mè Gói 100g', N'Gói', 20),
    ('LH001', 'MH002', N'Snack Lays Vị Khoai Tây Tự Nhiên Classic Gói 95g', N'Gói', 15),
    ('LH002', 'MH003', N'Snack Bắp Oishi Cay 4 Lớp Sốt Sriracha 39G', N'Gói', 10),
    ('LH002', 'MH004', N'Bánh Bauli Moonfils Vị Vani 45G', N'Gói', 12),
    ('LH003', 'MH005', N'Bánh Bauli Moonfils Vị Dâu 45G', N'Gói', 8)


INSERT INTO NhanVien (NhanVienID, HoTenNV, GioiTinhNV, NgaySinhNV, DiaChiNV, EmailNV, SdtNV, Matkhau)
VALUES
    ('NV001', N'Nguyễn Văn A', N'Nam', '1990-01-01', N'Hà Nội', 'nva@example.com', '1234567890', 'password1'),
    ('NV002', N'Trần Thị B', N'Nữ', '1995-05-10', N'Hồ Chí Minh', 'nvb@example.com', '0987654321', 'password2'),
    ('NV003', N'Lê Minh C', N'Nam', '1992-08-15', N'Đà Nẵng', 'nvc@example.com', '0123456789', 'password3'),
    ('NV004', N'Phạm Thanh D', N'Nam', '1988-06-20', N'Hải Phòng', 'nvd@example.com', '0912345678', 'password4'),
    ('NV005', N'Nguyễn Thị E', N'Nữ', '1993-03-05', N'Cần Thơ', 'nve@example.com', '0987654321', 'password5'),
    ('NV006', N'Trần Văn F', N'Nam', '1991-12-10', N'Hà Nội', 'nvf@example.com', '0123456789', 'password6'),
    ('NV007', N'Phạm Thị G', N'Nữ', '1996-09-25', N'Hồ Chí Minh', 'nvg@example.com', '0912345678', 'password7'),
    ('NV008', N'Lê Văn H', N'Nam', '1994-04-15', N'Đà Nẵng', 'nvh@example.com', '0987654321', 'password8'),
    ('NV009', N'Nguyễn Thị I', N'Nữ', '1990-07-20', N'Hải Phòng', 'nvi@example.com', '0123456789', 'password9'),
    ('NV010', N'Trần Văn J', N'Nam', '1989-02-05', N'Cần Thơ', 'nvj@example.com', '0912345678', 'password10');

INSERT INTO KhachHang (KhachHangID, HoTenKH, DiaChiKH, EmailKH, SdtKH)
VALUES
    ('KH001', N'Nguyễn Thị A', N'Hà Nội', 'kha@example.com', '0123456789'),
    ('KH002', N'Trần Văn B', N'Hồ Chí Minh', 'khb@example.com', '0987654321'),
    ('KH003', N'Lê Thị C', N'Đà Nẵng', 'khc@example.com', '0123456789'),
    ('KH004', N'Phạm Văn D', N'Hải Phòng', 'khd@example.com', '0912345678'),
    ('KH005', N'Nguyễn Thị E', N'Cần Thơ', 'khe@example.com', '0987654321'),
    ('KH006', N'Trần Văn F', N'Hà Nội', 'khf@example.com', '0123456789'),
    ('KH007', N'Phạm Thị G', N'Hồ Chí Minh', 'khg@example.com', '0912345678'),
    ('KH008', N'Lê Văn H', N'Đà Nẵng', 'khh@example.com', '0987654321'),
    ('KH009', N'Nguyễn Thị I', N'Hải Phòng', 'khi@example.com', '0123456789'),
    ('KH010', N'Trần Văn J', N'Cần Thơ', 'khj@example.com', '0912345678');

INSERT INTO NhaCC (NhaCCID, TenNCC, DiaChiNCC, SdtNCC)
VALUES
    ('NCC001', N'Công ty A', N'Hà Nội', '0123456789'),
    ('NCC002', N'Công ty B', N'Hồ Chí Minh', '0987654321'),
    ('NCC003', N'Công ty C', N'Đà Nẵng', '0123456789'),
    ('NCC004', N'Công ty D', N'Hải Phòng', '0912345678'),
    ('NCC005', N'Công ty E', N'Cần Thơ', '0987654321'),
    ('NCC006', N'Công ty F', N'Hà Nội', '0123456789'),
    ('NCC007', N'Công ty G', N'Hồ Chí Minh', '0912345678'),
    ('NCC008', N'Công ty H', N'Đà Nẵng', '0987654321'),
    ('NCC009', N'Công ty I', N'Hải Phòng', '0123456789'),
    ('NCC010', N'Công ty J', N'Cần Thơ', '0912345678');

INSERT INTO DonHangBan (DonHangBanID, NhanVienID, KhachHangID, NgayBan, TrietKhauBan)
VALUES
    ('DHB001', 'NV001', 'KH001', '2023-05-01 09:00:00', 0.1),
    ('DHB002', 'NV002', 'KH002', '2023-05-02 10:30:00', 0.05),
    ('DHB003', 'NV003', 'KH003', '2023-05-03 11:45:00', 0),
    ('DHB004', 'NV004', 'KH004', '2023-05-04 14:20:00', 0.15),
    ('DHB005', 'NV005', 'KH005', '2023-05-05 15:55:00', 0.1),
    ('DHB006', 'NV006', 'KH006', '2023-05-06 16:40:00', 0),
    ('DHB007', 'NV007', 'KH007', '2023-05-07 17:15:00', 0.05),
    ('DHB008', 'NV008', 'KH008', '2023-05-08 18:30:00', 0),
    ('DHB009', 'NV009', 'KH009', '2023-05-09 19:45:00', 0.1),
    ('DHB010', 'NV010', 'KH010', '2023-05-10 20:20:00', 0.05);

INSERT INTO DonHangNhap (DonHangNhapID, NhanVienID, NhaCCID, NgayNhap, TrietKhauNhap)
VALUES
    ('DHN001', 'NV001', 'NCC001', '2023-05-01', 0.1),
    ('DHN002', 'NV002', 'NCC002', '2023-05-02', 0.05),
    ('DHN003', 'NV003', 'NCC003', '2023-05-03', 0),
    ('DHN004', 'NV004', 'NCC004', '2023-05-04', 0.15),
    ('DHN005', 'NV005', 'NCC005', '2023-05-05', 0.1),
    ('DHN006', 'NV006', 'NCC006', '2023-05-06', 0),
    ('DHN007', 'NV007', 'NCC007', '2023-05-07', 0.05),
    ('DHN008', 'NV008', 'NCC008', '2023-05-08', 0),
    ('DHN009', 'NV009', 'NCC009', '2023-05-09', 0.1),
    ('DHN010', 'NV010', 'NCC010', '2023-05-10', 0.05)

INSERT INTO ChiTietDHB (DonHangBanID, MatHangID, SLBan, DGBan)
VALUES
    ('DHB001', 'MH001', 5, 100000),
    ('DHB001', 'MH002', 3, 50000),
    ('DHB002', 'MH003', 2, 80000),
    ('DHB002', 'MH004', 4, 120000),
    ('DHB003', 'MH001', 1, 100000)


INSERT INTO ChiTietDHN (DonHangNhapID, MatHangID, SLNhap, DGNhap)
VALUES
    ('DHN001', 'MH001', 10, 90000),
    ('DHN001', 'MH002', 5, 60000),
    ('DHN002', 'MH003', 3, 70000),
    ('DHN002', 'MH004', 8, 110000),
    ('DHN003', 'MH005', 4, 50000)