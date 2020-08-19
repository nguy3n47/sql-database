use QLDETAI
go

--Q27
select COUNT(GV.MAGV) SLGV, SUM(GV.Luong) TongLuong
from GIAOVIEN GV

--Q28
select GV.MABM, count(*) as SLGV, AVG(GV.LUONG) as Luong
from GIAOVIEN as GV
group by GV.MABM

-- Q29
select * from DETAI
select * from CHUDE
select CD.TENCD, COUNT(DT.TENDT)
from DETAI as DT, CHUDE as CD
where DT.MACD = CD.MACD
group by CD.TENCD

--Q30
select * from THAMGIADT
select * from GIAOVIEN
select GV.HOTEN, COUNT(distinct(TG.MAGV))
from THAMGIADT as TG, GIAOVIEN as GV
where TG.MAGV = GV.MAGV
group by GV.HOTEN, GV.MAGV


-- Q31
select * from DETAI
select * from GIAOVIEN
select GV.HOTEN, COUNT(DT.GVCNDT)
from DETAI as DT, GIAOVIEN as GV
where DT.GVCNDT = GV.MAGV
group by GV.HOTEN, GV.MAGV


-- Q32
select * from GIAOVIEN
select * from NGUOITHAN
select GV.MAGV, GV.HOTEN, COUNT(NGT.MAGV)
from GIAOVIEN as GV, NGUOITHAN as NGT
where GV.MAGV = NGT.MAGV
group by GV.MAGV, NGT.MAGV, GV.HOTEN

--Q33
select * from THAMGIADT
select GV.HOTEN
from GIAOVIEN as GV JOIN THAMGIADT as TGDT on GV.MAGV = TGDT.MAGV
group by GV.HOTEN
having COUNT(tgdt.MADT) >= 3

--Q34
SELECT COUNT(*) SLGV
FROM GIAOVIEN GV JOIN THAMGIADT TGDT ON GV.MAGV=TGDT.MAGV JOIN DETAI DT ON DT.MADT=TGDT.MADT
WHERE DT.TENDT = (N'ỨNG DỤNG HÓA HỌC XANH')