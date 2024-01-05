IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP30004]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP30004]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Báo cáo hoàn trả tiền ăn (tổng hợp)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 8/7/2019
----Modify by : Đình Hoà, Date : 03/10/2020 - Thay đổi câu laod sỉ số khối cho tháng hiện tại theo ngày in và câu load Sỉ số bé cuối tháng trước
----Modify by : Vĩnh Tâm, Date : 26/10/2020 - Cập nhật tên bảng tạm để tránh xảy ra lỗi trùng bảng tạm khi chạy fix
----Modify by : Đình Hoà, Date : 30/03/2021 - Thêm điều kiện năm học(SchoolYear) để load đúng năm học theo ngày chọn
-- <Example>
---- 
/*-- <Example>
  
  EXEC EDMP30004 'VS', 'BGD',12,2018
  EDMP30004 @DivisionID= 'BE',@Month = '7',@Year = '2019'

  exec EDMP30004 @DivisionID=N'BE'',''CDX'',''CG'',''HA'',''HP'',''HTX'',''KT'',''LE'',''LU'',''MR'',''NC'',''OG'',''OP'',''OR'',''PH'',''PM'',''SU'',''TS'',''VP',
@GradeID=N'MG-3-4'',''MG-3-6'',''MG-4-5'',''MG-5-6'',''MYEST'',''NT-06-12'',''NT-13-18'',''NT-18-24'',''NT-25-36',
@FromDate='2019-11-05 00:00:00',@ToDate='2019-10-28 00:00:00'



exec EDMP30004 @DivisionID=N'BE',
@GradeID=N'MG-3-4'',''MG-3-6'',''MG-4-5'',''MG-5-6'',''MYEST'',''NT-06-12'',''NT-13-18'',''NT-18-24'',''NT-25-36',@FromDate='2019-10-29 00:00:00',@ToDate='2019-10-29 00:00:00'



----*/

CREATE PROCEDURE EDMP30004
(
	@DivisionID			VARCHAR(MAX),
	@FromDate 			DATETIME,
	@ToDate				DATETIME,
	@GradeID			VARCHAR(MAX),
	@Mode				int = 0 -- 0: mặc định trả 2 bảng
								-- 1: Chỉ trả ra Bảng 1 & không select bảng 2

)
AS
DECLARE @sSQL   NVARCHAR(MAX),
		@SQL1 NVARCHAR(MAX),
		@SQL2 NVARCHAR(MAX),
		@sWhere NVARCHAR(MAX) = N'',
		@StartDate NVARCHAR(50),
		@EndDate NVARCHAR(50)
	
 IF @ToDate>@FromDate
	RETURN

