IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SHMP1002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SHMP1002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xuất Excel danh mục nhóm cổ đông
-- <Param>
---- 
-- <Return>

-- <Reference>
---- 
-- <History>
---- Create on 17/09/2018 by Xuân Minh
---- Modified by on 
-- <Example>
---- 
/*-- <Example>
	EXEC SHMP1002 @DivisionID = 'AS', @UserID = 'ASOFTADMIN', @XML = 'B3DD9B7C-B110-4C26-9585-79A39EC28528'
	SHMP1002 @DivisionID, @UserID, @XML
----*/

CREATE PROCEDURE SHMP1002
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @XML XML
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
		@LanguageID VARCHAR(50)    
	SELECT TOP 1 @LanguageID = ISNULL(LanguageID,'') FROM AT14051 WITH (NOLOCK) WHERE UserID = @UserID    

	CREATE TABLE #SHMP1002 (APK VARCHAR(50))

	INSERT INTO #SHMP1002 (APK)
	SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
	FROM @XML.nodes('//Data') AS X (Data)	

	SET @sSQL = N'
		SELECT SHMT1000.DivisionID, SHMT1000.ShareHolderCategoryID, SHMT1000.ShareHolderCategoryName, SHMT1000.Notes,
			'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T01.Description' ELSE 'T01.DescriptionE' END+' AS IsCommon, 
			'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T02.Description' ELSE 'T02.DescriptionE' END+' AS [Disabled]
		FROM SHMT1000 WITH (NOLOCK) INNER JOIN #SHMP1002 ON SHMT1000.APK = #SHMP1002.APK
									LEFT JOIN AT0099 T01 WITH (NOLOCK) ON SHMT1000.IsCommon = T01.ID AND T01.CodeMaster = ''AT00000004''
									LEFT JOIN AT0099 T02 WITH (NOLOCK) ON SHMT1000.[Disabled] = T02.ID AND T02.CodeMaster = ''AT00000004''
		ORDER BY SHMT1000.ShareHolderCategoryID'
	EXEC (@sSQL)
	
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
