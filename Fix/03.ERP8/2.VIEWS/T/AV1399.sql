IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV1399]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV1399]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Nguyen Van Nhan. Date 04/10/2005
---- Purpose: Chi tiet danh muc don vi tinh chuyen doi. View Chet
-- Edit Thuy Tuyen, them thong tin DataType, Formular , date: 17/03/2009

-- Created by Nguyen Van Nhan. Date 04/10/2005
-- Purpose: Chi tiet danh muc don vi tinh chuyen doi. View Chet
-- Edit Thuy Tuyen, them thong tin DataType, Formular , date: 17/03/2009*/
--- Modify on 24/05/2016 by Bảo Anh: Bổ sung With (Nolock)
--- Modified by Tiểu Mai on 13/07/2016: Bổ sung thông tin 20 cột quy cách
--- Modified on 16/05/2017 by Hải Long: Chỉnh sửa danh mục dùng chung
--- Modify on 02/10/2020 by Nhựt Trường: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
--- Modify on 02/02/2021 by Nhựt Trường: Chỉnh sửa danh mục dùng chung, bổ sung điều kiện Where theo DivisionID IN cho các KH có sử dụng nhiều DivisionID.
--- Modify on 27/11/2023 by Đức Tuyên: Update - bổ sung thêm APK load detail cho đơn vị quy đổi tương ứng.
CREATE VIEW [dbo].[AV1399]
AS
SELECT     dbo.AT1309.DivisionID, dbo.AT1309.InventoryID, dbo.AT1302.InventoryName, dbo.AT1302.UnitID, C.UnitName, dbo.AT1309.UnitID AS ConvertUnitID, 
                      C.UnitName AS ConvertUnitName, dbo.AT1309.Orders, 
                      CASE WHEN AT1309.Operator = 0 THEN ' 01 ' + C.UnitName + ' = ' + ltrim(rtrim(str(ConversionFactor))) 
                      + ' ' + B.UnitName ELSE '01 ' + B.UnitName + ' = ' + ltrim(rtrim(str(ConversionFactor))) + ' ' + C.UnitName END AS Example, dbo.AT1309.Disabled, 
                      dbo.AT1309.ConversionFactor, dbo.AT1309.Operator, CASE WHEN AT1309.DataType = 0 AND 
                      Operator = 0 THEN '0' ELSE CASE WHEN AT1309.DataType = 0 AND Operator = 1 THEN '1' ELSE '' END END AS OperatorName, 0 AS locked, 
                      CASE WHEN DataType = 0 THEN '0' ELSE '1' END AS DataType, dbo.AT1309.FormulaID, dbo.AT1319.FormulaName, dbo.AT1319.FormulaDes
                      ,AT1309.IsCommon,
                      AT1309.S01ID, AT1309.S02ID, AT1309.S03ID, AT1309.S04ID, AT1309.S05ID, AT1309.S06ID, AT1309.S07ID, AT1309.S08ID, AT1309.S09ID, AT1309.S10ID,
                      AT1309.S11ID, AT1309.S12ID, AT1309.S13ID, AT1309.S14ID, AT1309.S15ID, AT1309.S16ID, AT1309.S17ID, AT1309.S18ID, AT1309.S19ID, AT1309.S20ID
                      , dbo.AT1309.APK
FROM         dbo.AT1309 WITH (NOLOCK) INNER JOIN
                      dbo.AT1302 WITH (NOLOCK) ON AT1302.InventoryID = AT1309.InventoryID
                      INNER JOIN dbo.AT1304 AS B WITH (NOLOCK) ON B.UnitID = dbo.AT1302.UnitID
                      INNER JOIN dbo.AT1304 AS C WITH (NOLOCK) ON C.UnitID = dbo.AT1309.UnitID
                      LEFT OUTER JOIN AT1319 WITH (NOLOCK) ON AT1319.FormulaID = AT1309.FormulaID
WHERE		dbo.AT1309.DivisionID IN (dbo.AT1309.DivisionID,'@@@')

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
