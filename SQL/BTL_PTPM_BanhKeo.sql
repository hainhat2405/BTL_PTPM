create database BTL_PTPM_BanhKeo
use BTL_PTPM_BanhKeo


go
create table LoaiHang
(
	LoaiHangID char(10)  NOT NULL primary key	,
	TenLH nvarchar(60)
)
go
create table MatHang
(
	LoaiHangID char(10) foreign key references LoaiHang(LoaiHangID),
	MatHangID char(10) primary key,
	TenHang nvarchar(50),
	DVTinh nvarchar(10),
	Anh nvarchar(200),
	NgayTao datetime
)
ALTER TABLE MatHang

ADD Anh nvarchar(50);
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

create table HoaDonBan(
MaHoaDonBan int identity(1,1) not null primary key,
KhachHangID char(10),
NgayBan datetime,
ThanhTien float,
NgayTao datetime,
FOREIGN KEY (KhachHangID) REFERENCES KhachHang(KhachHangID) ON DELETE CASCADE ON UPDATE CASCADE,
);

create table ChiTietHoaDonBan(
MaChiTietHoaDonBan int identity(1,1) not null primary key,
MaHoaDonBan int,
MatHangID char(10),
SoLuong int, 
GiaBan float,
TongGia int,
FOREIGN KEY (MaHoaDonBan) REFERENCES HoaDonBan (MaHoaDonBan) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY (MatHangID) REFERENCES MatHang (MatHangID) ON DELETE CASCADE ON UPDATE CASCADE,
);
select * from ChiTietHoaDonBan
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
	DonHangNhapID char(10) primary key,
	MatHangID char(10) foreign key references MatHang(MatHangID) on delete cascade on update cascade,
	SLNhap tinyint,
	DGNhap float
	
)

create table TaiKhoan
(
	MaTaiKhoan int primary key,
	MaLoai int,
	TenTaiKhoan nvarchar(50) NULL,
	MatKhau nvarchar(50) NULL,
	Email nvarchar(150) NULL
)

create table LoaiTk
(
	MaLoai int primary key,
	TenLoai nvarchar(50) NULL,
	MoTa nvarchar(250) NULL
)

create table ChiTietTaiKhoan
(
	MaChitietTaiKhoan int  primary key,
	MaTaiKhoan int NULL foreign key references TaiKhoan(MaTaiKhoan) on delete cascade on update cascade,
	HoTen nvarchar(50) NULL,
	DiaChi nvarchar(250) NULL,
	SoDienThoai nvarchar(11) NULL,
)



INSERT INTO LoaiHang (LoaiHangID, TenLH)
VALUES
    ('LH001', N'Bánh Quy Homey Mè Gói 100g'),
    ('LH002', N'Snack Lays Vị Khoai Tây Tự Nhiên Classic Gói 95g'),
    ('LH003', N'Snack Bắp Oishi Cay 4 Lớp Sốt Sriracha 39G'),
    ('LH004', N'Bánh Bauli Moonfils Vị Vani 45G'),
    ('LH005', N'Bánh Bauli Moonfils Vị Dâu 45G')

INSERT INTO MatHang (LoaiHangID, MatHangID, TenHang, DVTinh, SoLuong)
VALUES
    ('LH001', 'MH001', N'Bánh Quy Homey Mè Gói 100g', N'Gói', 20),
    ('LH002', 'MH003', N'Snack Bắp Oishi Cay 4 Lớp Sốt Sriracha 39G', N'Gói', 10),
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
INSERT INTO HoaDonBan (KhachHangID, NgayBan, ThanhTien)
VALUES
('KH001', '2023-10-24 08:00:00', 1000.50),
('KH002', '2023-10-25 14:30:00', 750.25),
('KH003', '2023-10-26 10:15:00', 1200.75);

-- Chèn dữ liệu vào bảng ChiTietHoaDonBan
INSERT INTO ChiTietHoaDonBan (MaHoaDonBan, MatHangID, SoLuong, GiaBan)
VALUES
(1, 'MH001', 5, 50.00),
(1, 'MH002', 3, 30.00),
(2, 'MH001', 2, 50.00),
(3, 'MH003', 4, 45.50);

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


INSERT INTO ChiTietDHN (DonHangNhapID, MatHangID, SLNhap, DGNhap)
VALUES
    ('DHN001', 'MH001', 10, 90000),
    ('DHN002', 'MH003', 3, 70000),
    ('DHN003', 'MH005', 4, 50000)

INSERT INTO TaiKhoan (MaTaiKhoan, MaLoai, TenTaiKhoan, MatKhau,Email)
VALUES
    ('1', '1', 'admin1', '123','hghrhg@gmail.com'),
	('2', '2', 'use', '1234','gredfg@gmail.com')

INSERT INTO LoaiTk (MaLoai, TenLoai, MoTa)
VALUES
    ('1', 'admin', 'quan ly'),
	('2', 'use', 'nguoi dung')

INSERT INTO ChiTietTaiKhoan (MaChitietTaiKhoan, MaTaiKhoan, HoTen,DiaChi,SoDienThoai)
VALUES
    ('1', '1', 'Nhat','VanGiang','0987654321'),
	('2', '2', 'Duc','HungYen','0984654321')

select * from TaiKhoan

