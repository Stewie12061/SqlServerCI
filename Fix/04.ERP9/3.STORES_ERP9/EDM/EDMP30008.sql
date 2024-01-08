IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP30008]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP30008]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Báo cáo số lượng bé tăng giảm theo cơ sở 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo on 20/4/2019
-- <Example>
/*

 EXEC EDMP30008  @DivisionID = 'BE',@UserID = 'HONGTHAO',@Date = '2019-10-30 00:00:00'


  exec EDMP30008 @DivisionID=N'BE'',''CDX'',''CG'',''HA'',''HP'',''HTX'',''KT'',''LE'',''LU'',''MR'',''NC'',''OG'',''OP'',''OR'',''PH'',''PM'',''SU'',''TS'',''VP',@UserID = 'HONGTHAO',
   @Date='2019-10-30 00:00:00'


*/

CREATE PROCEDURE EDMP30008 ( 
		 @DivisionID VARCHAR(MAX),
		 @UserID VARCHAR(50),
		 @Date DATETIME 
) 
AS 

DECLARE 
	@sSQL NVARCHAR(MAX) = '',
	@sSQL1 NVARCHAR(MAX) = '',
	@OrderBy VARCHAR(50),
	@sWhere NVARCHAR(MAX) = '',
	@DateFromYear DATETIME,
	@SchoolYear VARCHAR(50),
	@dStartPreMonth DATETIME,
	@dEndPreMonth DATETIME,
	@dStartMonth DATETIME


SELECT TOP 1  @DateFromYear = DateFrom,@SchoolYear = SchoolYearID  FROM EDMT1040 WITH(NOLOCK) WHERE [Disabled] = 0 AND @Date BETWEEN DateFrom AND DateTo

---Đầu tháng 
SELECT @dStartMonth = DATEADD(mm, DATEDIFF(mm, 0, @Date), 0)
 
---Đầu tháng trước 
SELECT @dStartPreMonth = DATEADD(mm, -1, @dStartMonth)
---Ngày cuối tháng trước 
SELECT @dEndPreMonth = DATEADD(dd, -1, @dStartMonth)


 
 -----Sỉ số bé cuối tháng trước 

 SELECT COUNT(EDMT2021.StudentID)  AS TotalStudent, EDMT2020.GradeID,	EDMT2020.DivisionID, B.Leave
 INTO  #Table1 
 FROM EDMT2020 WITH (NOLOCK) 
 LEFT JOIN EDMT2021  WITH (NOLOCK) ON EDMT2021.APKMaster = EDMT2020.APK AND EDMT2021.DivisionID = EDMT2020.DivisionID
 LEFT JOIN 
 (SELECT COUNT(StudentID) AS Leave, A.DivisionID,A.GradeID
  FROM 
(
SELECT T1.DivisionID,
T1.LeaveDate,T1.StudentID, T3.GradeID,
'LeaveSchool' AS [Name]
FROM EDMT2080 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T3.ArrangeClassID = T1.ArrangeClassID AND T3.DeleteFlg = 0
WHERE  T1.DeleteFlg = 0
AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.LeaveDate,120), 126) BETWEEN   @DateFromYear  AND @dEndPreMonth
AND T1.OldStatusID != 4 
AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T3.APK AND T1.StudentID = EDMT2021.StudentID)

 UNION ALL 
 
 -----Bảo lưu 
 SELECT T1.DivisionID,
 T1.FromDate AS LeaveDate,T1.StudentID,T1.GradeID, 
 'Reserve' AS [Name] 
 FROM EDMT2150 T1 WITH (NOLOCK) 
 LEFT JOIN EDMT2020 T2 WITH(NOLOCK) ON T1.SchoolYearID = T2.SchoolYearID AND T1.GradeID = T2.GradeID AND T1.ClassID = T2.ClassID AND T2.DeleteFlg = 0
 WHERE T1.DeleteFlg = 0 
 AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromDate,120), 126) BETWEEN   @DateFromYear  AND @dEndPreMonth
 AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T2.APK AND T1.StudentID = EDMT2021.StudentID )

 UNION ALL 

 ---Chuyển trường 
 SELECT T1.DivisionID,
 T1.FromEffectiveDate AS LeaveDate ,T1.StudentID, T3.GradeID, 
 'Transfer' AS [Name] 
 FROM EDMT2140 T1 WITH (NOLOCK) 
 LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T1.ArrangeClassIDFrom = T3.ArrangeClassID AND T3.DeleteFlg = 0 
 WHERE T1.DeleteFlg = 0 
 AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromEffectiveDate,120), 126) BETWEEN   @DateFromYear  AND @dEndPreMonth
 AND T1.DivisionID != T1.SchoolIDTo
 AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T3.APK AND T1.StudentID = EDMT2021.StudentID )
  
) AS A
GROUP BY A.DivisionID,A.GradeID
 )  AS B ON B.DivisionID = EDMT2020.DivisionID AND EDMT2020.GradeID = B.GradeID
 
 WHERE  EDMT2020.DeleteFlg = 0
		AND  NOT EXISTS (SELECT A1.StudentID FROM EDMT2021 A1 WITH (NOLOCK) WHERE  A1.DivisionID = EDMT2021.DivisionID AND 
						EDMT2021.StudentID = A1.StudentID  AND EDMT2021.APK = A1.APK 
						AND (A1.IsTransfer = 0 AND A1.DeleteFlg = 1) OR (EDMT2021.IsTransfer IN (1,2) AND EDMT2021.DeleteFlg = 1 
						AND CONVERT(VARCHAR(10), CONVERT(DATE, EDMT2021.LastModifyDate,120), 126) < @dEndPreMonth))

		AND CONVERT(VARCHAR(10), CONVERT(DATE, EDMT2021.CreateDate,120), 126) <= @dEndPreMonth
		
 GROUP BY	EDMT2020.DivisionID, B.Leave,EDMT2020.GradeID




