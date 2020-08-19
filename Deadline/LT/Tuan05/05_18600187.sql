use master
go
if db_id('QLDA') is not null
	drop database QLDA
go
create database QLDA
go
use QLDA
go

--TẠO BẢNG
create table NHANVIEN
(
	HONV nvarchar(30),
	TENLOT nvarchar(30),
	TENNV nvarchar(30),
	MANV nvarchar(9),
	NGSINH date,
	DIACHI nvarchar(30),
	PHAI nvarchar(3),
	LUONG float,
	MA_NQL nvarchar(9),
	PHG int,
	constraint PK_NHANVIEN
	primary key (MANV)
)
create table PHONGBAN
(
	TENPHG nvarchar(30),
	MAPHG int,
	TRPHG nvarchar(9),
	NG_NHANCHUC date
	constraint PK_PHONGBAN
	Primary key (MAPHG)
)

create table DIADIEM_PHG
(
	MAPHG int,
	DIADIEM nvarchar(30)
	constraint PK_DIADIEM_PHG
	primary key (MAPHG,DIADIEM)
)

create table DEAN
(
	TENDA nvarchar(15),
	MADA int,
	DIADIEM_DA nvarchar(15),
	PHONG int
	constraint PK_DEAN
	primary key (MADA)
)

create table CONGVIEC
(
	MADA int,
	STT int,
	TEN_CONG_VIEC nvarchar(50)
	constraint PK_CONGVIEC
	primary key(MADA,STT)
)

create table PHANCONG
(
	MA_NVIEN nvarchar(9),
	MADA int,
	STT int,
	THOIGIAN float
	constraint PK_PHANCONG
	primary key(MADA,STT,MA_NVIEN)
)

create table THANNHAN
(
	MA_NVIEN nvarchar(9),
	TENTN nvarchar(30),
	PHAI nvarchar(3),
	NGSINH date,
	QUANHE nvarchar(15)
	constraint PK_THANNHAN
	primary key (MA_NVIEN,TENTN)
)

--TẠO KHÓA NGOẠI
alter table NHANVIEN
add
	constraint FK_NV_PHONGBAN
	foreign key(PHG)
	references PHONGBAN

alter table NHANVIEN
add
	constraint FK_NV_NV
	foreign key(MA_NQL)
	references NHANVIEN

alter table DIADIEM_PHG
add 
	constraint FK_DD_PHONGBAN
	foreign key(MAPHG)
	references PHONGBAN

alter table PHONGBAN
add 
	constraint FK_PB_NV
	foreign key(TRPHG)
	references NHANVIEN

alter table DEAN
add
	constraint FK_DA_PHG
	foreign key(PHONG)
	references PHONGBAN

alter table CONGVIEC
add
	constraint FK_CONGVIEC
	foreign key(MADA)
	references DEAN

alter table PHANCONG
add 
	constraint FK_NHANVIEN
	foreign key(MA_NVIEN)
	references NHANVIEN

alter table PHANCONG
add
	constraint FK_PC_CV
	foreign key(MADA,STT)
	references CONGVIEC

alter table THANNHAN
add
	constraint FK_THANNHAN
	foreign key(MA_NVIEN)
	references NHANVIEN

--NHẬP LIỆU
insert PHONGBAN (TENPHG, MAPHG, NG_NHANCHUC)
VALUES 
(N'Nghiên cứu', 5, '05/22/1978'),
(N'Điều hành', 4, '01/01/1985'),
(N'Quản lý', 1, '06/19/1971')

INSERT DEAN (TENDA, MADA, DIADIEM_DA, PHONG)
VALUES
(N'Sản phẩm X', 1, N'Vũng Tàu', 5),
(N'Sản phẩm Y', 2, 'Nha Trang', 5),
(N'Sản phẩm Z', 3, 'TP HCM', 5),
(N'Tin học hóa', 10, N'Hà Nội', 4),
(N'Cáp quang', 20, 'TP HCM', 1),
(N'Đào tạo', 30, N'Hà Nội', 4)

INSERT CONGVIEC (MADA, STT, TEN_CONG_VIEC)
VALUES
(1, 1, N'Thiết kế sản phẩm X'),
(1, 2, N'Thử nghiệm sản phẩm X'),
(2, 1, N'Sản xuất sản phẩm Y'),
(2, 2, N'Quảng cáo sản phẩm Y'),
(3, 1, N'Khuyến mãi sản phẩm Z'),
(10, 1, N'Tin học hóa phòng nhân sự'),
(10, 2, N'Tin học hóa phòng kinh doanh'),
(20, 1, N'Lắp đặt cáp quang'),
(30, 1, N'Đào tạo nhân viên Marketing'),
(30, 2, N'Đào tạo chuyên viên thiết kế')

