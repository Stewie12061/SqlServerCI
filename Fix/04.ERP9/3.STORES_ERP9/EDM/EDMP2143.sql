IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2143]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2143]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- In phiếu chuyển cơ sở 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
---- 
-- <History>
----Created by: Hồng Thảo on 27/03/2019
-- <Example>
----
/*-- <Example>
	exec EDMP2143 @DivisionID = 'BE', @UserID = 'ASOFTADMIN',
	@XML = '<Data><APK>9C5E1270-F7F8-468D-939C-04A204C51DE9</APK></Data>
			<Data><APK>2CBF62DF-DFFB-4DFC-8EBD-10FF065A7EFE</APK></Data>
			<Data><APK>ED0D06D2-386C-47C5-8035-6148ED1CE0D0</APK></Data>
			'

	
----*/
CREATE PROCEDURE EDMP2143
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50), 
	 @XML XML
	 
)

AS 

DECLARE @sSQL NVARCHAR (MAX) = N'',
        @OrderBy NVARCHAR(500) = N''

SET @OrderBy = 'T1.TranferStudentNo'


CREATE TABLE #EDMP2143(APK VARCHAR(50))
INSERT INTO #EDMP2143(APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)

BEGIN 

SET @sSQL  = '
SELECT T1.APK, T1.TranferStudentNo, T1.StudentID, T2.StudentName, T2.DateOfBirth,
T3.DivisionName AS SchoolNameFrom, T4.ClassID AS ClassIDFrom, T5.ClassName AS ClassNameFrom,
T1.SchoolIDTo, T6.DivisionName AS SchoolNameTo, T1.FromEffectiveDate 
FROM EDMT2140 T1 WITH (NOLOCK) 
LEFT JOIN EDMT2010 T2 WITH (NOLOCK) ON T2.DivisionID = T1.DivisionID AND T2.StudentID = T1.StudentID
LEFT JOIN AT1101   T3 WITH (NOLOCK) ON T3.DivisionID = T1.DivisionID 
LEFT JOIN EDMT2020 T4 WITH (NOLOCK) ON T4.DivisionID = T1.DivisionID  AND T4.ArrangeClassID = T1.ArrangeClassIDFrom 
LEFT JOIN EDMT1020 T5 WITH (NOLOCK) ON T5.DivisionID = T1.DivisionID AND T5.ClassID = T4.ClassID 
LEFT JOIN AT1101   T6 WITH (NOLOCK) ON T6.DivisionID = T1.SchoolIDTo
INNER JOIN #EDMP2143 T7 WITH (NOLOCK) ON T7.APK = T1.APK 
'
END 



 --PRINT @sSQL
 EXEC (@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