-------Lấy sỉ số khối cho tháng hiện tại theo ngày in 
SELECT COUNT(T2.StudentID)  AS Total, T1.DivisionID,T1.SchoolYearID,T1.GradeID, B.Leave
 INTO #Table2
 FROM EDMT2020 T1 WITH (NOLOCK) 
 LEFT JOIN EDMT2021 T2 WITH (NOLOCK) ON T2.APKMaster = T1.APK AND T2.DivisionID = T1.DivisionID
 LEFT JOIN 
 (SELECT COUNT(StudentID) AS Leave, A.DivisionID,A.SchoolYearID,A.GradeID
  FROM 
(
SELECT T1.DivisionID,
T1.LeaveDate,T1.StudentID, T3.SchoolYearID,T3.GradeID,
'LeaveSchool' AS [Name]
FROM EDMT2080 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T3.ArrangeClassID = T1.ArrangeClassID AND T3.DeleteFlg = 0
WHERE  T1.DeleteFlg = 0
AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.LeaveDate,120), 126) BETWEEN   @DateFromYear  AND @Date
AND T1.OldStatusID != 4 
AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T3.APK AND T1.StudentID = EDMT2021.StudentID)

 UNION ALL 
 
 -----Bảo lưu 
 SELECT T1.DivisionID,
 T1.FromDate AS LeaveDate,T1.StudentID,T1.SchoolYearID, T1.GradeID,
 'Reserve' AS [Name] 
 FROM EDMT2150 T1 WITH (NOLOCK) 
 LEFT JOIN EDMT2020 T2 WITH(NOLOCK) ON T1.SchoolYearID = T2.SchoolYearID AND T1.GradeID = T2.GradeID AND T1.ClassID = T2.ClassID AND T2.DeleteFlg = 0
 WHERE T1.DeleteFlg = 0 
 AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromDate,120), 126) BETWEEN   @DateFromYear  AND @Date
 AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T2.APK AND T1.StudentID = EDMT2021.StudentID )

 UNION ALL 

 ---Chuyển trường 
 SELECT T1.DivisionID,
 T1.FromEffectiveDate AS LeaveDate ,T1.StudentID, T3.SchoolYearID, T3.GradeID,
 'Transfer' AS [Name] 
 FROM EDMT2140 T1 WITH (NOLOCK) 
 LEFT JOIN EDMT2020 T3 WITH (NOLOCK) ON T1.ArrangeClassIDFrom = T3.ArrangeClassID AND T3.DeleteFlg = 0 
 WHERE T1.DeleteFlg = 0 
 AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromEffectiveDate,120), 126) BETWEEN   @DateFromYear  AND @Date
 AND T1.DivisionID != T1.SchoolIDTo
 AND EXISTS (SELECT EDMT2021.APK FROM EDMT2021 WITH(NOLOCK) WHERE EDMT2021.APKMaster = T3.APK AND T1.StudentID = EDMT2021.StudentID )
  
) AS A
GROUP BY A.DivisionID,A.SchoolYearID,A.GradeID
 )  AS B ON B.DivisionID = T1.DivisionID AND T1.GradeID = B.GradeID
 
 WHERE  T1.DeleteFlg = 0
		AND  NOT EXISTS (SELECT A1.StudentID FROM EDMT2021 A1 WITH (NOLOCK) WHERE  A1.DivisionID = T2.DivisionID AND 
						T2.StudentID = A1.StudentID  AND T2.APK = A1.APK 
						AND (A1.IsTransfer = 0 AND A1.DeleteFlg = 1) OR (T2.IsTransfer IN (1,2) AND T2.DeleteFlg = 1 AND CONVERT(DATE,T2.LastModifyDate) < @Date))
		AND CONVERT(VARCHAR(10), CONVERT(DATE, T2.CreateDate,120), 126) <= @Date
		
 GROUP BY T1.DivisionID,T1.SchoolYearID,T1.GradeID, B.Leave


