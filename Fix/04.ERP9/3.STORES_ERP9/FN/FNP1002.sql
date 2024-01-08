IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[FNP1002]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[FNP1002]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Xuất Excel danh mục định mức chi phí  
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 17/08/2018
---- Modified by Như Hàn on 18/01/2019: Sửa lấy thông tin số tiền từ - đến
-- <Example>
---- 
/*-- <Example>
	FNP1002 @DivisionID = 'VF', @UserID = 'ASOFTADMIN', @XML = '431AFE34-9E6E-45B6-9C8E-241532857FBE'
	
	FNP1002 @DivisionID, @UserID, @XML
----*/

CREATE PROCEDURE FNP1002
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @XML XML
)
AS 
DECLARE @sSQL NVARCHAR (MAX) = N'',
		@LanguageID VARCHAR(50)

SELECT TOP 1 @LanguageID = ISNULL(LanguageID,'') FROM AT14051 WITH (NOLOCK) WHERE UserID = @UserID
        
CREATE TABLE #FNP1002 (APK VARCHAR(50))
INSERT INTO #FNP1002 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)	

SET @sSQL = @sSQL + N'
SELECT F00.DivisionID, F00.NormID, F00.Description, F00.AreaID, 
'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T01.Description' ELSE 'T01.DescriptionE' END+' AS [AreaName],
'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T02.Description' ELSE 'T02.DescriptionE' END+' AS [IsCommon], 
'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T03.Description' ELSE 'T03.DescriptionE' END+' AS [Disabled],
F01.FromAmount,F01.ToAmount
FROM FNT1000 F00 WITH (NOLOCK)
INNER JOIN FNT1001 F01 WITH (NOLOCK) ON F00.APK = F01.APKMaster
INNER JOIN #FNP1002 ON F00.APK = #FNP1002.APK
LEFT JOIN CIT0099 T01 WITH (NOLOCK) ON F00.AreaID = T01.ID AND T01.CodeMaster = ''CI000004''
LEFT JOIN CIT0099 T02 WITH (NOLOCK) ON F00.IsCommon = T02.ID AND T02.CodeMaster = ''CI000001''
LEFT JOIN CIT0099 T03 WITH (NOLOCK) ON F00.[Disabled] = T03.ID AND T03.CodeMaster = ''CI000001''
ORDER BY F00.NormID'

EXEC (@sSQL)
--PRINT(@sSQL)

   


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
