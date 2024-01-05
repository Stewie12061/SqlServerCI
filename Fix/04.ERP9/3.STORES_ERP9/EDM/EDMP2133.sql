IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP2133]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP2133]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- In phiếu đăng ký xe bus đưa đón/ phiếu tham dự chương trình 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 26/03/2019
-- <Example>
---- 
/*-- <Example>
	EDMP2133 @DivisionID = 'BE', @UserID = 'ASOFTADMIN',@XML = '<Data><APK>2ADD7E6A-118F-466B-9CCA-A428CDEE12FE</APK></Data>',@Mode = 0,@StudentID = ''
	EDMP2133 @DivisionID = 'BE', @UserID = 'ASOFTADMIN',
	@XML = '<Data><APK>2ADD7E6A-118F-466B-9CCA-A428CDEE12FE</APK></Data>'
	,@Mode = 1,@StudentID=N'HS/2019/02/0021'',''HS/2019/02/0032'
----*/
CREATE PROCEDURE EDMP2133
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50), 
	 @XML XML,
	 @Mode VARCHAR(50), ---0: in hàng loạt học sinh (EDMF2130), 1: in 1 học sinh (EDMF2132 ) 
	 @StudentID VARCHAR(MAX) 
)
AS 

DECLARE @sSQL NVARCHAR(MAX)

CREATE TABLE #EDMP2133(APK VARCHAR(50))
INSERT INTO #EDMP2133 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)

IF @Mode = 0 
BEGIN 

SELECT T1.APK,T9.DivisionName,T9.[Address], T2.StudentID, T3.StudentName, T2.ClassID, T4.ClassName,T3.DateOfBirth, T3.SexID, T5.[Description] AS SexName,
CASE WHEN ISNULL(T3.FatherID,'') != '' THEN T6.ObjectName ELSE T7.ObjectName  END AS ParentName,
CASE WHEN ISNULL(T3.FatherPhone,'') != '' THEN T3.FatherPhone ELSE T3.MotherPhone END AS Phone,
CASE WHEN ISNULL(T3.FatherMobiphone,'') != '' THEN T3.FatherMobiphone ELSE T3.MotherMobiphone END AS Mobiphone,
CASE WHEN ISNULL(T3.FatherEmail,'') != '' THEN T3.FatherEmail ELSE T3.MotherEmail END AS Email,
T2.PickupPlace,T2.ArrivedPlace,
T1.ExtracurricularActivity,T1.DateSchedule, T1.Place, T1.[Description],T1.Cost,NULL AS StartDate , NULL AS EndDate,T1.ServiceTypeID,
Stuff(isnull((	Select  ', ' + X.ClassName From  
												(	Select DISTINCT EDMT2133.APKMaster, EDMT2133.DivisionID, EDMT2133.ClassID, T10.ClassName
													From EDMT2133 WITH (NOLOCK)
													LEFT JOIN EDMT1020 T10 WITH (NOLOCK) ON T10.ClassID = EDMT2133.ClassID
												) X
								Where X.APKMaster = Convert(varchar(50),T1.APK) and X.DivisionID= T1.DivisionID
								FOR XML PATH (''), TYPE).value('.','NVARCHAR(max)'), ''), 1, 1, '') AS ClassName1

FROM EDMT2130 T1 WITH (NOLOCK)
LEFT JOIN EDMT2131 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T2.APKMaster = T1.APK 
LEFT JOIN EDMT2010 T3 WITH (NOLOCK) ON T3.DivisionID = T1.DivisionID AND T3.StudentID = T2.StudentID 
LEFT JOIN EDMT1020 T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID,'@@@') AND T4.ClassID = T2.ClassID 
LEFT JOIN EDMT0099 T5 WITH (NOLOCK) ON T5.ID = T3.SexID AND T5.CodeMaster = 'Sex'
LEFT JOIN AT1202   T6 WITH (NOLOCK) ON T6.DivisionID IN (T1.DivisionID,'@@@') AND T6.ObjectID = T3.FatherID
LEFT JOIN AT1202   T7 WITH (NOLOCK) ON T7.DivisionID IN (T1.DivisionID,'@@@') AND T7.ObjectID = T3.MotherID
INNER JOIN #EDMP2133 T8 WITH (NOLOCK) ON T8.APK = T1.APK 
LEFT JOIN AT1101 T9 WITH (NOLOCK) ON  T9.DivisionID = T1.DivisionID 
WHERE T1.DivisionID = @DivisionID  AND T2.DeleteFlg = 0




