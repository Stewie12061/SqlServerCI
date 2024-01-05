IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP30013]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP30013]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Danh sách Tổng sĩ số & Tổng hiện diện trong ngày
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by:	Lương Mỹ, Date: 15/01/2020
-- <Example>
---- 
/*-- <Example>
  
  EXEC EDMP30013 'VS', 'BGD',12,2018
  EDMP30013 @DivisionID= 'BE',@Month = '7',@Year = '2019'

  exec EDMP30013 @DivisionID=N'BE'',''CDX'',''CG'',''HA'',''HP'',''HTX'',''KT'',''LE'',''LU'',''MR'',''NC'',''OG'',''OP'',''OR'',''PH'',''PM'',''SU'',''TS'',''VP',
@GradeID=N'MG-3-4'',''MG-3-6'',''MG-4-5'',''MG-5-6'',''MYEST'',''NT-06-12'',''NT-13-18'',''NT-18-24'',''NT-25-36',
@FromDate='2019-11-01 00:00:00',@ToDate='2019-11-01 00:00:00'




----*/

CREATE PROCEDURE EDMP30013
(
	@DivisionID			VARCHAR(MAX),
	@GradeID			VARCHAR(MAX),
	@FromDate 			DATETIME		
)
AS

SET NOCOUNT ON


DECLARE @sSQL   NVARCHAR(MAX)=N'',
		@SQL1 NVARCHAR(MAX) = N'',
		@SQL2 NVARCHAR(MAX)=N'',
		@sWhere NVARCHAR(MAX) = N''
	
	
IF @DivisionID <> ''
BEGIN

	SELECT Value AS DivisionID
	INTO #DivisionFilter
	FROM dbo.StringSplit(@DivisionID,''',''')
	WHERE Value <> ','
	--SELECT * FROM	#DivisionFilter
END

