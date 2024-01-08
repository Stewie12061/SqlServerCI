﻿IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1061]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1061]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xuất Excel danh mục loại hoạt động 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 25/08/2018
-- <Example>
---- 
/*-- <Example>
	EDMP1061 @DivisionID = 'BS', @UserID = 'ASOFTADMIN', @XML = '<Data><APK>630F87DA-4B68-4298-94AF-7114426020CC</APK></Data><Data><APK>33EBEF74-E03A-487B-8B7D-2137A8258525</APK></Data>'
	

	EDMP1061 @DivisionID, @UserID, @XML
----*/

CREATE PROCEDURE EDMP1061
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @XML XML
)


AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
		@LanguageID VARCHAR(50)

SELECT TOP 1 @LanguageID = ISNULL(LanguageID,'') FROM AT14051 WITH (NOLOCK) WHERE UserID = @UserID

CREATE TABLE #EDMP1061 (APK VARCHAR(50))
INSERT INTO #EDMP1061 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)	

SET @sSQL = @sSQL + N'
SELECT EDMT1060.DivisionID, EDMT1060.ActivityTypeID, EDMT1060.ActivityTypeName,
EDMT1061.ActivityID, EDMT1061.ActivityName,
'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'ED01.Description' ELSE 'ED01.DescriptionE' END+' AS IsCommon, 
'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'ED02.Description' ELSE 'ED02.DescriptionE' END+' AS [Disabled]
FROM EDMT1060 WITH (NOLOCK)
INNER JOIN #EDMP1061 ON EDMT1060.APK = #EDMP1061.APK
INNER JOIN EDMT1061 WITH (NOLOCK) ON EDMT1060.APK = EDMT1061.APKMaster 
LEFT JOIN EDMT0099 ED01 WITH (NOLOCK) ON EDMT1060.IsCommon = ED01.ID AND ED01.CodeMaster = ''Disabled''
LEFT JOIN EDMT0099 ED02 WITH (NOLOCK) ON EDMT1060.[Disabled] = ED02.ID AND ED02.CodeMaster = ''Disabled''
ORDER BY EDMT1060.ActivityTypeID'

--PRINT(@sSQL)
EXEC (@sSQL)


   
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
