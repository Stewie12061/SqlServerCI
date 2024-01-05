IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[EDMP1051]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[EDMP1051]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Xuất Excel danh mục loại hình thu 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hồng Thảo, Date: 23/08/2018
-- <Example>
---- 
/*-- <Example>
	EDMP1051 @DivisionID = 'BE', @UserID = '', @XML = '<Data><APK>24ADD193-C861-4A29-8097-49562A189DFC</APK></Data>',@LanguageID = 'vi-VN'
	
	EDMP1051 @DivisionID, @UserID, @XML,@LanguageID
----*/

CREATE PROCEDURE EDMP1051
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @XML XML,
	 @LanguageID VARCHAR(50)
)


AS 
DECLARE @sSQL NVARCHAR (MAX) = N''


CREATE TABLE #EDMP1051 (APK VARCHAR(50))
INSERT INTO #EDMP1051 (APK)
SELECT X.Data.query('APK').value('.', 'NVARCHAR(50)') AS APK
FROM @XML.nodes('//Data') AS X (Data)	

SET @sSQL = @sSQL + N'
SELECT EDMT1050.DivisionID, EDMT1050.ReceiptTypeID, EDMT1050.ReceiptTypeName,EDMT1050.AnaRevenueID,T03.AnaName AS AnaRevenueName, EDMT1050.AccountID,
'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T01.Description' ELSE 'T01.DescriptionE' END+' AS IsCommon, 
'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T02.Description' ELSE 'T02.DescriptionE' END+' AS [Disabled]
FROM EDMT1050 WITH (NOLOCK)
INNER JOIN #EDMP1051 ON EDMT1050.APK = #EDMP1051.APK
LEFT JOIN EDMT0099 T01 WITH (NOLOCK) ON EDMT1050.IsCommon = T01.ID AND T01.CodeMaster = ''Disabled''
LEFT JOIN EDMT0099 T02 WITH (NOLOCK) ON EDMT1050.[Disabled] = T02.ID AND T02.CodeMaster = ''Disabled''
LEFT JOIN AT1011   T03 WITH (NOLOCK) ON T03.DivisionID IN ('''+@DivisionID+''',''@@@'') AND T03.AnaID = EDMT1050.AnaRevenueID AND T03.AnaTypeID =  (SELECT SalesAnaTypeID FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = '''+@DivisionID+''')
ORDER BY EDMT1050.ReceiptTypeID'

--PRINT(@sSQL)
EXEC (@sSQL)


   
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