IF @GradeID <> '' 
		SET @sWhere = @sWhere + ' AND A.GradeID IN ('''+@GradeID+''') '

DECLARE @DateFromYear DATETIME,
		@SchoolYear VARCHAR(50),
		@dStartMonth DATETIME


SELECT TOP 1  @DateFromYear = DateFrom,@SchoolYear = SchoolYearID  
FROM EDMT1040 WITH(NOLOCK) 
WHERE [Disabled] = 0 AND @FromDate BETWEEN DateFrom AND DateTo

---Đầu tháng 
SELECT @dStartMonth = DATEADD(mm, DATEDIFF(mm, 0, @FromDate), 0)

-------Lấy sỉ số tháng hiện tại theo ngày in 
SELECT COUNT(T2.StudentID)  AS Total, T1.DivisionID,B.Leave
 INTO #DATA4
 FROM EDMT2020 T1 WITH (NOLOCK) 
 INNER JOIN EDMT2021 T2 WITH (NOLOCK) ON T2.APKMaster = T1.APK AND T2.DivisionID = T1.DivisionID
 LEFT JOIN 
 (SELECT COUNT(StudentID) AS Leave, A.DivisionID
  FROM 
		(
		SELECT T1.DivisionID,
		T1.LeaveDate,T1.StudentID, T2.SchoolYearID,T2.GradeID,
		'LeaveSchool' AS [Name]
		FROM EDMT2080 T1 WITH (NOLOCK) 
		INNER JOIN EDMT2020 T2 WITH (NOLOCK) ON T2.ArrangeClassID = T1.ArrangeClassID AND T2.DeleteFlg = 0
		INNER JOIN EDMT2021 T3 WITH (NOLOCK) ON T3.APKMaster = T3.APK AND T1.StudentID = T3.StudentID
		INNER JOIN #DivisionFilter T4 ON T4.DivisionID = T1.DivisionID
		WHERE  T1.DeleteFlg = 0
		AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.LeaveDate,120), 126) BETWEEN   @DateFromYear  AND @FromDate
		AND T1.OldStatusID <> 4 
		  
		
		 UNION ALL 
		 
		 -----Bảo lưu 
		 SELECT T1.DivisionID,
		 T1.FromDate AS LeaveDate,T1.StudentID,T1.SchoolYearID, T1.GradeID,
		 'Reserve' AS [Name] 
		 FROM EDMT2150 T1 WITH (NOLOCK) 
		 INNER JOIN EDMT2020 T2 WITH(NOLOCK) ON T1.SchoolYearID = T2.SchoolYearID AND T1.GradeID = T2.GradeID AND T1.ClassID = T2.ClassID AND T2.DeleteFlg = 0
		 INNER JOIN EDMT2021 T3 WITH (NOLOCK) ON T3.APKMaster = T3.APK AND T1.StudentID = T3.StudentID
		 INNER JOIN #DivisionFilter T4 ON T4.DivisionID = T1.DivisionID

		 WHERE T1.DeleteFlg = 0 
		 AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromDate,120), 126) BETWEEN   @DateFromYear  AND @FromDate
		
		 UNION ALL 
		
		 ---Chuyển trường 
		 SELECT T1.DivisionID,
		 T1.FromEffectiveDate AS LeaveDate ,T1.StudentID, T2.SchoolYearID, T2.GradeID,
		 'Transfer' AS [Name] 
		 FROM EDMT2140 T1 WITH (NOLOCK) 
		 INNER JOIN EDMT2020 T2 WITH (NOLOCK) ON T1.ArrangeClassIDFrom = T2.ArrangeClassID AND T2.DeleteFlg = 0
		 INNER JOIN EDMT2021 T3 WITH (NOLOCK) ON T3.APKMaster = T3.APK AND T1.StudentID = T3.StudentID
		 INNER JOIN #DivisionFilter T4 ON T4.DivisionID = T1.DivisionID

		 WHERE T1.DeleteFlg = 0 
		 AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.FromEffectiveDate,120), 126) BETWEEN   @DateFromYear  AND @FromDate
		 AND T1.DivisionID <> T1.SchoolIDTo
		  
		) AS A
		GROUP BY A.DivisionID
 )  AS B ON B.DivisionID = T1.DivisionID 
 
 WHERE  T1.DeleteFlg = 0
		AND  NOT EXISTS (SELECT A1.StudentID FROM EDMT2021 A1 WITH (NOLOCK) WHERE  A1.DivisionID = T2.DivisionID AND 
						T2.StudentID = A1.StudentID  AND T2.APK = A1.APK 
						AND (A1.IsTransfer = 0 AND A1.DeleteFlg = 1) OR (T2.IsTransfer IN (1,2) AND T2.DeleteFlg = 1 AND CONVERT(DATE,T2.LastModifyDate) < @FromDate))
		AND CONVERT(VARCHAR(10), CONVERT(DATE, T2.CreateDate,120), 126) <= @FromDate
		
 GROUP BY T1.DivisionID,B.Leave

 --SELECT * FROM #DATA4


-----Lấy sỉ số hiện diện 
SET @sSQL = '
SELECT T1.DivisionID, COUNT(T2.StudentID) AS Available
INTO #DATA3
FROM EDMT2040 T1 WITH (NOLOCK) 
OUTER APPLY (SELECT TOP 1 * FROM EDMT2040 T3 WITH (NOLOCK) WHERE T1.DivisionID = T3.DivisionID AND T1.ClassID = T3.ClassID 
			AND T1.GradeID = T3.GradeID AND T1.SchoolYearID = T3.SchoolYearID AND T1.AttendanceDate = T3.AttendanceDate  AND T3.DeleteFlg = 0 
			 ORDER BY T3.CreateDate DESC) A
LEFT JOIN EDMT2041 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg 
WHERE T1.DeleteFlg = 0  
	AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.AttendanceDate,120), 126) = '''+CONVERT(VARCHAR(10),@FromDate,126)+'''  
	AND T2.AvailableStatusID = ''HD''
	AND T1.CreateDate = A.CreateDate AND T1.DeleteFlg = 0  '+@sWhere+'
GROUP BY T1.DivisionID
 


-----VẮNG CÓ PHÉP 

 
SELECT  T1.DivisionID, COUNT(T2.StudentID) AS AbsentPermission
INTO #DATA1 
FROM EDMT2040 T1 WITH (NOLOCK) 
OUTER APPLY (SELECT TOP 1 * FROM EDMT2040 T3 WITH (NOLOCK) WHERE T1.ClassID = T3.ClassID AND T1.GradeID = T3.GradeID 
			 AND T1.SchoolYearID = T3.SchoolYearID and T1.AttendanceDate = T3.AttendanceDate  AND T3.DeleteFlg = 0 
			 ORDER BY T3.CreateDate DESC) A
INNER JOIN EDMT2041 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg 
WHERE T1.DeleteFlg = 0  AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.AttendanceDate,120), 126) = '''+CONVERT(VARCHAR(10),@FromDate,126)+''' 
AND T2.AvailableStatusID = ''CP''
AND T1.CreateDate = A.CreateDate AND T1.DeleteFlg = 0 '+@sWhere+'
GROUP BY T1.DivisionID
 
-----Nghỉ không phép 

SELECT  T1.DivisionID, COUNT(DISTINCT T2.StudentID) AS AbsentNotPermission
INTO #DATA2 
FROM EDMT2040 T1 WITH (NOLOCK) 
OUTER APPLY (SELECT TOP 1 * FROM EDMT2040 T3 WITH (NOLOCK) WHERE T1.ClassID = T3.ClassID AND T1.GradeID = T3.GradeID 
			 AND T1.SchoolYearID = T3.SchoolYearID and T1.AttendanceDate = T3.AttendanceDate  AND T3.DeleteFlg = 0 
			 ORDER BY T3.CreateDate DESC) A
INNER JOIN EDMT2041 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T1.DeleteFlg = T2.DeleteFlg 
WHERE T1.DeleteFlg = 0  AND CONVERT(VARCHAR(10), CONVERT(DATE, T1.AttendanceDate,120), 126) = '''+CONVERT(VARCHAR(10),@FromDate,126)+''' 
AND T2.AvailableStatusID = ''KP''
AND T1.CreateDate = A.CreateDate AND T1.DeleteFlg = 0 '+@sWhere+'
GROUP BY T1.DivisionID



'



SET @SQL2 = '

SELECT DISTINCT A.DivisionID,T2.DivisionName,
(ISNULL(T1.Total,0) - ISNULL(T1.Leave,0)) StudentTotal,
ISNULL(T4.Available,0) AS Available
FROM EDMT2020 A WITH (NOLOCK) 
LEFT JOIN #DATA4 T1 WITH (NOLOCK) ON T1.DivisionID = A.DivisionID
LEFT JOIN AT1101 T2 WITH (NOLOCK) ON A.DivisionID = T2.DivisionID
LEFT JOIN #DATA3 T4 WITH (NOLOCK) ON T4.DivisionID = A.DivisionID 


WHERE A.DivisionID IN ('''+@DivisionID+''')
'+@sWhere+'
  
'

--PRINT (@SQL1+@sSQL+@SQL2)
exec (@SQL1+@sSQL+@SQL2)








GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
