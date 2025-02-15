﻿USE QLDETAI
GO

-- Q35
SELECT MAX(GV.LUONG) LUONGCAONHAT
FROM GIAOVIEN GV

-- Q36
SELECT *
FROM GIAOVIEN GV1
WHERE (SELECT COUNT(*)
	   FROM	GIAOVIEN GV2
	   WHERE GV2.LUONG > GV1.LUONG)	= 0

-- Q37
SELECT MAX(GV.LUONG) LuongCaoNhatHTTT
FROM GIAOVIEN GV
WHERE GV.MABM = N'HTTT'

-- Q38
SELECT GV.*
FROM GIAOVIEN GV
WHERE YEAR(GV.NGSINH) = (SELECT MIN(YEAR(NGSINH))
						 FROM GIAOVIEN GV
						 WHERE  EXISTS (SELECT BM.MABM
										FROM BOMON BM
									    WHERE GV.MABM = BM.MABM AND BM.TENBM = N'HỆ THỐNG THÔNG TIN'))

-- Q39
SELECT GV.*
FROM GIAOVIEN GV
WHERE YEAR(GV.NGSINH) = (SELECT MAX(YEAR(NGSINH)) 
						 FROM GIAOVIEN GV
						 WHERE EXISTS (SELECT BM.MABM
									   FROM BOMON BM
									   WHERE GV.MABM = BM.MABM AND BM.TENBM = N'CÔNG NGHỆ THÔNG TIN'))

-- Q41
SELECT *
FROM GIAOVIEN GV
WHERE LUONG >= ALL (SELECT LUONG 
					FROM GIAOVIEN GV2
					WHERE GV.MABM = GV2.MABM AND GV.MAGV <> GV2.MAGV)

-- Q42
SELECT DT.TENDT
FROM DETAI DT
WHERE NOT EXISTS (SELECT TG.MADT 
			  FROM THAMGIADT TG
			  WHERE DT.MADT = TG.MADT AND  EXISTS ( SELECT GV.MAGV
													FROM GIAOVIEN GV
													WHERE TG.MAGV = GV.MAGV AND GV.HOTEN = N'NGUYỄN HOÀI AN'))

-- Q43
SELECT DT.TENDT, GV.HOTEN GVCNDT
FROM DETAI DT , GIAOVIEN GV
WHERE GV.MAGV = DT.GVCNDT AND NOT EXISTS (SELECT TG.MADT 
										  FROM THAMGIADT TG
										  WHERE DT.MADT = TG.MADT AND EXISTS (SELECT GV.MAGV
																			  FROM GIAOVIEN GV
																			  WHERE TG.MAGV = GV.MAGV AND GV.HOTEN = N'NGUYỄN HOÀI AN'))

-- Q44
SELECT GV.HOTEN
FROM (SELECT GV.HOTEN, GV.MAGV 
	  FROM GIAOVIEN GV
	  WHERE EXISTS (SELECT BM.MABM 
					FROM BOMON BM
					WHERE GV.MABM = BM.MABM AND EXISTS (SELECT KH.MAKHOA 
					 									FROM KHOA KH
														WHERE BM.MAKHOA = KH.MAKHOA AND KH.TENKHOA = N'CÔNG NGHỆ THÔNG TIN'))) GV
WHERE NOT EXISTS (SELECT TG.MAGV
				  FROM THAMGIADT TG
				  WHERE GV.MAGV = TG.MAGV)

-- Q45
SELECT GV.*
FROM GIAOVIEN GV
WHERE NOT EXISTS (SELECT TG.MAGV
				  FROM THAMGIADT TG
				  WHERE GV.MAGV = TG.MAGV)

-- Q46
SELECT *
FROM GIAOVIEN GV
WHERE GV.LUONG > (SELECT GV.LUONG
				  FROM GIAOVIEN GV
				  WHERE GV.HOTEN = N'NGUYỄN HOÀI AN')

-- Q47
SELECT *
FROM GIAOVIEN GV
WHERE EXISTS (SELECT BM.TRUONGBM
			  FROM BOMON BM
			  WHERE GV.MAGV = BM.TRUONGBM) AND EXISTS (SELECT TG.MAGV
													   FROM THAMGIADT TG
													   WHERE GV.MAGV = TG.MAGV)

