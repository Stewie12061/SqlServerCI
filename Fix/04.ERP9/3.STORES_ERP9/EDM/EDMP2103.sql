IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2103]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2103]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- In phiếu thời khóa biểu năm học
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 27/03/2019
-- <Example>
---- 
/*-- <Example>
	EDMP2103 @DivisionID = 'BE', @UserID = 'ASOFTADMIN',@XML = '<Data><APK>C17B1754-A3F8-4E94-8C1B-B4F2BF70C441</APK></Data>'
	EDMP2103 @DivisionID = 'BE', @UserID = 'ASOFTADMIN',
	@XML = '<Data><APK>0785C812-2E65-4AF4-BFD5-4D0523A267CC</APK></Data>
	<Data><APK>92457D1C-5F88-4342-919E-78590FAB4320</APK></Data>'

----*/
CREATE PROCEDURE EDMP2103
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50), 
	 @XML XML
)
AS 

DECLARE @sSQL NVARCHAR(MAX)

CREATE TABLE #EDMP2103(APK VARCHAR(50))
INSERT INTO #EDMP2103 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)


BEGIN 

SET @sSQL = '
SELECT T1.APK, T1.DivisionID,T4.DivisionName, T1.GradeID, T3.GradeName,T2.FromHour, T2.ToHour, 
T2.Monday, T2.Tuesday, T2.Wednesday, T2.Thursday, T2.Friday, T2.Saturday, 
T1.TermID + '' ('' + CONVERT(VARCHAR(10), T6.DateFrom, 103) + '' - '' + CONVERT(VARCHAR(10), T6.DateTo, 103) + '')'' AS SchoolYearID
FROM EDMT2100 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2101 T2 WITH (NOLOCK) ON T2.APKMaster = T1.APK  
LEFT JOIN EDMT1000 T3 WITH (NOLOCK) ON T3.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND T1.GradeID = T3.GradeID
LEFT JOIN AT1101   T4 WITH (NOLOCK) ON T4.DivisionID = T1.DivisionID 
INNER JOIN #EDMP2103 T5 WITH (NOLOCK) ON T5.APK = T1.APK 
LEFT JOIN EDMT1040 T6 WITH (NOLOCK) ON T6.SchoolYearID = T1.TermID
WHERE T1.DivisionID = '''+@DivisionID+''' AND T2.DeleteFlg = 0 
ORDER BY T2.FromHour ASC
'


END 


--PRINT  (@sSQL) 
EXEC  (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