INSERT DIADIEM_PHG (MAPHG, DIADIEM)
VALUES
(1, 'TP HCM'),
(4, N'HÀ NỘI'),
(5, N'VŨNG TÀU'),
(5, 'NHA TRANG'),
(5, 'TP HCM')

INSERT NHANVIEN (HONV, TENLOT, TENNV, MANV, NGSINH, DIACHI, PHAI, LUONG, MA_NQL, PHG)
VALUES 
(N'Phạm', N'Văn', 'Vinh', '006', '01/01/1965', N'45 Trưng Vương, Hà Nội', N'Nữ', 55000, NULL, 1), 
(N'Lê', N'Quỳnh', N'Như', '001', '02/01/1967', N'291 Hồ Văn Huê, Tp HCM', N'Nữ', 43000, '006', 4),
(N'Nguyễn', 'Thanh', N'Tùng', '005', '08/20/1962', N'222 Nguyễn Văn Cừ, Tp HCM', 'Nam', 40000, '006', 5),
(N'Đinh', N'Bá', N'Tiến', '009', '02/11/1960', N'119 Cống Quỳnh, Tp HCM', 'Nam', 30000, '005', 5),
(N'Bùi', N'Ngọc', N'Hằng', '007', '03/11/1954', N'332 Nguyễn Thái Học, Tp HCM', 'Nam', 25000, '001', 4),
(N'Nguyễn', N'Mạnh', N'Hùng', '004', '03/04/1967', N'95 Bà Rịa, Vũng Tàu', 'Nam', 38000, '005', 5),
(N'Trần', 'Thanh', N'Tâm', '003', '05/04/1957', N'34 Mai Thị Lự, Tp HCM', 'Nam', 25000, '005', 5),
(N'Trần', N'Hồng', 'Quang', '008', '09/01/1967', N'80 Lê Hồng Phong, Tp HCM', 'Nam', 25000, '001', 4)

UPDATE PHONGBAN
SET TRPHG = '005'
WHERE MAPHG = 5

UPDATE PHONGBAN
SET TRPHG = '008'
WHERE MAPHG = 4

UPDATE PHONGBAN
SET TRPHG = '006'
WHERE MAPHG = 1

INSERT THANNHAN (MA_NVIEN, TENTN, PHAI, NGSINH, QUANHE)
VALUES
('005', 'Trinh', N'Nữ', '04/05/1976', N'Con gái'),
('005', 'Khang', 'Nam', '10/25/1973', 'Con trai'),
('005', N'Phương', N'Nữ', '05/03/1948', N'Vợ chồng'),
('001', 'Minh', 'Nam', '02/29/1932', N'Vợ chồng'),
('009', N'Tiến', 'Nam', '01/01/1978', 'Con trai'),
('009', N'Châu', N'Nữ', '12/30/1978', N'Con gái'),
('009', N'Phương', N'Nữ', '05/05/1957', N'Vợ chồng')

INSERT PHANCONG (MA_NVIEN, MADA, STT, THOIGIAN)
VALUES
('009', 1, 1, 32),
('009', 2, 2, 8),
('004', 3, 1, 40),
('003', 1, 2, 20),
('003', 2, 1, 20),
('008', 10, 1, 35),
('008', 30, 2, 5),
('001', 30, 1, 20),
('001', 20, 1, 15),
('006', 20, 1, 30),
('005', 3, 1, 10),
('005', 10, 2, 10),
('005', 20, 1, 10),
('007', 30, 2, 30),
('007', 10, 2, 10)

-- TRUY VẤN TUẦN 5
-- ĐỀ 2 - CÂU 5
SELECT DISTINCT NV.*
FROM NHANVIEN NV JOIN (SELECT PB.MAPHG, DP.DIADIEM
					FROM PHONGBAN PB JOIN DIADIEM_PHG DP ON PB.MAPHG = DP.MAPHG) DDP ON DDP.MAPHG = NV.PHG
				JOIN (SELECT DA.DIADIEM_DA, PC.MA_NVIEN
					FROM PHANCONG PC JOIN DEAN DA ON PC.MADA = DA.MADA) DD ON DD.MA_NVIEN = NV.MANV
