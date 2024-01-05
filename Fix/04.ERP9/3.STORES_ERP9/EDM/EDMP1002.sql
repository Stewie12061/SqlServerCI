IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[EDMP1002]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[EDMP1002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Xuất Excel danh mục khối
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Minh Hòa , Date: 06/09/2018
---- Modified by on 
-- <Example>
---- 
/*-- <Example>
	EDMP1002 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @XML = '431AFE34-9E6E-45B6-9C8E-241532857FBE', @LanguageID ='vi-VN'
	
	----*/

CREATE PROCEDURE EDMP1002
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @XML XML,
	 @LanguageID VARCHAR(50)
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N''
--		@LanguageID VARCHAR(50)

--SELECT TOP 1 @LanguageID = ISNULL(LanguageID,'') FROM AT14051 WITH (NOLOCK) WHERE UserID = @UserID
        
CREATE TABLE #EDMP1002 (APK VARCHAR(50))
INSERT INTO #EDMP1002 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)	

SET @sSQL = @sSQL + N'
SELECT EDMT1000.DivisionID, EDMT1000.GradeID, EDMT1000.GradeName, EDMT1000.Notes, 
'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T03.Description' ELSE 'T03.DescriptionE' END+' AS LevelName, 
'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T01.Description' ELSE 'T01.DescriptionE' END+' AS IsCommon, 
'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T02.Description' ELSE 'T02.DescriptionE' END+' AS [Disabled]
FROM EDMT1000 WITH (NOLOCK)
INNER JOIN #EDMP1002 ON EDMT1000.APK = #EDMP1002.APK
LEFT JOIN EDMT0099 T01 WITH (NOLOCK) ON EDMT1000.IsCommon = T01.ID AND T01.CodeMaster = ''Disabled''
LEFT JOIN EDMT0099 T02 WITH (NOLOCK) ON EDMT1000.[Disabled] = T02.ID AND T02.CodeMaster = ''Disabled''
LEFT JOIN EDMT0099 T03 WITH (NOLOCK) ON EDMT1000.LevelID = T03.ID AND T03.CodeMaster = ''Level''
ORDER BY EDMT1000.GradeID'

EXEC (@sSQL)
--PRINT(@sSQL)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

