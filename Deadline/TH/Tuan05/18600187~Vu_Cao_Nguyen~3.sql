USE master
GO
IF DB_ID ('DTQ') IS NOT NULL
	DROP DATABASE DTQ
GO
CREATE DATABASE DTQ
GO
USE DTQ
GO

-- TẠO BẢNG
CREATE TABLE QUOC_GIA
(
	MaQG nvarchar(5),
	TenQG nvarchar(10),
	ThuDo nvarchar(5),
	DanSo int,
	DienTich float
	CONSTRAINT PK_QG
	PRIMARY KEY (MaQG)
)

CREATE TABLE TINH_THANH
(
	QuocGia nvarchar(5),
	MaTinhThanh nvarchar(5),
	DanSo int,
	DienTich float,
	TenTT nvarchar(30)
	CONSTRAINT PK_TT
	PRIMARY KEY (MaTinhThanh)
)

CREATE TABLE DIEM_THAM_QUAN
(
	MaDTQ nvarchar(10),
	TenDTQ nvarchar(30),
	TinhThanh nvarchar(5),
	QuocGia nvarchar(5),
	DacDiem nvarchar(50)
	CONSTRAINT PK_DTQ
	PRIMARY KEY (MaDTQ)
)

-- TẠO KHÓA NGOẠI VÀ RÀNG BUỘC
ALTER TABLE QUOC_GIA
ADD
	CONSTRAINT FK_QG_TT
	FOREIGN KEY (ThuDo)
	REFERENCES TINH_THANH

ALTER TABLE TINH_THANH
ADD 
	CONSTRAINT FK_TT_QG
	FOREIGN KEY (QuocGia)
	REFERENCES QUOC_GIA

ALTER TABLE DIEM_THAM_QUAN
ADD
	CONSTRAINT FK_DTQ_TT
	FOREIGN KEY (TinhThanh)
	REFERENCES TINH_THANH,
	CONSTRAINT FK_DTQ_QG
	FOREIGN KEY (QuocGia)
	REFERENCES QUOC_GIA,
	CONSTRAINT UK_DTQ
	UNIQUE (MaDTQ)

INSERT QUOC_GIA (MaQG, TenQG, ThuDo, DanSo, DienTich)
VALUES
('QG001', N'Việt Nam', NULL, 115000000, 331688.00),
('QG002', N'Nhật Bản', NULL, 129500000, 337834.00)

INSERT TINH_THANH (QuocGia, MaTinhThanh, TenTT, DanSo, DienTich)
VALUES
('QG001', 'TT001', N'Hà Nội', 2500000, 927.39),
('QG001', 'TT002', N'Huế', 5344000, 5009.00),
('QG002', 'TT003', 'Tokyo', 12084000, 2187.00)

UPDATE QUOC_GIA
SET ThuDo = 'TT001'
WHERE MaQG = 'QG001'

UPDATE QUOC_GIA
SET ThuDo = 'TT003'
WHERE MaQG = 'QG002'

INSERT DIEM_THAM_QUAN (MaDTQ, TenDTQ, TinhThanh, QuocGia, DacDiem)
VALUES
('DTQ001', N'Văn Miếu', 'TT001', 'QG001', N'Di tích cổ'),
('DTQ002', N'Hoàng lăng', 'TT002', 'QG001', N'Di tích cổ'),
('DTQ003', N'Tháp Tokyo', 'TT003', 'QG002', N'Công trình hiện đại')

-- Liệt kê những điểm tham quan (mã và tên) trong những thành phố
-- có diện tích lớn hơn 1/100 diện tích của quốc gia của thành phố đó.
SELECT A.MaDTQ, A.TenDTQ
FROM DIEM_THAM_QUAN A JOIN TINH_THANH TT ON A.TinhThanh = TT.MaTinhThanh
					  JOIN QUOC_GIA QG ON A.QuocGia = QG.MaQG
WHERE TT.DienTich > QG.DienTich*0.01

SELECT DTQ.MaDTQ, DTQ.TenDTQ
FROM DIEM_THAM_QUAN DTQ, TINH_THANH TT, QUOC_GIA QG
WHERE (DTQ.TinhThanh = TT.MaTinhThanh) AND (TT.QuocGia = QG.MaQG) AND (TT.DienTich > QG.DienTich*0.01)

-- Hãy liệt kê các quốc gia (mã và tên quốc gia) hoặc có trên 2 triệu dân hoặc
-- không có điểm tham quan
SELECT A.MaQG, A.TenQG
FROM QUOC_GIA A
WHERE A.DanSo > 2000000 OR ( SELECT COUNT(DISTINCT MaDTQ)
							FROM DIEM_THAM_QUAN DTQ
							WHERE A.MaQG = DTQ.QuocGia) = 0

SELECT MAQG,TENQG FROM QUOC_GIA WHERE DANSO > 2000000
UNION
(SELECT MAQG,TENQG FROM QUOC_GIA
EXCEPT 
SELECT MAQG,TENQG FROM DIEM_THAM_QUAN DTQ JOIN QUOC_GIA QG ON QG.MaQG = DTQ.QuocGia)