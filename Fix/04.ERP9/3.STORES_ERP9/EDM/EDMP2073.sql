IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2073]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP2073]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Tab thông tin EDMF2072: load detail điều chuyển giáo viên
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Văn Tình, Date: 15/11/2018
-- <Example>
---- 
--	EDMP2073 'VS', 'ASOFTADMIN', 'vi-VN', N'68371935-5A41-495B-912A-AA85F0A17673', '0'

CREATE PROCEDURE [dbo].[EDMP2073]
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

IF @LanguageID = 'vi-VN' SET @cLan = '' ELSE SET @cLan = 'E'
SET @TotalRow = ''
IF @PageNumber = 1 SET @TotalRow = 'COUNT(1) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sSQL = N'
SELECT GradeID, GradeName INTO #Grade FROM EDMT1000 WITH(NOLOCK) WHERE DivisionID IN (@DivisionID, ''@@@'') AND [Disabled] = 0
SELECT ClassID, ClassName INTO #Class FROM EDMT1020 WITH(NOLOCK) WHERE DivisionID IN (@DivisionID, ''@@@'') AND [Disabled] = 0

SELECT ROW_NUMBER() OVER (ORDER BY A.APK) AS RowNum, ' + @TotalRow + ' AS TotalRow
	, @APK AS APKMaster, A.APK, A.DivisionID, A.TeacherID, H1.FullName AS TeacherName
	, A.GradeIDFrom, C.GradeName AS GradeNameFrom, A.ClassIDFrom, D.ClassName AS ClassNameFrom
	, A.GradeIDTo, E.GradeName AS GradeNameTo, A.ClassIDTo, F.ClassName AS ClassNameTo
	, A.DateFrom, A.DateTo, A.Notes, A.CreateUserID, A.CreateDate, A.LastModifyUserID, A.LastModifyDate
FROM EDMT2071 AS A WITH(NOLOCK) 
	LEFT JOIN AT1103 H1 WITH(NOLOCK) ON H1.EmployeeID = A.TeacherID
	LEFT JOIN #Grade AS C ON C.GradeID = A.GradeIDFrom
	LEFT JOIN #Class AS D ON D.ClassID = A.ClassIDFrom
	LEFT JOIN #Grade AS E ON E.GradeID = A.GradeIDTo
	LEFT JOIN #Class AS F ON F.ClassID = A.ClassIDTo
WHERE A.APKMaster = @APK AND A.DeleteFlg = 0
ORDER BY A.APK
'
IF @Mode = '0' -- VIEW
BEGIN
	SET @sSQL = @sSQL + 'OFFSET ' + LTRIM(STR((@PageNumber-1)) * @PageSize) + ' ROWS
	FETCH NEXT ' + LTRIM(STR(@PageSize)) + ' ROWS ONLY'
END

SET @Param = '@DivisionID VARCHAR(50), @APK VARCHAR(50)'
--PRINT @sSQL
EXEC sp_executesql @sSQL, @Param, @DivisionID, @APK

--PRINT @sSQL
--EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

