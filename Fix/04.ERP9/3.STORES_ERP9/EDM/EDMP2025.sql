IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[EDMP2025]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP2025]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- In, Xuất Excel Giấy xác nhận vào lớp (từ nghiệp vụ xếp lớp)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 7/5/2019
-- <Example>
---- 
/*-- <Example>
	 exec EDMP2025 @DivisionID = 'BE', @UserID = 'ASOFTADMIN', @LanguageID = 'vi-VN', 
	@XML = N'<Data><APK>5C464DAA-E165-4388-B241-649203C24F61</APK></Data>
			 <Data><APK>04BF7258-2934-4C4B-93F3-F648DCF7CE53</APK></Data>
	', @Mode = 1, @StudentID = 'HS/2019/02/0008'',''HS/2019/02/0007'',''HS/2019/03/0027'

	 exec EDMP2025 @DivisionID = 'BE', @UserID = 'ASOFTADMIN', @LanguageID = 'vi-VN', 
	@XML = N'<Data><APK>5C464DAA-E165-4388-B241-649203C24F61</APK></Data>
			 <Data><APK>04BF7258-2934-4C4B-93F3-F648DCF7CE53</APK></Data>
	', @Mode = 0, @StudentID = '' 
 
	EDMP2025 @DivisionID, @UserID, @LanguageID, @XML, @Mode, @StudentID
----*/
CREATE PROCEDURE EDMP2025
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @XML XML,
	 @Mode VARCHAR(50),
	 @StudentID VARCHAR(4000)
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N''

CREATE TABLE #EDMP2025 (APK VARCHAR(50))
INSERT INTO #EDMP2025 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)


CREATE TABLE #DataEDMP2025 (
    DivisionID VARCHAR(50),
    DivisionName NVARCHAR(250),
	APK VARCHAR(50),
	StudentID VARCHAR(50),
	StudentName NVARCHAR(250),
	DateOfBirth DATETIME,
	ArrangeClassID VARCHAR(50),
	GradeID VARCHAR(50),
	ClassID VARCHAR(50),
	DateLearn DATETIME,
	TeacherID VARCHAR(50),
	TeacherName NVARCHAR (250) 
)

DELETE FROM #DataEDMP2025



DECLARE
		@Cur CURSOR, 
		@APK VARCHAR(50),
		@CurDivisionID VARCHAR(50),
		@ClassID VARCHAR(50), 
		@GradeID VARCHAR(50),
		@SchoolYearID VARCHAR(50)
		

SET @Cur = CURSOR SCROLL KEYSET FOR
SELECT EDMT2020.DivisionID,#EDMP2025.APK, EDMT2020.SchoolYearID, EDMT2020.GradeID, EDMT2020.ClassID 
FROM EDMT2020 WITH (NOLOCK) 
INNER JOIN #EDMP2025 ON EDMT2020.APK = #EDMP2025.APK 
OPEN @Cur
FETCH NEXT FROM @Cur INTO @CurDivisionID,@APK,@SchoolYearID,@GradeID,@ClassID
WHILE @@FETCH_STATUS = 0
BEGIN

INSERT INTO #DataEDMP2025
SELECT T1.DivisionID,T4.DivisionName,T1.APK,T2.StudentID, T3.StudentName, T3.DateOfBirth,
		T1.ArrangeClassID, T1.GradeID,T1.ClassID, T5.DateFrom AS DateLearn, T6.TeacherID, T6.TeacherName
 FROM EDMT2020 T1 WITH (NOLOCK)
		LEFT JOIN EDMT2021 T2 WITH (NOLOCK) ON T1.APK = T2.APKMaster AND T2.DeleteFlg = 0 
		LEFT JOIN EDMT2010 T3 WITH (NOLOCK) ON T3.DivisionID = T1.DivisionID AND T3.StudentID = T2.StudentID 
		LEFT JOIN AT1101   T4 WITH (NOLOCK) ON T4.DivisionID = T1.DivisionID
		LEFT JOIN EDMT1040 T5 WITH (NOLOCK) ON T5.SchoolYearID = T1.SchoolYearID
		LEFT JOIN (
					SELECT B.DivisionID,B.SchoolYearID, B.GradeID, B.ClassID,
					Stuff(isnull((	Select  ', ' + X.TeacherID From  
												(	Select DISTINCT A1.DivisionID,A1.APK, A2.TeacherID
													From EDMT2030 A1 WITH (NOLOCK)
													LEFT JOIN EDMT2031 A2 WITH (NOLOCK) ON A1.APK = A2.APKMaster AND A2.DeleteFlg = 0
													WHERE A1.DivisionID = @CurDivisionID AND A1.DeleteFlg = 0 AND  A2.DeleteFlg = 0 
												) X
								Where X.APK = B.APK and X.DivisionID= B.DivisionID
								FOR XML PATH (''), TYPE).value('.','NVARCHAR(max)'), ''), 1, 1, '') AS TeacherID,
					Stuff(isnull((	Select  ', ' + Y.TeacherName From  
												(	Select DISTINCT A3.DivisionID,A3.APK, A4.TeacherID,A5.FullName AS TeacherName
													From EDMT2030 A3 WITH (NOLOCK)
													LEFT JOIN EDMT2031 A4 WITH (NOLOCK) ON A3.APK = A4.APKMaster 
													LEFT JOIN AT1103 A5 WITH (NOLOCK) ON A5.DivisionID IN (@CurDivisionID,'@@@') AND A5.EmployeeID = A4.TeacherID
													WHERE A3.DivisionID = @CurDivisionID AND A3.DeleteFlg = 0 AND  A4.DeleteFlg = 0 
												) Y
								Where Y.APK  =  B.APK and Y.DivisionID= B.DivisionID
								FOR XML PATH (''), TYPE).value('.','NVARCHAR(max)'), ''), 1, 1, '') AS TeacherName
FROM EDMT2030 B WITH (NOLOCK) 
WHERE B.DivisionID = @CurDivisionID AND B.SchoolYearID = @SchoolYearID AND B.GradeID = @GradeID AND B.ClassID = @ClassID AND B.DeleteFlg = 0 
			
					) AS T6 ON T6.DivisionID = T1.DivisionID  AND T6.SchoolYearID = T1.SchoolYearID AND T6.GradeID = T1.GradeID AND T6.ClassID = T1.ClassID 


 WHERE T1.DivisionID = @CurDivisionID AND T1.DeleteFlg = 0  AND T1.APK = @APK 



FETCH NEXT FROM @Cur INTO @CurDivisionID,@APK,@SchoolYearID,@GradeID,@ClassID
END

Close @Cur


IF @Mode = 0 
BEGIN 

SELECT * FROM #DataEDMP2025

END 
ELSE IF @Mode = 1 
BEGIN
SET @sSQL = '

SELECT * FROM #DataEDMP2025 WHERE StudentID IN ('''+@StudentID+''') 

'
END 




PRINT (@sSQL)
EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

