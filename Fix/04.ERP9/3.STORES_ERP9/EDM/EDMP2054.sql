IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2054]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2054]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In phiếu sổ nhật ký của bé 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo on 20/4/2019
-- <Example>
/*

EXEC EDMP2054 @DivisionID, @UserID,@LanguageID,@XML

declare @p4 xml
set @p4=convert(xml,N'<Data><APK>2DF8217A-7DF8-4205-AEA8-12DECB1EFBE0</APK></Data>
					  <Data><APK>67574749-B7D2-4B00-81B7-909F5AE6362C</APK></Data>')
exec EDMP2054 @DivisionID=N'BE',@UserID=N'ASOFTADMIN',@LanguageID=N'vi-VN',@XML=@p4

*/

CREATE PROCEDURE EDMP2054 ( 
         @DivisionID VARCHAR(50),
		 @UserID VARCHAR(50), 
		 @LanguageID VARCHAR (50),
		 @XML XML
		
) 
AS 

DECLARE 
	@sSQL NVARCHAR(MAX)
	
CREATE TABLE #EDMP2054 (APK VARCHAR(50))
INSERT INTO #EDMP2054 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)




BEGIN 

SET @sSQL = '
SELECT T1.DivisionID,T3.DivisionName,T1.VoucherResult,T1.StudentID,T2.StudentName,T2.DateOfBirth,T1.ClassID,T4.ClassName,T1.Content,T1.FeelingID,T5.FeelingName,
T6.DishID,T7.DishName, T6.MealID,T8.MealName, T6.StatusID,
'+ CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T9.Description' ELSE 'T9.DescriptionE' END +' as StatusName,
T1.HoursFrom,T1.HoursTo,T1.TeacherNotes,T1.ParentNotes,T1.EnglishVocabulary,
Stuff(isnull((	Select  '', '' + X.TeacherName From  
												(	Select DISTINCT A.DivisionID,A.TeacherID,C.FullName AS TeacherName, B.ClassID,B.GradeID, B.SchoolYearID
													From EDMT2031 A WITH (NOLOCK)
													LEFT JOIN EDMT2030 B WITH (NOLOCK) ON A.APKMaster = B.APK
													LEFT JOIN AT1103 C WITH (NOLOCK) ON A.TeacherID = C.EmployeeID
													WHERE A.DivisionID = '''+@DivisionID+''' AND A.DeleteFlg = 0 AND B.DeleteFlg = 0
												) X
								Where  X.DivisionID= T1.DivisionID AND X.ClassID = T1.ClassID AND X.GradeID = T1.GradeID AND X.SchoolYearID = T1.SchoolYearID AND T1.DeleteFlg = 0
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') AS TeacherName

FROM EDMT2050 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T2.StudentID = T1.StudentID AND T2.DeleteFlg = 0
LEFT JOIN AT1101 T3 WITH (NOLOCK) ON T3.DivisionID = T1.DivisionID  
LEFT JOIN EDMT1020 T4 WITH (NOLOCK) ON T4.DivisionID IN ('''+@DivisionID+''',''@@@'') AND T4.ClassID = T1.ClassID
LEFT JOIN EDMT1080 T5 WITH (NOLOCK) ON T5.DivisionID IN ('''+@DivisionID+''',''@@@'') AND T5.FeelingID = T1.FeelingID 
LEFT JOIN EDMT2051 T6 WITH (NOLOCK) ON T6.DivisionID = T1.DivisionID  AND T6.APKMaster =  T1.APK 
LEFT JOIN NMT1050  T7 WITH (NOLOCK) ON T6.DishID = T7.DishID
LEFT JOIN NMT1060  T8 WITH (NOLOCK) ON T6.MealID = T8.MealID
LEFT JOIN EDMT0099 T9 WITH (NOLOCK) ON T6.StatusID = T9.ID AND T9.Disabled = 0 AND T9.CodeMaster=''EatingStatus''
INNER JOIN #EDMP2054 T10 WITH (NOLOCK) ON T10.APK = T1.APK 
WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.DeleteFlg = 0  AND T6.DeleteFlg = 0 
ORDER BY T1.VoucherResult

'

END 

--PRINT @sSQL
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


