IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP14502]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP14502]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid CIFT14501 - Bút toán màn hình cập nhật Mã phân tích - CIF14501
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Hoài Bảo, Date: 26/10/2022
----Modified by: Hoài Bảo, Date: 24/02/2023 - Cập nhật order theo TypeID
----Modified by: Hoài Bảo, Date: 07/03/2023/2023 - Fix lỗi gán cứng DivisionID
-- <Example>
----    EXEC CIP14502 '1B'

CREATE PROCEDURE CIP14502 (
        @DivisionID VARCHAR(50)
) 
AS 
SELECT AT0005.*, AT0099.[Description] AS DefaultBusinessName, [Status] AS AllowLevel,
	   CASE WHEN TypeID = 'A01' THEN (SELECT ProjectAnaTypeID FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID IN (@DivisionID, '@@@'))
			WHEN TypeID = 'A02' THEN (SELECT ContractAnaTypeID FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID IN (@DivisionID, '@@@'))
			WHEN TypeID = 'A04' THEN (SELECT DepartmentAnaTypeID FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID IN (@DivisionID, '@@@'))
			WHEN TypeID = 'A05' THEN (SELECT TeamAnaTypeID FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID IN (@DivisionID, '@@@'))
			WHEN TypeID = 'A06' THEN (SELECT SalesAnaTypeID FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID IN (@DivisionID, '@@@'))
			WHEN TypeID = 'A07' THEN (SELECT CostAnaTypeID FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID IN (@DivisionID, '@@@'))
			ELSE NULL
	   END AS ColTypeID,
	   CASE WHEN TypeID = 'A02' THEN (SELECT SalesContractAnaTypeID FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID IN (@DivisionID, '@@@'))
			ELSE NULL
	   END AS ColTypeID1
INTO #AT0005Temp
FROM AT0005 WITH (NOLOCK)
LEFT JOIN AT0099 WITH (NOLOCK) ON AT0005.DefaultBusinessID = AT0099.ID AND AT0099.CodeMaster = 'MPTBusiness'
WHERE DivisionID IN (@DivisionID, '@@@')
AND TypeID LIKE 'A%'
ORDER BY TypeID

DECLARE @sSQL NVARCHAR(MAX) = ''
SELECT @sSQL = @sSQL + 'SELECT '''+ col.[name] +''' AS ColID,
						(SELECT '+ col.[name] +' FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID IN (''' +@DivisionID+ ''', ''@@@'')) AS AnaTypeID
						UNION '
FROM syscolumns col
INNER JOIN sysobjects tab ON col.id = tab.id
WHERE tab.[name] = 'AT0000' AND col.[name] IN (SELECT ID FROM AT0099 WITH (NOLOCK) WHERE CodeMaster = N'MPTBusiness')
SET @sSQL = 'SELECT * INTO #AT0000Temp FROM (' + SUBSTRING(@sSQL, 1, LEN(@sSQL) - 5) + ') AS AT0000
			 SELECT A05.*, A00.ColID AS BusinessTypeID, A99.[Description] AS BusinessTypeName,
					CASE WHEN A05.ColTypeID1 = ''A02'' THEN ''SalesContractAnaTypeID''
					ELSE NULL END AS BusinessTypeID1
			 FROM #AT0005Temp A05
			 LEFT JOIN #AT0000Temp A00 ON A05.TypeID = A00.AnaTypeID
			 LEFT JOIN AT0099 A99 WITH (NOLOCK) ON A99.ID = A00.ColID'

--PRINT (@sSQL)
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO