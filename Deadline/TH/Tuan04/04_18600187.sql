
-- TRUY VẤN CSDL QUẢN LÝ GIÁO VIÊN THAM GIA ĐỀ TÀI - TOPIC 03

--Câu 1: Cho biết họ tên và mức lương của các giáo viên nữ.
SELECT HOTEN, LUONG 
FROM GIAOVIEN 
WHERE PHAI = N'Nữ'

--Câu 2: Cho biết hộ tên của các giáo viên và lương của họ sau khi năng 10%
SELECT HOTEN, LUONG AS LUONG_TRUOC, LUONG*1.1 AS LUONG_SAU 
FROM GIAOVIEN

--Câu 3: Cho biết mã của các giáo viên có họ tên bắt đầu là “Nguyễn” và lương trên $2000 hoặc, giáo viên là trưởng bộ môn nhận chức sau năm 1995
SELECT MAGV 
FROM GIAOVIEN, BOMON 
WHERE (GIAOVIEN.LUONG > 2000 AND GIAOVIEN.HOTEN LIKE N'Nguyễn%') OR (BOMON.TRUONGBM = GIAOVIEN.MAGV AND YEAR(BOMON.NGAYNHANCHUC) > 1995)

--Câu 4: Cho biết tên những giáo viên khoa Công nghệ thông tin.
SELECT HOTEN 
FROM GIAOVIEN, BOMON, KHOA 
WHERE GIAOVIEN.MABM = BOMON.MABM AND BOMON.MAKHOA = KHOA.MAKHOA AND KHOA.TENKHOA = N'Công nghệ thông tin'

--Câu 5: Cho biết thông tin của bộ môn cùng thông tin của giảng viên làm trưởng bộ môn đó
SELECT * 
FROM BOMON LEFT JOIN GIAOVIEN ON GIAOVIEN.MAGV = BOMON.TRUONGBM

--Câu 6: Với mỗi giáo viên cho biết thông tin bộ môn mà họ đang làm việc
SELECT * 
FROM GIAOVIEN LEFT JOIN BOMON ON GIAOVIEN.MABM = BOMON.MABM

--Câu 7: Cho biết tên đề tài và giáo viên chủ nhiệm đề tài
SELECT DETAI.TENDT, GIAOVIEN.* 
FROM DETAI LEFT JOIN GIAOVIEN ON GIAOVIEN.MAGV = DETAI.GVCNDT

--Câu 8: Với mỗi khoa cho biết thông tin trưởng khoa
SELECT * 
FROM KHOA, GIAOVIEN 
WHERE GIAOVIEN.MAGV = KHOA.TRUONGKHOA

--Câu 9: Cho biết các giáo viên của bộ môn vi sinh có tham gia đề tài '006'
SELECT DISTINCT GIAOVIEN.* 
FROM GIAOVIEN, THAMGIADT, BOMON 
WHERE THAMGIADT.MADT = '006' AND GIAOVIEN.MAGV = THAMGIADT.MAGV AND GIAOVIEN.MABM = BOMON.MABM AND BOMON.TENBM = N'Vi sinh'

--Câu 10: Với những đề tài thuộc cấp quản lý “Thành"phố”, cho biết mã đề tài, đề tài thuộc về chủ đề nào, họ tên người chủ nghiệm đề tài cùng với ngày sinh và địa chỉ của người ấy.
SELECT DETAI.MADT, CHUDE.*, GIAOVIEN.HOTEN, GIAOVIEN.NGSINH, GIAOVIEN.DIACHI
FROM DETAI, CHUDE, GIAOVIEN
WHERE DETAI.CAPQL = N'Thành phố' AND DETAI.MACD = CHUDE.MACD AND DETAI.GVCNDT = GIAOVIEN.MAGV

--Câu 11: Tìm họ tên của từng giáo viên và người phụ trách chuyên đề của họ
SELECT A.HOTEN, B.HOTEN 
FROM GIAOVIEN A LEFT JOIN GIAOVIEN B ON A.MAGV = B.GVQLCM

--Câu 12: Tìm họ tên của những giáo viên được "Nguyễn Thanh Tùng" phụ trách trực tiếp
SELECT A.HOTEN 
FROM GIAOVIEN A 
WHERE A.GVQLCM = (SELECT GIAOVIEN.MAGV FROM GIAOVIEN WHERE GIAOVIEN.HOTEN = N'Nguyễn Thanh Tùng') 

--Câu 13: Cho biết tên giáo viên là trưởng bộ môn 'HỆ THỐNG THÔNG TIN'
SELECT GIAOVIEN.HOTEN 
FROM GIAOVIEN, BOMON 
WHERE GIAOVIEN.MAGV = BOMON.TRUONGBM AND BOMON.TENBM = N'Hệ thống thông tin'

