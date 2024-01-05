IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1071]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1071]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xuất Excel danh mục điều tra tâm lý  
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo
---- Modified by on
-- <Example>
---- 
/*-- <Example>
	EDMP1071 @DivisionID = 'VS', @UserID = 'ASOFTADMIN', @XML = 'DC514FA5-A20D-4CD7-8335-83D4B2D7B9AE'
	
	EDMP1071 @DivisionID, @UserID, @XML
----*/

CREATE PROCEDURE EDMP1071 
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @XML XML
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
		@LanguageID VARCHAR(50)

SELECT TOP 1 @LanguageID = ISNULL(LanguageID,'') FROM AT14051 WITH (NOLOCK) WHERE UserID = @UserID
        
CREATE TABLE #EDMP1071 (APK VARCHAR(50))
INSERT INTO #EDMP1071 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)

SET @sSQL = @sSQL + N'
SELECT EDMT1070.APK, EDMT1070.DivisionID, EDMT1070.PsychologizeType,
'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'ED03.Description' ELSE 'ED03.DescriptionE' END+' AS PsychologizeTypeName,
EDMT1070.PsychologizeID, EDMT1070.PsychologizeName,
'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'ED01.Description' ELSE 'ED01.DescriptionE' END+' AS IsCommon, 
'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'ED02.Description' ELSE 'ED02.DescriptionE' END+' AS [Disabled],
EDMT1070.PsychologizeGroup,ED04.PsychologizeName AS PsychologizeGroupName
FROM EDMT1070 WITH (NOLOCK)
INNER JOIN #EDMP1071 ON EDMT1070.APK = #EDMP1071.APK
LEFT JOIN EDMT0099 ED01 WITH (NOLOCK) ON EDMT1070.IsCommon = ED01.ID AND ED01.CodeMaster = ''Disabled''
LEFT JOIN EDMT0099 ED02 WITH (NOLOCK) ON EDMT1070.[Disabled] = ED02.ID AND ED02.CodeMaster = ''Disabled''
LEFT JOIN EDMT0099 ED03 WITH (NOLOCK) ON EDMT1070.[Disabled] = ED03.ID AND ED03.CodeMaster = ''PsychologizeType''
LEFT JOIN EDMT1070 ED04 WITH (NOLOCK) ON ED04.DivisionID IN (EDMT1070.DivisionID,''@@@'') AND EDMT1070.PsychologizeGroup = ED04.PsychologizeID
ORDER BY EDMT1070.Orders'

EXEC (@sSQL)
PRINT(@sSQL)

   

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
