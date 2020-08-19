use master
go
if db_id('QLDA') is not null
	drop database QLDA
go
create database QLDA
go
use QLDA
go
--tạo bảng
create table NHANVIEN
(
	HONV nvarchar(30),
	TENLOT nvarchar(30),
	TENNV nvarchar(30),
	MANV varchar(9),
	NGSINH date,
	DCHI nvarchar(90),
	PHAI nvarchar(9),
	LUONG float,
	MA_NQL varchar(9),
	PHG int
	--khóa chinh
	constraint PK_NHANVIEN
	primary key (MANV)
)
create table PHONGBAN
(
	MAPHG int,
	TENPHG nvarchar(30),
	TRPHG varchar(9),
	NG_NHANCHUC date
	--khóa chính
	constraint PK_PHONGBAN
	primary key (MAPHG)
)
create table DIADIEM_PHG
(
	MAPHG int,
	DIADIEM nvarchar(30)
	--khóa chính
	constraint PK_DIADIEM_PHG
	primary key (MAPHG, DIADIEM)
)
create table DEAN
(
	TENDA nvarchar(30),
	MADA int,
	DDIEM_DA nvarchar(30),
	PHONG int
	--khóa chính
	constraint PK_DEAN
	primary key (MADA)
)
create table CONGVIEC
(
	MADA int,
	STT int,
	TEN_CONG_VIEC nvarchar(100)
	--khóa chính
	constraint PK_CONGVIEC
	primary key (MADA, STT)
)
create table PHANCONG
(
	MA_NVIEN varchar(9),
	MADA int,
	STT int,
	THOIGIAN float
	--khóa chính
	constraint PK_PHANCONG
	primary key (MA_NVIEN, MADA, STT)
)
create table THANNHAN
(
	MA_NVIEN varchar(9),
	TENTN nvarchar(30),
	PHAI nvarchar(9),
	NGSINH date,
	QUANHE nvarchar(30)
	--khóa chính
	constraint PK_THANNHAN
	primary key (MA_NVIEN, TENTN)
)
go
--tạo khóa ngoại
alter table NHANVIEN
add
	constraint FK_NHANVIEN
	foreign key (MA_NQL) references NHANVIEN(MANV),
	constraint FK_NHANVIEN_PHONGBAN
	foreign key (PHG) references PHONGBAN(MAPHG)

alter table PHONGBAN
add
	constraint FK_PHONGBAN_NHANVIEN
	foreign key (TRPHG) references NHANVIEN(MANV)

alter table DIADIEM_PHG
add
	constraint FK_DDPHG_PHONGBAN
	foreign key (MAPHG) references PHONGBAN(MAPHG)

alter table DEAN
add
	constraint FK_DEAN_PHONGBAN
	foreign key (PHONG) references PHONGBAN(MAPHG)

alter table CONGVIEC
add
	constraint FK_CONGVIEC_DEAN
	foreign key (MADA) references DEAN(MADA)

alter table PHANCONG
add
	constraint FK_PHANCONG_NHANVIEN
	foreign key (MA_NVIEN) references NHANVIEN(MANV),
	constraint FK_PHANCONG_CONGVIEC
	foreign key (MADA, STT) references CONGVIEC(MADA, STT)

alter table THANNHAN
add
	constraint FK_THANNHAN_NHANVIEN
	foreign key (MA_NVIEN) references NHANVIEN(MANV)
go