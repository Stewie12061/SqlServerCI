IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2043]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2043]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load Tab thông tin EDMF2042: load detail điểm danh
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình, Date: 20/10/2018
-- <Example>
---- 
--	EDMP2043 @DivisionID='	BE', @UserID='ASOFTADMIN', @LanguageID = 'vi-VN', @APK=N'D4D8EACB-1BF3-4A0B-ADB7-C1E76681A641', @Mode = '0'

CREATE PROCEDURE [dbo].[EDMP2043]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @APK VARCHAR(50),
	 @Mode VARCHAR(1) = '0',
	 @PageNumber INT = 1,
	 @PageSize INT = 25
)
AS 
SET NOCOUNT ON

DECLARE @cLan VARCHAR(1)
DECLARE @sSQL NVARCHAR (MAX), @TotalRow NVARCHAR(50), @sWhere NVARCHAR(4000), @Param NVARCHAR(1000)
DECLARE @AttendanceDate DATETIME, @dStartMonth DATETIME, @dEndMonth DATETIME

SET @TotalRow = ''
IF @PageNumber = 1 SET @TotalRow = 'COUNT(1) OVER ()' ELSE SET @TotalRow = 'NULL'

IF @LanguageID = 'vi-VN' SET @cLan = '' ELSE SET @cLan = 'E'

SELECT @AttendanceDate = AttendanceDate FROM EDMT2040 WITH(NOLOCK) WHERE APK = @APK

SELECT @dStartMonth = DATEADD(mm, DATEDIFF(mm, 0, @AttendanceDate), 0)
--SELECT @dEndMonth = DATEADD(dd, -1, DATEADD(mm, 1, @dStartMonth))

-- Lấy ds học sinh trong tháng để tính sl phép (CP), không phép (KP), đi học (HD)
SELECT B.StudentID, CASE WHEN B.AvailableStatusID = 'HD' THEN 1 ELSE 0 END AS DayAvailable
	, CASE WHEN B.AvailableStatusID = 'CP' THEN 1 ELSE 0 END AS DayAbsentPermission
	, CASE WHEN B.AvailableStatusID = 'KP' THEN 1 ELSE 0 END AS DayAbsentNotPermission
INTO #EDMT2040_Month
FROM EDMT2040 A WITH(NOLOCK) INNER JOIN EDMT2041 B WITH(NOLOCK) ON A.APK = B.APKMaster
WHERE A.AttendanceDate BETWEEN @dStartMonth AND @AttendanceDate 
	AND EXISTS (SELECT TOP 1 1 FROM EDMT2041 C WITH(NOLOCK) WHERE C.APKMaster = @APK AND C.DeleteFlg = 0 AND C.StudentID = B.StudentID)
	AND A.DeleteFlg = 0 AND B.DeleteFlg = 0

SET @sSQL = N'
SELECT ROW_NUMBER() OVER (ORDER BY A.StudentID) AS RowNum, ' + @TotalRow + ' AS TotalRow
	, @APK AS APKMaster, A.APK, A.InheritAPKAbsence, A.DivisionID, A.StudentID, E.StudentName
	, A.IsException, A.DateException
	, A.AvailableStatusID,A.Reason, G.DayAvailable, G.DayAbsentPermission, G.DayAbsentNotPermission
	, H.ID AS AvailableStatusID, H.Description AS AvailableStatusName, A.CreateUserID, A.CreateDate, A.LastModifyUserID, A.LastModifyDate
FROM EDMT2041 AS A WITH(NOLOCK) 
	LEFT JOIN EDMT2010 AS E WITH(NOLOCK) ON A.StudentID = E.StudentID AND E.DeleteFlg = 0
	LEFT JOIN (
		SELECT StudentID, SUM(DayAvailable) AS DayAvailable, SUM(DayAbsentPermission) AS DayAbsentPermission, SUM(DayAbsentNotPermission) AS DayAbsentNotPermission
		FROM #EDMT2040_Month
		GROUP BY StudentID
	) AS G ON G.StudentID = A.StudentID
	LEFT JOIN (SELECT ID, Description' + @cLan + ' AS Description FROM EDMT0099 WITH(NOLOCK) WHERE CodeMaster = ''StudentAttendance'' AND [Disabled] = 0) AS H ON H.ID = A.AvailableStatusID
WHERE A.APKMaster = @APK AND A.DeleteFlg = 0
ORDER BY A.StudentID, E.StudentName
'

IF @Mode = '0' -- VIEW
BEGIN
	SET @sSQL = @sSQL + 'OFFSET ' + LTRIM(STR((@PageNumber-1)) * @PageSize) + ' ROWS
	FETCH NEXT ' + LTRIM(STR(@PageSize)) + ' ROWS ONLY'
END

SET @Param = '@DivisionID VARCHAR(50), @APK VARCHAR(50)'
--PRINT @sSQL
EXEC sp_executesql @sSQL, @Param, @DivisionID, @APK

DROP TABLE #EDMT2040_Month





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
