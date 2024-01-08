IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2041]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2041]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- EDMF2041: điểm danh - tính số ngày đi học, nghỉ phép và k phép của 1 hay nhiều học sinh
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình, Date: 30/10/2018
-- <Example>
---- 
--	EDMP2041 @DivisionID='VS', @UserID='ASOFTADMIN', @LanguageID = 'vi-VN', @AttendanceDate = '20181103', @StudentID = 'fsfs'

CREATE PROCEDURE [dbo].[EDMP2041]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @AttendanceDate DATETIME,
	 @StudentID VARCHAR(50) = '', 
	 @StudentIDList VARCHAR(4000) = ''
)
AS 
SET NOCOUNT ON

DECLARE @cLan VARCHAR(1)
DECLARE @sSQL NVARCHAR (MAX)
DECLARE @dStartMonth DATETIME, @dEndMonth DATETIME
DECLARE @DayAvailable INT = 0, @DayAbsentPermission INT = 0, @DayAbsentNotPermission INT = 0

IF @AttendanceDate IS NULL
BEGIN
	SELECT @StudentID AS StudentID, @DayAvailable AS DayAvailable, @DayAbsentPermission AS DayAbsentPermission, @DayAbsentNotPermission AS DayAbsentNotPermission
	RETURN
END

IF @StudentID = '' AND @StudentIDList = ''
BEGIN
	SELECT '' AS StudentID, @DayAvailable AS DayAvailable, @DayAbsentPermission AS DayAbsentPermission, @DayAbsentNotPermission AS DayAbsentNotPermission
	RETURN
END

SELECT @dStartMonth = DATEADD(mm, DATEDIFF(mm, 0, @AttendanceDate), 0)
--SELECT @dEndMonth = DATEADD(dd, -1, DATEADD(mm, 1, @dStartMonth))

CREATE TABLE #Student(StudentID VARCHAR(50), DayAvailable INT, DayAbsentPermission INT, DayAbsentNotPermission INT)

-- Lấy ds học sinh trong tháng để tính sl phép (CP), không phép (KP), đi học (HD)
SET @sSQL = '
INSERT INTO #Student(StudentID, DayAvailable, DayAbsentPermission, DayAbsentNotPermission)
SELECT B.StudentID, CASE WHEN B.AvailableStatusID = ''HD'' THEN 1 ELSE 0 END AS DayAvailable
		, CASE WHEN B.AvailableStatusID = ''CP'' THEN 1 ELSE 0 END AS DayAbsentPermission
		, CASE WHEN B.AvailableStatusID = ''KP'' THEN 1 ELSE 0 END AS DayAbsentNotPermission
	FROM EDMT2040 A WITH(NOLOCK) INNER JOIN EDMT2041 B WITH(NOLOCK) ON A.APK = B.APKMaster
	WHERE A.DeleteFlg = 0 AND B.DeleteFlg = 0 AND A.AttendanceDate BETWEEN ''' + CONVERT(VARCHAR(8), @dStartMonth, 112) + ''' AND ''' + CONVERT(VARCHAR(8), @AttendanceDate, 112) + ''' 
	AND A.DivisionID = ''' + @DivisionID + ''' '

IF @StudentIDList = '' 
	SET @sSQL += ' AND B.StudentID = ''' + @StudentID + ''' '
ELSE
	SET @sSQL += ' AND B.StudentID IN (''' + @StudentIDList + ''') '

--PRINT @sSQL
EXEC (@sSQL)

SELECT A.StudentID, SUM(A.DayAvailable) AS DayAvailable, SUM(A.DayAbsentPermission) AS DayAbsentPermission, SUM(A.DayAbsentNotPermission) AS DayAbsentNotPermission
	, MAX(B.StudentName) AS StudentName
FROM #Student A LEFT JOIN EDMT2010 B WITH(NOLOCK) ON A.StudentID = B.StudentID
GROUP BY A.StudentID

GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

