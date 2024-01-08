IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2042]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2042]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load Tab thông tin EDMF2042: master điểm danh
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
--	EDMP2042 @DivisionID='VS', @UserID='ASOFTADMIN', @LanguageID = 'vi-VN', @APK=N'68371935-5A41-495B-912A-AA85F0A17673'

CREATE PROCEDURE [dbo].[EDMP2042]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @APK VARCHAR(50)
)
AS 
SET NOCOUNT ON

DECLARE @cLan VARCHAR(1)
DECLARE @sSQL NVARCHAR (MAX), @sWhere NVARCHAR(4000), @Param NVARCHAR(1000)
DECLARE @AttendanceDate DATETIME, @dStartMonth DATETIME, @dEndMonth DATETIME

--IF @LanguageID = 'vi-VN' SET @cLan = '' ELSE SET @cLan = 'E'

SET @sSQL = N'
SELECT A.DivisionID, A.APK, A.VoucherNo, A.SchoolYearID, A.SchoolYearID + '' ('' + CONVERT(VARCHAR(10), E.DateFrom, 103) + '' - '' + CONVERT(VARCHAR(10), E.DateTo, 103) + '')'' AS SchoolYearName
	, A.GradeID, C.GradeName, A.ClassID, D.ClassName, A.AttendanceDate
	, A.CreateUserID, A.CreateDate, A.LastModifyUserID, A.LastModifyDate
FROM EDMT2040 AS A WITH(NOLOCK) 
	LEFT JOIN (SELECT GradeID, GradeName FROM EDMT1000 WITH(NOLOCK) WHERE DivisionID IN (@DivisionID, ''@@@'') AND [Disabled] = 0) AS C ON A.GradeID = C.GradeID
	LEFT JOIN (SELECT ClassID, ClassName FROM EDMT1020 WITH(NOLOCK) WHERE DivisionID IN (@DivisionID, ''@@@'') AND [Disabled] = 0) AS D ON D.ClassID = A.ClassID
	LEFT JOIN EDMT1040 E WITH(NOLOCK) ON A.SchoolYearID = E.SchoolYearID
WHERE A.APK = @APK

'

SET @Param = '@DivisionID VARCHAR(50), @APK VARCHAR(50)'

EXEC sp_executesql @sSQL, @Param, @DivisionID, @APK


--PRINT @sSQL
--EXEC (@sSQL)

GO

SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

