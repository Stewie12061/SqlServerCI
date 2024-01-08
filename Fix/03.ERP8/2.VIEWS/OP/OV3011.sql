IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OV3011]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[OV3011]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----NGUYEN THI THUY TUYEN
-----VIEW chet lay du lieu don vi tinh chuyen doi cho don hang mua.
------17/11/2006
-- Last edit : Thuy Tuyen , dat 19/03/2009 sua cach lay OperatorName
--- Edited by Bao Anh	Date: 31/07/2012
--- Purpose: Lay them truong FormulaID, FormulaDes, DataType, DataTypeName
--- Modified on 16/05/2017 by Hải Long: Chỉnh sửa danh mục dùng chung
--- Modified on 01/09/2017 by Phương Thảo: bổ sung các trường quy cách
---- Modified on 14/01/2019 by Kim Thư: Bổ sung WITH (NOLOCK) 
CREATE VIEW [dbo].[OV3011]
AS 
SELECT 
AT1309.DivisionID,
AT1309.InventoryID,
AT1309.UnitID,
AT1304.UnitName,
AT1309.ConversionFactor,
AT1309.Operator,
CASE WHEN AT1309.DataType = 0 AND AT1309.Operator = 0 THEN N'WQ1309.MultiplyStr' 
     WHEN AT1309.DataType = 0 AND AT1309.Operator = 1 THEN N'WQ1309.Divide' 
     ELSE '' END AS OperatorName,
AT1309.FormulaID, AT1319.FormulaDes, AT1309.DataType,
CASE WHEN AT1309.DataType = 0 THEN 'WQ1309.Operators' 
     WHEN AT1309.DataType = 1 THEN 'WQ1309.Formula'
     ELSE '' END AS DataTypeName,
Isnull(AT1309.S01ID,'') AS S01ID, Isnull(AT1309.S02ID,'') AS S02ID, Isnull(AT1309.S03ID,'') AS S03ID, Isnull(AT1309.S04ID,'') AS S04ID, Isnull(AT1309.S05ID,'') AS S05ID, 
Isnull(AT1309.S06ID,'') AS S06ID, Isnull(AT1309.S07ID,'') AS S07ID, Isnull(AT1309.S08ID,'') AS S08ID, Isnull(AT1309.S09ID,'') AS S09ID, Isnull(AT1309.S10ID,'') AS S10ID,
Isnull(AT1309.S11ID,'') AS S11ID, Isnull(AT1309.S12ID,'') AS S12ID, Isnull(AT1309.S13ID,'') AS S13ID, Isnull(AT1309.S14ID,'') AS S14ID, Isnull(AT1309.S15ID,'') AS S15ID, 
Isnull(AT1309.S16ID,'') AS S16ID, Isnull(AT1309.S17ID,'') AS S17ID, Isnull(AT1309.S18ID,'') AS S18ID, Isnull(AT1309.S19ID,'') AS S19ID, Isnull(AT1309.S20ID,'') AS S20ID     

FROM AT1309  WITH (NOLOCK) 
INNER JOIN AT1304  WITH (NOLOCK) on AT1304.UnitID = AT1309.UnitID
LEFT JOIN AT1319  WITH (NOLOCK) on AT1309.FormulaID = AT1319.FormulaID

WHERE AT1309.Disabled = 0 

UNION ALL

SELECT 
AT1302.DivisionID,
AT1302.InventoryID,
AT1302.UnitID,
AT1304.UnitName,
CAST(1 AS DECIMAL(28, 8)) AS ConversionFactor,
CAST(0 AS TINYINT) AS Operator, 
N'WQ1309.MultiplyStr' AS OperatorName,
CAST(null AS NVARCHAR(250)) AS FormulaID, 
CAST(null AS NVARCHAR(250)) AS FormulaDes, 
CAST(0 AS TINYINT) AS DataType, 
'WQ1309.Operators' AS DataTypeName,
'' as S01ID, '' as S02ID, '' as S03ID, '' as S04ID, '' as S05ID, '' as S06ID, '' as S07ID, '' as S08ID, '' as S09ID, '' as S10ID,
'' as S11ID, '' as S12ID, '' as S13ID, '' as S14ID, '' as S15ID, '' as S16ID, '' as S17ID, '' as S18ID, '' as S19ID, '' as S20ID
FROM AT1302  WITH (NOLOCK) 
INNER JOIN AT1304  WITH (NOLOCK) on AT1304.UnitID = AT1302.UnitID

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


