IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[EDMP2061]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP2061]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load  thành viên dự giờ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Minh Hòa on 18/11/2018
-- <Example>
---- 
/*-- <Example>
	EDMP2061 @DivisionID = 'VS', @UserID = 'ASOFTADMIN', @APK = 'DF74CDCC-89B8-40F3-90A3-58353EB3147A', @LanguageID ='vi-VN'

	EDMP2061 @DivisionID, @UserID, @APK, @LanguageID
----*/
CREATE PROCEDURE EDMP2061
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @APK VARCHAR(50),
	 @LanguageID VARCHAR(50)
)

AS 

DECLARE @sSQL NVARCHAR(MAX)

SET @sSQL = N'
	SELECT A.APKMaster, A.MemberID, H1.FullName AS MemberName  
	INTO #EDMT2061 
	FROM EDMT2061 A WITH(NOLOCK) LEFT JOIN AT1103 H1 WITH(NOLOCK) ON H1.EmployeeID = A.MemberID AND H1.DivisionID IN (A.DivisionID,''@@@'')
	WHERE A.APKMaster = '''+ @APK + ''' AND A.DeleteFlg = 0

SELECT T1.APKMaster,
	STUFF((  
			SELECT '','' +  T2.MemberName
			FROM #EDMT2061 T2  
			WHERE T1.APKMaster = T2.APKMaster  
			ORDER BY T2.MemberID

			FOR XML PATH ('''')  
        ),1,1,'''')  AS MemberName
	INTO #MemberName
FROM #EDMT2061 T1 
GROUP BY T1.APKMaster
'

--SET @sSQL = @sSQL + N'SELECT APKMaster, TeacherTempName AS MemberName
--FROM #TeacherTempName
--WHERE APKMaster = '''+@APK+'''

--DROP TABLE #TeacherTempName

SET @sSQL = @sSQL + N'
	SELECT T1.APK, T1.EvaluetionID, T1.EvaluetionDate, T1.SchoolYearID, 
	T1.GradeID, T3.GradeName, T1.ClassID, T4.ClassName, 
	T1.TeacherID, A1.FullName AS TeacherName, T2.MemberName AS MemberID,  
	Time, T1.ResultID, 
	'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T5.Description' ELSE 'T5.DescriptionE' END +' as ResultName, 
	T1.Content
	FROM EDMT2060 T1 WITH (NOLOCK)
	LEFT JOIN #MemberName T2 ON T1.APK = T2.APKMaster
	LEFT JOIN AT1103  A1 WITH (NOLOCK) ON T1.TeacherID = A1.EmployeeID AND A1.DivisionID IN (T1.DivisionID,''@@@'')
	LEFT JOIN EDMT1000 T3 WITH (NOLOCK) ON T1.GradeID = T3.GradeID 
	LEFT JOIN EDMT1020 T4 WITH (NOLOCK) ON T1.ClassID = T4.ClassID
	LEFT JOIN EDMT0099 T5 WITH (NOLOCK) ON T1.ResultID = T5.ID AND T5.Disabled = 0 AND T5.CodeMaster=''EvaluetionResult''
	
	WHERE T1.APK = '''+@APK+'''
	 AND  T1.DivisionID = '''+@DivisionID+'''
	DROP TABLE #MemberName

'

--PRINT @sSQL
 EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

