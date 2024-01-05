IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1015]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
	DROP PROCEDURE [DBO].[EDMP1015]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xuất Excel danh mục định mức 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Văn Tình on 08/09/2018
---- Modified by on 
-- <Example>
---- 
/*-- <Example>
	EDMP1015 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @LanguageID = 'vi-VN', @XML = '431AFE34-9E6E-45B6-9C8E-241532857FBE'
	
	EDMP1015 @DivisionID, @UserID, @XML
----*/

CREATE PROCEDURE EDMP1015
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @LanguageID VARCHAR(50),
	 @XML XML
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'', @cLan VARCHAR(1)

--SELECT TOP 1 @LanguageID = ISNULL(LanguageID,'') FROM AT14051 WITH (NOLOCK) WHERE UserID = @UserID
SET @LanguageID = ISNULL(@LanguageID, 'vi-VN')
IF @LanguageID = 'vi-VN' 
	SET @cLan = ''
ELSE
	SET @cLan = 'E'

CREATE TABLE #EDMP1015 (APK VARCHAR(50))
INSERT INTO #EDMP1015 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)	

SET @sSQL = @sSQL + N'
SELECT a.DivisionID, a.QuotaID, a.Description
		, T01.Description' + @cLan + ' AS IsCommon
		, T01.Description' + @cLan + ' AS [Disabled]
		, b.LevelID, T04.Description' + @cLan + ' AS LevelName, b.Quantity
	FROM EDMT1010 a WITH(NOLOCK) INNER JOIN #EDMP1015 ON a.APK = #EDMP1015.APK
		INNER JOIN EDMT1011 b WITH(NOLOCK) ON a.APK = b.APKMaster
		LEFT JOIN EDMT0099 T01 WITH (NOLOCK) ON a.IsCommon = T01.ID AND T01.CodeMaster = ''Disabled''
		LEFT JOIN EDMT0099 T02 WITH (NOLOCK) ON a.[Disabled] = T02.ID AND T02.CodeMaster = ''Disabled''
		LEFT JOIN EDMT0099 T04 WITH (NOLOCK) ON b.[LevelID] = T04.ID AND T02.CodeMaster = ''Level''
	ORDER BY a.QuotaID'

EXEC (@sSQL)
--PRINT(@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