WHERE DDP.DIADIEM <> DD.DIADIEM_DA

-- ĐỀ 2 - CÂU 6
SELECT DA.DIADIEM_DA, (SELECT COUNT(MADA)
			           FROM DEAN A
			           WHERE A.DIADIEM_DA = DA.DIADIEM_DA) SLDA, (SELECT COUNT (MADA)
												                  FROM PHANCONG PC
												                  WHERE PC.MADA NOT IN (SELECT B.MADA
																						FROM DEAN B
																						WHERE PC.MADA = B.MADA)) SLCVCPC
FROM DEAN DA

-- ĐỀ 2 - CÂU 7
SELECT PC.MADA, PC.DIADIEM_DA, PC.TENDA, SUM(PC.THOIGIAN) TONGTHOIGIAN
FROM NHANVIEN NV JOIN (SELECT PB.MAPHG, PB.TENPHG
					   FROM PHONGBAN PB) PHG ON PHG.MAPHG = NV.PHG
				 JOIN (SELECT CV.MA_NVIEN, CV.THOIGIAN, DA.*
					   FROM PHANCONG CV JOIN DEAN DA ON CV.MADA = DA.MADA) PC ON NV.MANV = PC.MA_NVIEN
WHERE PHG.TENPHG = N'Quản lý'
GROUP BY NV.MANV, PC.THOIGIAN, PC.MADA, PC.DIADIEM_DA, PC.TENDA
HAVING SUM(PC.THOIGIAN) > 35

-- ĐỀ 2 - CÂU 8
SELECT KQ.*
FROM  NHANVIEN KQ 
WHERE  KQ.HONV+KQ.TENLOT+KQ.TENNV <> N'ĐinhBáTiến'
AND NOT EXISTS (SELECT C.MADA
				FROM PHANCONG C JOIN NHANVIEN NV ON NV.MANV = C.MA_NVIEN
				WHERE NV.HONV+NV.TENLOT+NV.TENNV = N'ĐinhBáTiến'
				EXCEPT 
				SELECT BC.MADA
				FROM PHANCONG BC
				WHERE BC.MA_NVIEN = KQ.MANV)

-- ĐỀ 3 - CÂU 5
SELECT *
FROM DEAN DA JOIN (SELECT PB.MAPHG, DP.DIADIEM
					FROM PHONGBAN PB JOIN DIADIEM_PHG DP ON PB.MAPHG = DP.MAPHG) DD ON DD.MAPHG = DA.PHONG
WHERE DA.TENDA LIKE N'Sản phẩm%' AND DD.DIADIEM <> DA.DIADIEM_DA

-- ĐỀ 3 - CÂU 6
SELECT NV.HONV + ' ' + NV.TENLOT + ' ' + NV.TENNV HOTEN, (SELECT COUNT(DISTINCT MADA)
			  FROM PHANCONG PC
			  WHERE PC.MA_NVIEN = NV.MANV) SLDA, (SELECT COUNT(MADA)
												  FROM PHANCONG PC1
												  WHERE PC1.MA_NVIEN = NV.MANV) SLCV, (SELECT SUM(THOIGIAN)
																					   FROM PHANCONG PC2
																					   WHERE PC2.MA_NVIEN = NV.MANV) TONGTHOIGIAN
FROM NHANVIEN NV

-- ĐỀ 3 - CÂU 7
SELECT DA.DIADIEM_DA, COUNT(*) SLNV
FROM DEAN DA JOIN (SELECT DD.DIADIEM, PB.MAPHG
				   FROM PHONGBAN PB JOIN DIADIEM_PHG DD ON PB.MAPHG = DD.MAPHG) PHG ON DA.DIADIEM_DA = PHG.DIADIEM
			 JOIN (SELECT PC.MA_NVIEN, PC.MADA
				   FROM PHANCONG PC) SL ON SL.MADA = DA.MADA
GROUP BY SL.MA_NVIEN, DA.DIADIEM_DA
HAVING COUNT (*) > 2

-- ĐỀ 3 - CÂU 8
SELECT KQ.TENPHG
FROM  PHONGBAN KQ 
WHERE NOT EXISTS (SELECT C.MADA
				  FROM DEAN C JOIN PHONGBAN PB ON PB.MAPHG = C.PHONG
				  WHERE C.DIADIEM_DA = N'VŨNG TÀU'
				  EXCEPT 
				  SELECT BC.MADA
				  FROM DEAN BC
				  WHERE BC.PHONG = KQ.MAPHG)