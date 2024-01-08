IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2034]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2034]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load combo lớp 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo on 9/4/2019
-- <Example>
---- 
--	EDMP2034 @DivisionID='BE', @UserID='ASOFTADMIN', @SreenID = 'EDMF2131', @GradeID = '56533'',''', @SchoolYearID = '2013-2014',@APK=''
--- EDMP2034 @DivisionID='BE', @UserID='ASOFTADMIN', @SreenID = 'EDMF2141', @GradeID = '56533', @SchoolYearID = '',@APK=''

CREATE PROCEDURE [dbo].[EDMP2034]
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @SreenID VARCHAR(50),
	 @GradeID VARCHAR(50),
	 @SchoolYearID VARCHAR(50),
	 @APK VARCHAR(50) 
)
AS 

DECLARE @sSQL NVARCHAR(MAX)

IF @SreenID = 'EDMF2031' ---Phân công giáo viên 
	BEGIN 

	SELECT A.ClassID, A.ClassName
	From EDMT1020 A WITH(NOLOCK) 
	WHERE A.DivisionID IN (@DivisionID, '@@@') AND [Disabled] = 0 
	AND A.GradeID = @GradeID
	AND EXISTS (SELECT B.ClassID FROM EDMT2020 B WITH (NOLOCK) WHERE B.DivisionID = @DivisionID AND  B.ClassID = A.ClassID AND B.SchoolYearID = @SchoolYearID AND B.DeleteFlg = 0)
	AND NOT EXISTS (SELECT C.ClassID FROM EDMT2030 C WITH (NOLOCK) WHERE C.DivisionID = @DivisionID AND C.ClassID = A.ClassID AND C.GradeID = @GradeID AND C.SchoolYearID = @SchoolYearID AND CONVERT(VARCHAR(50),C.APK) != @APK AND C.DeleteFlg = 0) 
	ORDER BY ClassID


	END 

ELSE IF @SreenID = 'EDMF2041'

	BEGIN
	 
	SELECT A.ClassID, A.ClassName
	From EDMT1020 A WITH(NOLOCK) 
	WHERE A.DivisionID IN (@DivisionID, '@@@') AND [Disabled] = 0 
	AND A.GradeID = @GradeID
	AND EXISTS (SELECT B.ClassID FROM EDMT2020 B WITH (NOLOCK) WHERE B.DivisionID = @DivisionID AND  B.ClassID = A.ClassID AND B.SchoolYearID = @SchoolYearID AND B.DeleteFlg = 0 )
	ORDER BY ClassID


	END 


ELSE IF @SreenID = 'EDMF2131'

	BEGIN 

	SET @sSQL = N'
	SELECT ClassID, ClassName FROM EDMT1020 A WITH (NOLOCK) 
	WHERE A.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A.GradeID IN ('''+@GradeID+''') AND A.Disabled = 0
	AND EXISTS (SELECT B.ClassID FROM EDMT2020 B WITH (NOLOCK) WHERE B.DivisionID = '''+@DivisionID+''' AND  B.ClassID = A.ClassID AND B.SchoolYearID = '''+@SchoolYearID+''' AND B.DeleteFlg = 0)
	ORDER BY ClassID
	'

	END 

ELSE IF @SreenID = 'EDMF2141'
	BEGIN

	SELECT A.ClassID, A.ClassName
	From EDMT1020 A WITH(NOLOCK) 
	WHERE A.DivisionID IN (@DivisionID, '@@@') AND [Disabled] = 0 
	AND A.GradeID = @GradeID
	AND EXISTS (SELECT B.ClassID FROM EDMT2020 B WITH (NOLOCK) WHERE B.DivisionID = @DivisionID AND  B.ClassID = A.ClassID AND B.DeleteFlg = 0 )
	ORDER BY ClassID

	END 

ELSE IF @SreenID = 'EDMF2071'----Điều chuyển giáo viên 
	BEGIN

	SELECT A.ClassID, A.ClassName
	FROM EDMT1020 A WITH(NOLOCK) 
	WHERE A.DivisionID IN (@DivisionID, '@@@') AND [Disabled] = 0 
	AND A.GradeID = @GradeID
	AND EXISTS (SELECT B.ClassID FROM EDMT2030 B WITH (NOLOCK) WHERE B.DivisionID = @DivisionID AND  B.ClassID = A.ClassID AND B.DeleteFlg = 0 )
	ORDER BY ClassID

	END 







PRINT @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