IF @GradeID <> '' 
		SET @sWhere = @sWhere + ' AND T1.GradeID IN ('''+@GradeID+''') '

DECLARE @DateFromYear DATETIME,
		@SchoolYear VARCHAR(50),
		@dStartPreMonth DATETIME,
		@dEndPreMonth DATETIME,
		@dStartMonth DATETIME



SELECT TOP 1  @DateFromYear = DateFrom,@SchoolYear = SchoolYearID  FROM EDMT1040 WITH(NOLOCK) WHERE [Disabled] = 0 AND @FromDate BETWEEN DateFrom AND DateTo

---Đầu tháng 
SELECT @dStartMonth = DATEADD(mm, DATEDIFF(mm, 0, @FromDate), 0)

---Đầu tháng trước 
SELECT @dStartPreMonth = DATEADD(mm, -1, @dStartMonth)
---Ngày cuối tháng trước 
SELECT @dEndPreMonth = DATEADD(dd, -1, @dStartMonth)


-------Lấy sỉ số khối cho tháng hiện tại theo ngày in 
--SELECT COUNT(T2.StudentID)  AS Total, T1.DivisionID,T1.SchoolYearID,T1.GradeID, B.Leave
-- INTO #DATA4
-- FROM EDMT2020 T1 WITH (NOLOCK) 
-- LEFT JOIN EDMT2021 T2 WITH (NOLOCK) ON T2.APKMaster = T1.APK AND T2.DivisionID = T1.DivisionID
-- LEFT JOIN 
-- (SELECT COUNT(StudentID) AS Leave, A.DivisionID,A.SchoolYearID,A.GradeID
--  FROM 
--(
--SELECT T1.DivisionID,
--T1.LeaveDate,T1.StudentID, T3.SchoolYearID,T3.GradeID,
--'LeaveSchool' AS [Name]
--FROM EDMT2080 T1 WITH (NOLOCK) 
--LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T3.ArrangeClassID = T1.ArrangeClassID AND T3.DeleteFlg = 0
--WHERE  T1.DeleteFlg = 0
--AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.LeaveDate,120), 126) BETWEEN   @DateFromYear  AND @FromDate
--AND T1.OldStatusID != 4 
--AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T3.APK AND T1.StudentID = EDMT2021.StudentID)
  

-- UNION ALL 
 
-- -----Bảo lưu 
-- SELECT T1.DivisionID,
-- T1.FromDate AS LeaveDate,T1.StudentID,T1.SchoolYearID, T1.GradeID,
-- 'Reserve' AS [Name] 
-- FROM EDMT2150 T1 WITH (NOLOCK) 
-- LEFT JOIN EDMT2020 T2 WITH(NOLOCK) ON T1.SchoolYearID = T2.SchoolYearID AND T1.GradeID = T2.GradeID AND T1.ClassID = T2.ClassID AND T2.DeleteFlg = 0
-- WHERE T1.DeleteFlg = 0 
-- AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromDate,120), 126) BETWEEN   @DateFromYear  AND @FromDate
-- AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T2.APK AND T1.StudentID = EDMT2021.StudentID )

-- UNION ALL 

-- ---Chuyển trường 
-- SELECT T1.DivisionID,
-- T1.FromEffectiveDate AS LeaveDate ,T1.StudentID, T3.SchoolYearID, T3.GradeID,
-- 'Transfer' AS [Name] 
-- FROM EDMT2140 T1 WITH (NOLOCK) 
-- LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T1.ArrangeClassIDFrom = T3.ArrangeClassID AND T3.DeleteFlg = 0 
-- WHERE T1.DeleteFlg = 0 
-- AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromEffectiveDate,120), 126) BETWEEN   @DateFromYear  AND @FromDate
-- AND T1.DivisionID != T1.SchoolIDTo
-- AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T3.APK AND T1.StudentID = EDMT2021.StudentID )
  
--) AS A
--GROUP BY A.DivisionID,A.SchoolYearID,A.GradeID
-- )  AS B ON B.DivisionID = T1.DivisionID AND T1.GradeID = B.GradeID
 
-- WHERE  T1.DeleteFlg = 0
--		AND  NOT EXISTS (SELECT A1.StudentID FROM EDMT2021 A1 WITH (NOLOCK) WHERE  A1.DivisionID = T2.DivisionID AND 
--						T2.StudentID = A1.StudentID  AND T2.APK = A1.APK 
--						AND (A1.IsTransfer = 0 AND A1.DeleteFlg = 1) OR (T2.IsTransfer IN (1,2) AND T2.DeleteFlg = 1 AND CONVERT(DATE,T2.LastModifyDate) < @FromDate))
--		AND CONVERT(VARCHAR(10), CONVERT(DATE, T2.CreateDate,120), 126) <= @FromDate
		
-- GROUP BY T1.DivisionID,T1.SchoolYearID,T1.GradeID, B.Leave

SELECT COUNT(DISTINCT EDMT2021.StudentID)  AS Total, EDMT2020.DivisionID,EDMT2020.SchoolYearID,EDMT2020.GradeID
INTO #DATA4
FROM EDMT2020 
LEFT JOIN EDMT2021  ON EDMT2021.APKMaster = EDMT2020.APK AND EDMT2021.DivisionID = EDMT2020.DivisionID
WHERE (
---Trường hợp : lấy những học sinh đã học ở lớp này và những học sinh được chuyển đến 
		(EDMT2021.CreateDate = EDMT2021.LastModifyDate AND EDMT2021.IsTransfer NOT IN (1,3,4,5)
		 AND CONVERT(VARCHAR(10), CONVERT(DATE, @FromDate,120), 126) >= CONVERT(VARCHAR(10), CONVERT(DATE, EDMT2021.CreateDate,120), 126))
	   OR 
---Trường hợp : Lấy các học sinh được xếp lớp hoặc chuyển đến đã có trạng thái IsTranfer thay đổi trong tháng điều kiện nhưng ngày thay đổi không nằm trong điều kiện thì vẫn ở trong lớp đó
	   (CONVERT(VARCHAR(10), CONVERT(DATE, EDMT2021.CreateDate,120), 126) between CONVERT(VARCHAR(10), CONVERT(DATE, @dStartPreMonth,120), 126) and CONVERT(VARCHAR(10), CONVERT(DATE, @FromDate,120), 126) 
		AND CONVERT(VARCHAR(10), CONVERT(DATE, EDMT2021.LastModifyDate,120), 126) not between CONVERT(VARCHAR(10), CONVERT(DATE, @dStartPreMonth,120), 126) and CONVERT(VARCHAR(10), CONVERT(DATE, @FromDate,120), 126))
	 ) 
	 AND EDMT2020.SchoolYearID = CASE WHEN @SchoolYear <> '' THEN @SchoolYear ELSE EDMT2020.SchoolYearID END
GROUP BY EDMT2020.GradeID, EDMT2020.DivisionID,EDMT2020.SchoolYearID





-----Lấy sỉ số hiện diện 
SET @sSQL = '
SELECT T1.DivisionID,T1.GradeID, T1.SchoolYearID, COUNT(T2.StudentID) AS Available
INTO #DATA3
FROM EDMT2040 T1 WITH (NOLOCK) 
OUTER APPLY (SELECT TOP 1 * FROM EDMT2040 T3 WITH (NOLOCK) WHERE T1.DivisionID = T3.DivisionID AND T1.ClassID = T3.ClassID 
			AND T1.GradeID = T3.GradeID AND T1.SchoolYearID = T3.SchoolYearID AND T1.AttendanceDate = T3.AttendanceDate  AND T3.DeleteFlg = 0 
			 ORDER BY T3.CreateDate DESC) A
LEFT JOIN EDMT2041 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg 
WHERE T1.DeleteFlg = 0  AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.AttendanceDate,120), 126) = '''+CONVERT(VARCHAR(10),@FromDate,126)+'''  
AND T2.AvailableStatusID = ''HD''
AND T1.CreateDate = A.CreateDate AND T1.DeleteFlg = 0  '+@sWhere+'
GROUP BY T1.DivisionID,T1.GradeID, T1.SchoolYearID
 


-----VẮNG CÓ PHÉP 

 
SELECT  T1.DivisionID,T1.GradeID, T1.SchoolYearID, COUNT(T2.StudentID) AS AbsentPermission
INTO #DATA1 
FROM EDMT2040 T1 WITH (NOLOCK) 
OUTER APPLY (SELECT TOP 1 * FROM EDMT2040 T3 WITH (NOLOCK) WHERE T1.ClassID = T3.ClassID AND T1.GradeID = T3.GradeID 
			 AND T1.SchoolYearID = T3.SchoolYearID and T1.AttendanceDate = T3.AttendanceDate  AND T3.DeleteFlg = 0 
			 ORDER BY T3.CreateDate DESC) A
LEFT JOIN EDMT2041 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg 
WHERE T1.DeleteFlg = 0  AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.AttendanceDate,120), 126) = '''+CONVERT(VARCHAR(10),@FromDate,126)+''' 
AND T2.AvailableStatusID = ''CP''
AND T1.CreateDate = A.CreateDate AND T1.DeleteFlg = 0 '+@sWhere+'
GROUP BY T1.DivisionID,T1.GradeID, T1.SchoolYearID
 
-----Nghỉ không phép 


--DECLARE @AbsentNotPermission INT 

SELECT  T1.DivisionID,T1.GradeID, T1.SchoolYearID, COUNT(DISTINCT T2.StudentID) AS AbsentNotPermission
INTO #DATA2 
FROM EDMT2040 T1 WITH (NOLOCK) 
OUTER APPLY (SELECT TOP 1 * FROM EDMT2040 T3 WITH (NOLOCK) WHERE T1.ClassID = T3.ClassID AND T1.GradeID = T3.GradeID 
			 AND T1.SchoolYearID = T3.SchoolYearID and T1.AttendanceDate = T3.AttendanceDate  AND T3.DeleteFlg = 0 
			 ORDER BY T3.CreateDate DESC) A
LEFT JOIN EDMT2041 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg 
WHERE T1.DeleteFlg = 0  AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.AttendanceDate,120), 126) = '''+CONVERT(VARCHAR(10),@FromDate,126)+''' 
AND T2.AvailableStatusID = ''KP''
AND T1.CreateDate = A.CreateDate AND T1.DeleteFlg = 0 '+@sWhere+'
GROUP BY T1.DivisionID,T1.GradeID, T1.SchoolYearID



'



-----Sỉ số bé cuối tháng trước 

-- SELECT COUNT(EDMT2021.StudentID)  AS TotalStudent, EDMT2020.GradeID,	EDMT2020.DivisionID, B.Leave
-- INTO  #DATA5
-- FROM EDMT2020 WITH (NOLOCK) 
-- LEFT JOIN EDMT2021  WITH (NOLOCK) ON EDMT2021.APKMaster = EDMT2020.APK AND EDMT2021.DivisionID = EDMT2020.DivisionID
-- LEFT JOIN 
-- (SELECT COUNT(StudentID) AS Leave, A.DivisionID,A.GradeID
--  FROM 
--(
--SELECT T1.DivisionID,
--T1.LeaveDate,T1.StudentID, T3.GradeID,
--'LeaveSchool' AS [Name]
--FROM EDMT2080 T1 WITH (NOLOCK) 
--LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T3.ArrangeClassID = T1.ArrangeClassID AND T3.DeleteFlg = 0
--WHERE  T1.DeleteFlg = 0
--AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.LeaveDate,120), 126) BETWEEN   @DateFromYear  AND @dEndPreMonth
--AND T1.OldStatusID != 4 
--AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T3.APK AND T1.StudentID = EDMT2021.StudentID )
  

-- UNION ALL 
 
-- -----Bảo lưu 
-- SELECT T1.DivisionID,
-- T1.FromDate AS LeaveDate,T1.StudentID,T1.GradeID, 
-- 'Reserve' AS [Name] 
-- FROM EDMT2150 T1 WITH (NOLOCK) 
-- LEFT JOIN EDMT2020 T2 WITH(NOLOCK) ON T1.SchoolYearID = T2.SchoolYearID AND T1.GradeID = T2.GradeID AND T1.ClassID = T2.ClassID AND T2.DeleteFlg = 0
-- WHERE T1.DeleteFlg = 0 
-- AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromDate,120), 126) BETWEEN   @DateFromYear  AND @dEndPreMonth
-- AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T2.APK AND T1.StudentID = EDMT2021.StudentID )

-- UNION ALL 

-- ---Chuyển trường 
-- SELECT T1.DivisionID,
-- T1.FromEffectiveDate AS LeaveDate ,T1.StudentID, T3.GradeID, 
-- 'Transfer' AS [Name] 
-- FROM EDMT2140 T1 WITH (NOLOCK) 
-- LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T1.ArrangeClassIDFrom = T3.ArrangeClassID AND T3.DeleteFlg = 0 
-- WHERE T1.DeleteFlg = 0 
-- AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromEffectiveDate,120), 126) BETWEEN   @DateFromYear  AND @dEndPreMonth
-- AND T1.DivisionID != T1.SchoolIDTo
-- AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T3.APK AND T1.StudentID = EDMT2021.StudentID )
  
--) AS A
--GROUP BY A.DivisionID,A.GradeID
-- )  AS B ON B.DivisionID = EDMT2020.DivisionID AND EDMT2020.GradeID = B.GradeID
 
-- WHERE  EDMT2020.DeleteFlg = 0
--		AND  NOT EXISTS (SELECT A1.StudentID FROM EDMT2021 A1 WITH (NOLOCK) WHERE  A1.DivisionID = EDMT2021.DivisionID AND 
--						EDMT2021.StudentID = A1.StudentID  AND EDMT2021.APK = A1.APK 
--						AND (A1.IsTransfer = 0 AND A1.DeleteFlg = 1) OR (EDMT2021.IsTransfer IN (1,2) AND EDMT2021.DeleteFlg = 1 AND CONVERT(VARCHAR(10), CONVERT(DATE, EDMT2021.LastModifyDate,120), 126) < @dEndPreMonth))

--		AND CONVERT(VARCHAR(10), CONVERT(DATE, EDMT2021.CreateDate,120), 126) <= @dEndPreMonth
		
-- GROUP BY	EDMT2020.DivisionID, B.Leave,EDMT2020.GradeID

-----Sỉ số bé cuối tháng trước 
SELECT COUNT(DISTINCT EDMT2021.StudentID)  AS TotalStudent, EDMT2020.GradeID, EDMT2020.DivisionID,EDMT2020.SchoolYearID
INTO #DATA5
FROM EDMT2020 
LEFT JOIN EDMT2021  ON EDMT2021.APKMaster = EDMT2020.APK AND EDMT2021.DivisionID = EDMT2020.DivisionID
WHERE (
---TRường hợp : lấy học sinh đã học ở lớp đó và không có thay đổi trạng thái IsTranfer và ngày xếp lớp(ngày tạo) phải nhỏ hơn ngày cuối cùng của tháng
--- Loại bỏ các trường hợp thay đổi cùng một ngày với ngày xếp lớp(ngày tạo)
		(EDMT2021.CreateDate = EDMT2021.LastModifyDate AND EDMT2021.IsTransfer NOT IN (1,3,4,5)
		 AND CONVERT(VARCHAR(10), CONVERT(DATE, @dEndPreMonth,120), 126) >= CONVERT(VARCHAR(10), CONVERT(DATE, EDMT2021.CreateDate,120), 126))
	   OR 
---Trường hợp : Lấy các học sinh đã có trạng thái IsTranfer thay đổi nhưng ngày cập nhật không nằm trong điều kiện thì vẫn ở trong lớp đó
	   (CONVERT(VARCHAR(10), CONVERT(DATE, @dEndPreMonth,120), 126) >= CONVERT(VARCHAR(10), CONVERT(DATE, EDMT2021.CreateDate,120), 126) 
		AND CONVERT(VARCHAR(10), CONVERT(DATE, @dEndPreMonth,120), 126) < CONVERT(VARCHAR(10), CONVERT(DATE, EDMT2021.LastModifyDate,120), 126))
	 ) 
	 AND EDMT2020.SchoolYearID = CASE WHEN @SchoolYear <> '' THEN @SchoolYear ELSE EDMT2020.SchoolYearID END
GROUP BY EDMT2020.GradeID, EDMT2020.DivisionID,EDMT2020.SchoolYearID


 ------Số lượng bé đóng phí giữ chỗ chưa nhập học

 ----Lấy những phiếu đã thanh toán 
SELECT T1.APK, ISNULL(T1.Amount,0) - SUM(ISNULL(T3.ConvertedAmount, 0)) AS Payment
INTO #TempEDMP30004 
FROM EDMT2000 T1 WITH (NOLOCK) 
INNER JOIN AT9000 T3 WITH (NOLOCK) ON CONVERT(VARCHAR(50),T1.APK) = T3.InheritVoucherID 
AND CONVERT(VARCHAR(50),T1.APK) = T3.InheritTransactionID AND T1.StudentID = T3.ObjectID AND T3.InheritTableID = 'EDMT2000' 
GROUP BY T1.APK,T1.Amount


 SELECT COUNT(DISTINCT A1.APK) AS StudentBooking,A1.DivisionID
 INTO #DATA6
 FROM EDMT2000 A1 WITH (NOLOCK) 
 LEFT JOIN EDMT2010 A2 WITH(NOLOCK) ON A1.APK = A2.APKConsultant AND A2.DeleteFlg = 0
 WHERE A1.DeleteFlg = 0 AND A1.ResultID = 3  AND A2.StatusID = 2
 AND EXISTS (SELECT APK FROM #TempEDMP30004 T1 WITH (NOLOCK) WHERE T1.APK = A1.APK AND T1.Payment = 0)
 AND CONVERT(VARCHAR(10), CONVERT(DATE, A1.VoucherDate,120), 126) <= @FromDate
 GROUP BY A1.DivisionID


 ------Số lượng bé tăng theo ngày in 
  SELECT A.DivisionID, SUM(ISNULL(A.CK,0)) + SUM(ISNULL(A.DK,0)) AS StudentIncrease 
  INTO #DATA7
  FROM 
  (
 SELECT  T1.DivisionID,COUNT(T1.StudentID) AS CK , NULL AS DK 
 FROM EDMT2012 T1 WITH (NOLOCK) 
 LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T2.StudentID = T1.StudentID AND T2.DeleteFlg = 0 
 WHERE T1.DeleteFlg = 0 AND T1.StudentStatusID IN (1,2,3,4) AND T2.StatusID = 0 
 AND CONVERT(DATE, T1.DateStudy,120) = @FromDate
 GROUP BY  T1.DivisionID
 
 UNION ALL 
 
 -----ĐĂNG KÝ NHẬP HỌC 
 SELECT T1.DivisionID,NULL AS CK, COUNT(T1.StudentID) AS DK
 FROM EDMT2000 T1 WITH(NOLOCK) 
 WHERE T1.DeleteFlg = 0 AND T1.ResultID = 1
 AND CONVERT(DATE, T1.VoucherDate,120) = @FromDate
GROUP BY T1.DivisionID
) AS A 
 GROUP BY A.DivisionID



 ------Số lượng bé giảm theo ngày in 

SELECT COUNT(StudentID) AS StudentDecrease, A.DivisionID
INTO #DATA8
FROM 
(
SELECT T1.DivisionID,
T1.LeaveDate,T1.StudentID, T3.ClassID,
'LeaveSchool' AS [Name]
FROM EDMT2080 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T3.ArrangeClassID = T1.ArrangeClassID AND T3.DeleteFlg = 0
WHERE  T1.DeleteFlg = 0
AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.LeaveDate,120), 126) =  @FromDate
AND T1.OldStatusID != 4 
AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T3.APK AND T1.StudentID = EDMT2021.StudentID ) ----trường hợp thông tin lớp được tạo giống nhau nhưng có 1 xếp lớp bị xóa 
  

 UNION ALL 
 
 -----Bảo lưu  
 SELECT T1.DivisionID,
 T1.FromDate AS LeaveDate,T1.StudentID,T1.ClassID, 
 'Reserve' AS [Name] 
 FROM EDMT2150 T1 WITH (NOLOCK)
 LEFT JOIN EDMT2020 T2 WITH(NOLOCK) ON T1.SchoolYearID = T2.SchoolYearID AND T1.GradeID = T2.GradeID AND T1.ClassID = T2.ClassID AND T2.DeleteFlg = 0
 WHERE T1.DeleteFlg = 0 
 AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromDate,120), 126) = @FromDate
 AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T2.APK AND T1.StudentID = EDMT2021.StudentID )

 
 UNION ALL 

 ---Chuyển trường 
 SELECT T1.DivisionID,
 T1.FromEffectiveDate AS LeaveDate ,T1.StudentID, T3.ClassID, 
 'Transfer' AS [Name] 
 FROM EDMT2140 T1 WITH (NOLOCK) 
 LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T1.ArrangeClassIDFrom = T3.ArrangeClassID AND T3.DeleteFlg = 0 
 WHERE  T1.DeleteFlg = 0 
 AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromEffectiveDate,120), 126) = @FromDate
 AND T1.DivisionID != T1.SchoolIDTo
 AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T3.APK AND T1.StudentID = EDMT2021.StudentID )
  
) AS A
GROUP BY  A.DivisionID


 -----LẤY GHI CHÚ BÉ GIẢM 
 SET @SQL1 = '
WITH TEMP AS
(
   SELECT *,
         ROW_NUMBER() OVER (PARTITION BY DivisionID ORDER BY DivisionID DESC) AS A
   FROM 
		(
		SELECT T1.DivisionID,
		T1.LeaveDate,T1.StudentID, T1.Reason,
		''LeaveSchool'' AS [Name]
		FROM EDMT2080 T1 WITH (NOLOCK) 
		WHERE  T1.DeleteFlg = 0
		AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.LeaveDate,120), 126) =  '''+CONVERT(VARCHAR(10),@FromDate,126)+'''
		AND T1.OldStatusID != 4 
		AND ISNULL(T1.Reason,'''') != ''''
  
   
		UNION ALL 
 
		-----Bảo lưu  
		SELECT T1.DivisionID,
		T1.FromDate AS LeaveDate,T1.StudentID, T1.Reason,
		''Reserve'' AS [Name] 
		FROM EDMT2150 T1 WITH (NOLOCK) 
		WHERE T1.DeleteFlg = 0 
		AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromDate,120), 126) = '''+CONVERT(VARCHAR(10),@FromDate,126)+'''
		AND ISNULL(T1.Reason,'''') != ''''
 
		UNION ALL 

		 ---Chuyển trường 
		SELECT T1.DivisionID,
		T1.FromEffectiveDate AS LeaveDate ,T1.StudentID, T1.Reason,
		''Transfer'' AS [Name] 
		FROM EDMT2140 T1 WITH (NOLOCK) 
		WHERE  T1.DeleteFlg = 0 
		AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromEffectiveDate,120), 126) = '''+CONVERT(VARCHAR(10),@FromDate,126)+'''
		AND T1.DivisionID != T1.SchoolIDTo AND ISNULL(T1.Reason,'''') != ''''

		) AS A2
)
SELECT *
INTO #DATA9
FROM TEMP
WHERE A = 1
 
 '



SET @SQL2 = '

SELECT DISTINCT A.DivisionID,T2.DivisionName,NULL AS TeacherIDTotal, NULL AS Note,
A.GradeID,T3.GradeName ---, A.SchoolYearID
, T1.SchoolYearID
---(ISNULL(T1.Total,0) - ISNULL(T1.Leave,0)) StudentTotal
,ISNULL(T1.Total,0) AS StudentTotal
,ISNULL(T4.Available,0) AS Available, 
---ISNULL(T5.TotalStudent,0) - ISNULL(T5.Leave,0) AS StudentLastMonth
ISNULL(T5.TotalStudent,0) AS StudentLastMonth
,T6.StudentBooking, T7.StudentIncrease , T8.StudentDecrease
,T2.AddressE AS Power,ISNULL(C1.AbsentPermission,0) AS AbsentPermission, ISNULL(C1.AbsentPermission,0) + ISNULL(D.AbsentNotPermission,0) AS Absent
,T9.Reason AS NoteDecrease
FROM EDMT2020 A WITH (NOLOCK) 
LEFT JOIN #DATA4 T1 WITH (NOLOCK) ON T1.DivisionID = A.DivisionID AND A.GradeID = T1.GradeID 
LEFT JOIN AT1101 T2 WITH (NOLOCK) ON A.DivisionID = T2.DivisionID
LEFT JOIN EDMT1000 T3 WITH (NOLOCK) ON A.GradeID = T3.GradeID
LEFT JOIN #DATA3 T4 WITH (NOLOCK) ON T4.DivisionID = A.DivisionID AND T4.SchoolYearID = A.SchoolYearID AND A.GradeID = T4.GradeID
LEFT JOIN #DATA5 T5 WITH (NOLOCK) ON T5.DivisionID = A.DivisionID AND T5.GradeID = A.GradeID 
LEFT JOIN #DATA6 T6 WITH (NOLOCK) ON T6.DivisionID = A.DivisionID
LEFT JOIN #DATA7 T7 WITH (NOLOCK) ON T7.DivisionID = A.DivisionID
LEFT JOIN #DATA8 T8 WITH (NOLOCK) ON T8.DivisionID = A.DivisionID
LEFT JOIN #DATA9 T9 WITH (NOLOCK) ON T9.DivisionID = A.DivisionID
---Nghỉ có phép 
LEFT JOIN 
(
SELECT DivisionID, SUM(AbsentPermission)  AS AbsentPermission
FROM #DATA1 
GROUP BY DivisionID 
) AS C1 ON A.DivisionID = C1.DivisionID
----Nghỉ không phép 
LEFT JOIN (
SELECT DivisionID, SUM(AbsentNotPermission) AS AbsentNotPermission
FROM #DATA2 
GROUP BY DivisionID
) AS D ON A.DivisionID = D.DivisionID 
WHERE A.DivisionID IN ('''+@DivisionID+''')
'+@sWhere+'
ORDER BY A.DivisionID DESC   
'
 

 
PRINT @SQL1
PRINT @sSQL
PRINT @SQL2 
exec (@SQL1+@sSQL+@SQL2)

IF @Mode = 0
BEGIN

SELECT * FROM dbo.EDMF1005(@FromDate)

END






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