------BÉ MỚI NHẬP HỌC = bé có phiếu thông tin tư vấn với kết quả tư vấn là "Đăng ký nhập học" + bé có phiếu thông tin tư vấn với kết quả tư vấn là "Học thử" + bé "giữ chỗ" nhập học chính thức từ đầu tháng tới ngày in

------Đăng ký nhập học + học thử  


SELECT T1.DivisionID, COUNT(T1.StudentID) AS HT
INTO #Table3
FROM EDMT2000 T1 WITH (NOLOCK) 
WHERE T1.DeleteFlg = 0 AND T1.ResultID IN (1,2)
AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.VoucherDate,120), 126) BETWEEN @dStartMonth AND @Date
AND ISNULL(T1.InheritTranfer,'') = ''                           -----loại trừ trường hợp bé quay học lại 
GROUP BY T1.DivisionID



--Giữ chỗ sang học chính thức 
SELECT T1.DivisionID, COUNT(T1.StudentID) AS GC
INTO #Table4
FROM EDMT2012 T1 WITH (NOLOCK)
----LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.StudentID = T2.StudentID AND T2.DeleteFlg = 0 
WHERE T1.StudentStatusID = 2 AND T1.DeleteFlg = 0 -----AND T2.StatusID = 0
AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.DateStudy,120), 126) BETWEEN @dStartMonth AND @Date
GROUP BY T1.DivisionID 
 
 
 ----Bé cũ học lại =  Bé bảo lưu đi học lại + bé nghỉ học đi học lại + chuyển trường đi rồi quay về học lại

 SELECT A1.DivisionID, SUM(A1.BL) AS OldStudent
 INTO #Table5 
 FROM 
 (
----Bé bảo lưu đi học lại + bé nghỉ học đi học lại
SELECT T1.DivisionID,COUNT(T1.StudentID) AS BL
FROM EDMT2012 T1 WITH (NOLOCK) 
-----LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.StudentID = T2.StudentID AND T2.DeleteFlg = 0 
WHERE T1.StudentStatusID IN (3,4) ----AND T2.StatusID = 0 
AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.DateStudy,120), 126) BETWEEN @dStartMonth AND @Date
GROUP BY T1.DivisionID

UNION ALL 

----Chuyển trường --> Học lại 
SELECT T1.DivisionID,COUNT(DISTINCT T1.StudentID) AS BL
FROM EDMT2000 T1 WITH (NOLOCK) 
WHERE ISNULL(T1.InheritTranfer,'') != ''
AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.VoucherDate,120), 126) BETWEEN @dStartMonth AND @Date
GROUP BY T1.DivisionID
) AS A1

GROUP BY A1.DivisionID



-----Nghỉ luôn = Bé có ngày HIỆU LỰC của quyết định nghỉ học nằm trong khoảng từ đầu tháng đến ngày in

SELECT T1.DivisionID, COUNT(T1.StudentID) AS Leave
INTO #Table6 
FROM EDMT2080 T1 WITH (NOLOCK)
WHERE  T1.DeleteFlg = 0 
AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.LeaveDate,120), 126) BETWEEN @dStartMonth AND @Date
AND T1.OldStatusID != 4 
GROUP BY T1.DivisionID



----BÉ TẠM NGHỈ HẾT THÁNG  = Số bé có ngày hết hạn bảo lưu nằm trong tháng in VÀ ngày in nằm trong khoảng thời gian bảo lưu VÀ trạng thái hồ sơ học sinh là "Bảo lưu"


