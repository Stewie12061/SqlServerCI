IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2063]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2063]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load  combo giáo viên từ phân công giáo viên 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 10/04/2019
-- <Example>
---- 
/*-- <Example>
	EDMP2063 @DivisionID = 'BE', @UserID = 'ASOFTADMIN', @SchoolYearID = '2015-2016',@GradeID= 'MG2',@ClassID = 'MG2'
	
	EDMP2063 @DivisionID, @UserID, @SchoolYearID,@GradeID,@ClassID
----*/
CREATE PROCEDURE EDMP2063
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @SchoolYearID VARCHAR(50),
	 @GradeID VARCHAR(50),
	 @ClassID VARCHAR(50)
)

AS 

DECLARE @sSQL NVARCHAR(MAX) = ''



SET @sSQL = N'
SELECT EDMT2030.APK,EDMT2031.TeacherID, AT1103.FullName AS TeacherName 
FROM EDMT2030 WITH (NOLOCK)
INNER JOIN EDMT2031 WITH (NOLOCK) ON EDMT2030.APK = EDMT2031.APKMaster AND EDMT2030.DeleteFlg = EDMT2031.DeleteFlg 
LEFT JOIN AT1103 WITH (NOLOCK) ON AT1103.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1103.EmployeeID = EDMT2031.TeacherID
WHERE EDMT2030.DivisionID = '''+@DivisionID+''' AND EDMT2030.SchoolYearID = '''+@SchoolYearID+''' AND EDMT2030.GradeID = '''+@GradeID+''' AND EDMT2030.ClassID = '''+@ClassID+''' AND EDMT2030.DeleteFlg = 0

'

PRINT @sSQL
 EXEC (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