-- Q48
SELECT *
FROM GIAOVIEN GV1
WHERE EXISTS (SELECT * 
			  FROM GIAOVIEN GV2 
			  WHERE GV1.HOTEN LIKE GV2.HOTEN
			  AND GV1.PHAI = GV2.PHAI
			  AND GV1.MABM = GV2.MABM
			  AND GV1.MAGV <> GV2.MAGV)

-- Q49
SELECT GV.*
FROM GIAOVIEN GV
WHERE GV.LUONG > ANY (SELECT GV.LUONG
					  FROM BOMON BM
					  WHERE GV.MABM = BM.MABM AND BM.TENBM = N'CÔNG NGHỆ PHẦM MỀM')

--Q50
SELECT GV.*
FROM GIAOVIEN GV
WHERE GV.LUONG > (SELECT MAX(GV.LUONG)
				  FROM GIAOVIEN GV, BOMON BM WHERE GV.MABM = BM.MABM AND BM.TENBM = N'MẠNG MÁY TÍNH')

-- Q51
SELECT KH.TENKHOA
FROM GIAOVIEN GV, BOMON BM, KHOA KH
WHERE GV.MABM = BM.MABM AND BM.MAKHOA = KH.MAKHOA
GROUP BY KH.MAKHOA, KH.TENKHOA
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
					   FROM GIAOVIEN GV, BOMON BM, KHOA KH
					   WHERE GV.MABM = BM.MABM AND BM.MAKHOA = KH.MAKHOA
					   GROUP BY KH.MAKHOA)

-- Q52
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE GV.MAGV IN (SELECT DT.GVCNDT
				  FROM DETAI DT
				  GROUP BY DT.GVCNDT
				  HAVING COUNT(*) >= ALL (SELECT COUNT(*)
										  FROM DETAI DT
										  GROUP BY DT.GVCNDT))

-- Q53
SELECT GV.MABM
FROM GIAOVIEN GV
GROUP BY GV.MABM
HAVING COUNT(*) >= ALL(SELECT COUNT(*)
					   FROM GIAOVIEN
					   GROUP BY MABM)

-- Q54
SELECT GV.HOTEN, BM.TENBM
FROM GIAOVIEN GV, BOMON BM
WHERE BM.MABM = GV.MABM AND GV.MAGV IN (SELECT TG.MAGV
										FROM THAMGIADT TG
										GROUP BY TG.MAGV
										HAVING COUNT(DISTINCT TG.MADT) >= ALL (SELECT COUNT (DISTINCT TG.MADT)
																			   FROM THAMGIADT TG
																			   GROUP BY TG.MAGV))

-- Q55
SELECT GV.HOTEN
FROM GIAOVIEN GV, THAMGIADT TG
WHERE GV.MAGV = TG.MAGV AND GV.MABM = N'HTTT'
GROUP BY GV.MAGV, GV.HOTEN
HAVING COUNT(DISTINCT TG.MADT) >= ALL(SELECT COUNT(DISTINCT TG.MADT)
								      FROM THAMGIADT TG
									  WHERE GV.MAGV = TG.MAGV
									  GROUP BY TG.MAGV)

-- Q56
SELECT *
FROM GIAOVIEN GV
WHERE GV.MAGV IN (SELECT NT.MAGV
				  FROM NGUOITHAN NT
				  GROUP BY NT.MAGV
				  HAVING COUNT(*) >= ALL (SELECT COUNT(*)
										  FROM NGUOITHAN NT
										  GROUP BY NT.MAGV))

-- Q57
SELECT GV.HOTEN
FROM GIAOVIEN GV, BOMON BM
WHERE GV.MAGV = BM.TRUONGBM AND EXISTS (SELECT DT.GVCNDT
											FROM DETAI DT
											GROUP BY DT.GVCNDT
											HAVING COUNT(*) >= ALL (SELECT COUNT(*)
																	FROM DETAI DT
																	GROUP BY DT.GVCNDT))