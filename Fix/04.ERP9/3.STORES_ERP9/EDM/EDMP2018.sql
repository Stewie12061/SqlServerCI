IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[EDMP2018]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP2018]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In, Xuất Excel Giấy xác nhận vào lớp (từ nghiệp vụ Xem chi tiết Hồ sơ học sinh)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Hòa, Date: 19/12/2018
-- <Example>
---- 
/*-- <Example>
	EDMP2018 @DivisionID = 'BE', @UserID = 'ASOFTADMIN', @LanguageID = '', @XML = '43D907F5-846D-4C7D-B4F2-0019BDBEF48F'
	SELECT * FROM EDMT2010 WHERE APK = '43D907F5-846D-4C7D-B4F2-0019BDBEF48F'
	EDMP2018 @DivisionID, @UserID, @LanguageID, @XML
----*/
CREATE PROCEDURE EDMP2018
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @XML XML
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N''

CREATE TABLE #EDMP2018 (APK VARCHAR(50))
INSERT INTO #EDMP2018 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)


SET @sSQL = @sSQL + N'
SELECT T1.DivisionID,T7.DivisionName, T1.APK, T1.StudentID, T1.StudentName, T1.DateOfBirth,
	T1.GradeID, T3.GradeName, T1.ClassID, T4.ClassName,
	T5.ArrangeClassID, T5.DateFrom as DateLearn, 
	T6.TeacherID, T6.TeacherName
FROM EDMT2010 T1 WITH(NOLOCK) 
	INNER JOIN #EDMP2018 ON T1.APK = #EDMP2018.APK
	LEFT JOIN  EDMT1000 T3 WITH(NOLOCK) ON T3.DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND T3.Disabled = 0 AND  T1.GradeID = T3.GradeID
	LEFT JOIN  EDMT1020 T4 WITH(NOLOCK) ON T4.DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND T4.Disabled = 0 AND T1.ClassID = T4.ClassID
	LEFT JOIN (SELECT EDMT2020.ArrangeClassID, EDMT2020.SchoolYearID, EDMT2020.ClassID,  EDMT1040.DateFrom
			FROM EDMT2020 WITH(NOLOCK) LEFT JOIN EDMT1040 WITH(NOLOCK) ON EDMT2020.SchoolYearID = EDMT1040.SchoolYearID
			WHERE EDMT2020.DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND EDMT2020.DeleteFlg = 0) AS T5 ON T1.ClassID = T5.ClassID
	LEFT JOIN (SELECT  EDMT2030.ClassID, EDMT2030.SchoolYearID , EDMT2031.TeacherID, H1.FullName AS TeacherName
			FROM EDMT2030 WITH(NOLOCK) LEFT JOIN EDMT2031 WITH(NOLOCK) ON EDMT2031.APKMaster = EDMT2030.APK  
			LEFT JOIN AT1103 H1 WITH(NOLOCK) ON H1.EmployeeID = EDMT2031.TeacherID
			WHERE EDMT2031.DivisionID IN (''' + @DivisionID + ''', ''@@@'') AND EDMT2030.DeleteFlg = 0) AS T6 ON T1.ClassID = T6.ClassID 
	LEFT JOIN AT1101 T7 WITH (NOLOCK) ON T7.DivisionID = T1.DivisionID


'




PRINT @sSQL
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