END 

ELSE IF @Mode = 1
BEGIN 

SET  @sSQL = '
SELECT T1.APK, T9.DivisionName,T9.[Address], T2.StudentID, T3.StudentName, T2.ClassID, T4.ClassName,T3.DateOfBirth, T3.SexID, T5.[Description] AS SexName,
CASE WHEN ISNULL(T3.FatherID,'''') != '''' THEN T6.ObjectName ELSE T7.ObjectName  END AS ParentName,
CASE WHEN ISNULL(T3.FatherPhone,'''') != '''' THEN T3.FatherPhone ELSE T3.MotherPhone END AS Phone,
CASE WHEN ISNULL(T3.FatherMobiphone,'''') != '''' THEN T3.FatherMobiphone ELSE T3.MotherMobiphone END AS Mobiphone,
CASE WHEN ISNULL(T3.FatherEmail,'''') != '''' THEN T3.FatherEmail ELSE T3.MotherEmail END AS Email,
T2.PickupPlace,T2.ArrivedPlace,
T1.ExtracurricularActivity,T1.DateSchedule, T1.Place, T1.[Description],T1.Cost,NULL AS StartDate , NULL AS EndDate,T1.ServiceTypeID,
Stuff(isnull((	Select  '', '' + X.ClassName From  
												(	Select DISTINCT EDMT2133.APKMaster, EDMT2133.DivisionID, EDMT2133.ClassID, T10.ClassName
													From EDMT2133 WITH (NOLOCK)
													LEFT JOIN EDMT1020 T10 WITH (NOLOCK) ON T10.ClassID = EDMT2133.ClassID
												) X
								Where X.APKMaster = Convert(varchar(50),T1.APK) and X.DivisionID= T1.DivisionID
								FOR XML PATH (''''), TYPE).value(''.'',''NVARCHAR(max)''), ''''), 1, 1, '''') AS ClassName1

FROM EDMT2130 T1 WITH (NOLOCK)
LEFT JOIN EDMT2131 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T2.APKMaster = T1.APK  
LEFT JOIN EDMT2010 T3 WITH (NOLOCK) ON T3.DivisionID = T1.DivisionID AND T3.StudentID = T2.StudentID 
LEFT JOIN EDMT1020 T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID,''@@@'') AND T4.ClassID = T2.ClassID 
LEFT JOIN EDMT0099 T5 WITH (NOLOCK) ON T5.ID = T3.SexID AND T5.CodeMaster = ''Sex''
LEFT JOIN AT1202   T6 WITH (NOLOCK) ON T6.DivisionID IN (T1.DivisionID,''@@@'') AND T6.ObjectID = T3.FatherID
LEFT JOIN AT1202   T7 WITH (NOLOCK) ON T7.DivisionID IN (T1.DivisionID,''@@@'') AND T7.ObjectID = T3.MotherID
INNER JOIN #EDMP2133 T8 WITH (NOLOCK) ON T8.APK = T1.APK 
LEFT JOIN AT1101 T9 WITH (NOLOCK) ON T9.DivisionID = T1.DivisionID 
WHERE T1.DivisionID = '''+@DivisionID+''' AND T2.StudentID IN ('''+@StudentID+''') AND T2.DeleteFlg = 0
'

END 

--PRINT  (@sSQL) 
EXEC  (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