SELECT T1.DivisionID,COUNT(T1.StudentID) AS ReserveEndMonth
INTO #Table8
FROM EDMT2150 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.StudentID = T2.StudentID AND T2.DeleteFlg = 0 
WHERE T1.DeleteFlg = 0 AND T2.StatusID = 4
AND CONVERT(VARCHAR(10), CONVERT(DATE, @Date,120), 126) BETWEEN T1.FromDate AND T1.ToDate
AND MONTH(@Date) = MONTH(T1.ToDate) AND YEAR(@Date) = YEAR(T1.ToDate)
GROUP BY T1.DivisionID






 
-----Bé tạm nghỉ = Số bé có thời gian bảo lưu chứa ngày in VÀ trạng tháu Hồ sơ học sinh là "Bảo lưu"
SELECT T1.DivisionID, COUNT(T1.StudentID) AS StudentReserve
INTO #Table7 
FROM EDMT2150 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.StudentID = T2.StudentID AND T2.DeleteFlg = 0 
WHERE T1.DeleteFlg = 0 AND T2.StatusID = 4
AND CONVERT(VARCHAR(10), CONVERT(DATE, @Date,120), 126) BETWEEN T1.FromDate AND T1.ToDate
GROUP BY T1.DivisionID
  

----Ghi chú bé giảm = Chỉ load lên 1 lí do đầu tiên trong danh sách gồm [Bé nghỉ luôn], [Bé tạm nghỉ hết tháng], [Bé tạm nghỉ]
 

SET @sSQL1 = '
WITH TEMP AS
(
   SELECT *,
         ROW_NUMBER() OVER (PARTITION BY DivisionID ORDER BY DivisionID DESC) AS A
   FROM 
		(
		SELECT T1.DivisionID,T1.StudentID, T1.Reason
		FROM EDMT2080 T1 WITH (NOLOCK)
		WHERE  T1.DeleteFlg = 0 
		AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.LeaveDate,120), 126) BETWEEN '''+CONVERT(VARCHAR(10),@dStartMonth,126)+''' AND '''+CONVERT(VARCHAR(10),@Date,126)+'''
		AND T1.OldStatusID != 4 AND ISNULL(T1.Reason,'''') != '''' 
 
		UNION ALL 

		SELECT T1.DivisionID,T1.StudentID, T1.Reason 
		FROM EDMT2150 T1 WITH (NOLOCK) 
		LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.StudentID = T2.StudentID AND T2.DeleteFlg = 0 
		WHERE T1.DeleteFlg = 0 AND T2.StatusID = 4
		AND '''+CONVERT(VARCHAR(10),@Date,126)+''' BETWEEN CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromDate,120), 126) AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.ToDate,120), 126)
		AND ISNULL(T1.Reason,'''') != ''''
		) AS A2
)
SELECT *
INTO #Table9
FROM TEMP
WHERE A = 1

'

 




 SET @sSQL = '

 SELECT DISTINCT T1.DivisionID,T4.DivisionName,T1.GradeID,T3.GradeName, 
 ISNULL(T2.TotalStudent,0) - ISNULL(T2.Leave,0) AS StudentLastMonth,
 ISNULL(T5.Total,0) - ISNULL(T5.Leave,0) AS TotalStudent, ISNULL(T6.HT,0) + ISNULL(T7.GC,0) AS NewStudent,
 T8.OldStudent, NULL AS StudentOut,T9.Leave,T10.StudentReserve , T11.ReserveEndMonth, T12.Reason AS NoteDecrease
 FROM EDMT2020 T1 WITH (NOLOCK) 
 LEFT JOIN #Table1 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.GradeID = T2.GradeID 
 LEFT JOIN EDMT1000 T3 WITH (NOLOCK) ON T3.GradeID = T1.GradeID
 LEFT JOIN AT1101  T4 WITH (NOLOCK) ON T1.DivisionID = T4.DivisionID 
 LEFT JOIN #Table2 T5 WITH (NOLOCK) ON T5.DivisionID = T1.DivisionID  AND T5.GradeID = T1.GradeID 
 LEFT JOIN #Table3 T6 WITH (NOLOCK) ON T6.DivisionID = T1.DivisionID
 LEFT JOIN #Table4 T7 WITH (NOLOCK) ON T7.DivisionID = T1.DivisionID
 LEFT JOIN #Table5 T8 WITH(NOLOCK) ON T8.DivisionID = T1.DivisionID
 LEFT JOIN #Table6 T9 WITH(NOLOCK) ON T9.DivisionID = T1.DivisionID
 LEFT JOIN #Table7 T10 WITH(NOLOCK) ON T10.DivisionID = T1.DivisionID
 LEFT JOIN #Table8 T11 WITH(NOLOCK) ON T11.DivisionID = T1.DivisionID
 LEFT JOIN #Table9 T12 WITH(NOLOCK) ON T12.DivisionID = T1.DivisionID

WHERE T1.DivisionID IN ('''+@DivisionID+''')  AND T1.DeleteFlg = 0
'+@sWhere+'
  
'




EXEC (@sSQL1+@sSQL)

PRINT @sSQL1
PRINT @sSQL










 




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
