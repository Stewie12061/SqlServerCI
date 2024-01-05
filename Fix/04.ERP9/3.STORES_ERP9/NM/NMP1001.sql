IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[NMP1001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].NMP1001
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Xuất Excel danh mục nhóm thực phẩm
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
-- <History>
----Created by:Tra Giang, Date: 23/08/2018
-- <Example>
---- 
/*-- <Example>
	NMP1001  @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @XML = 'ACA2816E-0903-4126-885C-387AB959408E'
	
	NMP1001 @DivisionID, @UserID, @XML
----*/

CREATE PROCEDURE NMP1001
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @XML XML
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
		@LanguageID VARCHAR(50)

SELECT TOP 1 @LanguageID = ISNULL(LanguageID,'') FROM AT14051 WITH (NOLOCK) WHERE UserID = @UserID
        
CREATE TABLE #NMP1001 (APK VARCHAR(50))
INSERT INTO #NMP1001 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)	
		
SET @sSQL = @sSQL + N'
SELECT DivisionID, MaterialsTypeID, MaterialsTypeName, NMT1000.Description,
'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'CST01.Description' ELSE 'CST01.DescriptionE' END+' AS IsCommon, 
'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'CST02.Description' ELSE 'CST02.DescriptionE' END+' AS [Disabled]
FROM NMT1000 WITH (NOLOCK)
INNER JOIN #NMP1001 ON NMT1000.APK = #NMP1001.APK
LEFT JOIN NMT0099 CST01 WITH (NOLOCK) ON NMT1000.IsCommon = CST01.ID AND CST01.CodeMaster = ''Disabled''
LEFT JOIN NMT0099 CST02 WITH (NOLOCK) ON NMT1000.[Disabled] = CST02.ID AND CST02.CodeMaster = ''Disabled''
ORDER BY MaterialsTypeID
'

EXEC (@sSQL)
--PRINT(@sSQL)

   


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