--Câu 14: Cho biết tên người chủ nhiệm đề tài của những đề tài thuộc chủ đề quản lý giáo dục
SELECT DISTINCT GIAOVIEN.HOTEN 
FROM GIAOVIEN, DETAI, THAMGIADT, CHUDE 
WHERE (DETAI.MADT = THAMGIADT.MADT AND THAMGIADT.MAGV = GIAOVIEN.MAGV) AND (DETAI.MACD = CHUDE.MACD AND CHUDE.TENCD = N'Quản lý giáo dục')

--Câu 15: Cho biết tên các công việc của đề tài HTTT quản lý các trường ĐH có thời gian bắt đầu trong tháng 3/2008.
SELECT DISTINCT CONGVIEC.TENCV 
FROM CONGVIEC, DETAI 
WHERE (CONGVIEC.MADT = DETAI.MADT AND DETAI.TENDT = N'HTTT quản lý các trường ĐH') AND datediff(m, CONGVIEC.NGAYBD, '3/1/2008') = 0

--Câu 16: Cho biết tên giáo viên và tên người quản lý chuyên môn của giáo viên đó.
SELECT A.HOTEN AS HOTEN_GV, B.HOTEN AS HOTEN_GVGLCM 
FROM GIAOVIEN A LEFT JOIN GIAOVIEN B ON B.MAGV = A.GVQLCM

--Câu 17: Cho biết các công việc bắt đầu trong khoảng từ 01/01/2007 đến 01/08/2007
SELECT * 
FROM CONGVIEC 
WHERE DATEDIFF(d, CONGVIEC.NGAYBD, '1/1/2007') < 0 AND DATEDIFF(d, CONGVIEC.NGAYBD, '8/1/2007') > 0

--Câu 18: Cho biết họ tên các giáo viên cùng bộ môn với GV "Trần Trà Hương"
SELECT DISTINCT GIAOVIEN.HOTEN 
FROM GIAOVIEN, BOMON 
WHERE GIAOVIEN.MABM = (SELECT BOMON.MABM FROM GIAOVIEN, BOMON WHERE BOMON.MABM = GIAOVIEN.MABM AND GIAOVIEN.HOTEN = N'Trần Trà Hương') AND GIAOVIEN.HOTEN != N'Trần Trà Hương'

SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE GV.MABM IN (SELECT GV.MABM FROM GIAOVIEN GV WHERE GV.HOTEN=N'TRẦN TRÀ HƯƠNG') AND GV.HOTEN != N'TRẦN TRÀ HƯƠNG'
--Câu 19: Tìm những giáo viên vừa là trưởng bộ môn, vừa là chủ nhiệm đề tài
SELECT DISTINCT GIAOVIEN.* 
FROM GIAOVIEN, DETAI, KHOA 
WHERE GIAOVIEN.MAGV = KHOA.TRUONGKHOA AND GIAOVIEN.MAGV = DETAI.GVCNDT

--Câu 20: Cho biết tên những giáo viên vừa là trưởng khoa và vừa là trưởng bộ môn
SELECT GIAOVIEN.HOTEN 
FROM GIAOVIEN, BOMON, KHOA 
WHERE GIAOVIEN.MAGV = BOMON.TRUONGBM AND GIAOVIEN.MAGV = KHOA.TRUONGKHOA

--Câu 21: Cho biết tên những trưởng bộ môn mà vừa chủ nhiệm đề tài
SELECT DISTINCT GIAOVIEN.HOTEN 
FROM GIAOVIEN, DETAI, BOMON 
WHERE GIAOVIEN.MAGV = BOMON.TRUONGBM AND GIAOVIEN.MAGV = DETAI.GVCNDT

--Câu 22: Cho biết mã số các trưởng khoa mà vừa chủ nhiệm đề tài
SELECT DISTINCT GIAOVIEN.MAGV 
FROM GIAOVIEN, DETAI, KHOA 
WHERE GIAOVIEN.MAGV = KHOA.TRUONGKHOA AND GIAOVIEN.MAGV = DETAI.GVCNDT

--Câu 23: Cho biết mã số các giáo viên thuộc bộ môn "HTTT" hoặc tham gia đề tài mã "001"
SELECT DISTINCT GIAOVIEN.MAGV 
FROM GIAOVIEN, BOMON, THAMGIADT 
WHERE (GIAOVIEN.MABM = N'HTTT') OR (GIAOVIEN.MAGV = THAMGIADT.MAGV AND THAMGIADT.MADT = '001')

--Câu 24: Cho biết giáo viên làm việc cùng bộ môn với giáo viên 002
SELECT GIAOVIEN.* 
FROM GiAOVIEN 
WHERE GIAOVIEN.MABM = (SELECT GIAOVIEN.MABM FROM GIAOVIEN WHERE GIAOVIEN.MAGV = '002') AND GIAOVIEN.MAGV != '002'

--Câu 25: Tìm giáo viên là trưởng bộ môn
SELECT GIAOVIEN.* 
FROM GIAOVIEN, BOMON 
WHERE GIAOVIEN.MAGV = BOMON.TRUONGBM

--Câu 26: Cho biết họ tên và mức lương của các giáo viên
SELECT HOTEN, LUONG 
FROM GIAOVIEN