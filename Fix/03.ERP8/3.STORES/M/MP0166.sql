IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0166]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0166]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load edit phiếu thống kê sản xuất - Angel
-- <History>
---- Created by Tiểu Mai on 02/26/2016
---- Modified on 13/10/2020 by Nhựt Trường: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

-- <Example>
/*
 EXEC MP0166 'KE', ''
 */
 

CREATE PROCEDURE [dbo].[MP0166] 	
	@DivisionID NVARCHAR(50),
	@VoucherID NVARCHAR(50)
AS
DECLARE @sSQL NVARCHAR(MAX), @sSQL1 NVARCHAR(MAX)
SET @sSQL = ''
SET @sSQL1 = ''

SET @sSQL = N'
	SELECT MT1801.DivisionID, MT1802.VoucherID, MT1801.VoucherTypeID, MT1801.VoucherDate, MT1801.ProductDate, AT1202.ObjectName, MT1801.VoucherNo, MT1801.TranMonth, MT1801.TranYear,
	MT1801.ObjectID, MT1801.TeamID, MT1802.CombineID, MT1802.TableID, MT1801.MTC01, MT1801.MTC02, MT1801.VisorsID, MT1801.EmployeeID, MT1801.[Description],
	AT1103.FullName AS EmployeeName, HV1400.FullName AS VisorsName, AT0165.TableName, AT0156.CombineName, HT1101.TeamName,
	MT1801.QuantityControl, MT1801.ReImportQuantity, MT1801.QuantityChoose, MT1801.RateChoose, MT1801.QuantityQualify, MT1801.RateQualify,
	MT1801.QuantityNotQualify,MT1801.RateNotQualify,
	MT1801.Parameter01, MT1801.Parameter02, MT1801.Parameter03, MT1801.Parameter04, MT1801.Parameter05, 
	MT1801.Parameter06, MT1801.Parameter07, MT1801.Parameter08, MT1801.Parameter09, MT1801.Parameter10, 
	MT1801.Parameter11, MT1801.Parameter12, MT1801.Parameter13, MT1801.Parameter14, MT1801.Parameter15, 
	MT1801.Parameter16, MT1801.Parameter17, MT1801.Parameter18, MT1801.Parameter19, MT1801.Parameter20,
	MT1802.S01ID, MT1802.S02ID, MT1802.S03ID, MT1802.S04ID, MT1802.S05ID, MT1802.S06ID, MT1802.S07ID, MT1802.S08ID, MT1802.S09ID, MT1802.S10ID,
	MT1802.S11ID, MT1802.S12ID, MT1802.S13ID, MT1802.S14ID, MT1802.S15ID, MT1802.S16ID, MT1802.S17ID, MT1802.S18ID, MT1802.S19ID, MT1802.S20ID,	
	MT1802.TransactionID, MT1802.InventoryID, A01.InventoryName, MT1802.UnitID, MT1802.ProductID, A02.InventoryName AS ProductName, MT1802.ProductUnitID,
	AT1309.Operator, AT1309.DataType, AT1309.ConversionFactor, AT1319.FormulaDes, 
	MT1802.LateQuantity, MT1802.RecieveQuantity, MT1802.UseQuantity, MT1802.RemainQuantity, MT1802.[Shift],
	MT1802.BeginTime, MT1802.EndTime, MT1802.ActualTime, MT1802.LimitDate, MT1802.ActualQuantity, MT1802.ConvertedActualQuantity, MT1802.IsImport, MT1802.WarehouseID, MT1802.TypeTab, MT1802.ErrorQuantity, 
	MT1802.ErrorTypeID, MT1802.RecycleQuantity, MT1802.FixQuantity, MT1802.CancelQuantity, MT1802.StopCausal, MT1802.Orders,
	MT1802.Parameter01 AS DParameter01, MT1802.Parameter02 AS DParameter02, MT1802.Parameter03 AS DParameter03, MT1802.Parameter04 AS DParameter04, MT1802.Parameter05 AS DParameter05,
	MT1802.Parameter06 AS DParameter06, MT1802.Parameter07 AS DParameter07, MT1802.Parameter08 AS DParameter08, MT1802.Parameter09 AS DParameter09, MT1802.Parameter10 AS DParameter10,
	MT1802.Parameter11 AS DParameter11, MT1802.Parameter12 AS DParameter12, MT1802.Parameter13 AS DParameter13, MT1802.Parameter14 AS DParameter14, MT1802.Parameter15 AS DParameter15,
	MT1802.Parameter16 AS DParameter16, MT1802.Parameter17 AS DParameter17, MT1802.Parameter18 AS DParameter18, MT1802.Parameter19 AS DParameter19, MT1802.Parameter20 AS DParameter20,
	MT1802.Ana01ID, MT1802.Ana02ID, MT1802.Ana03ID, MT1802.Ana04ID, MT1802.Ana05ID, MT1802.Ana06ID, MT1802.Ana07ID, MT1802.Ana08ID, MT1802.Ana09ID, MT1802.Ana10ID,
	MT1802.ReVoucherID, MT1802.ReTransactionID, MT1802.InheritVoucherID, MT1802.InheritTransactionID, MT1802.InheritTableID
	'

SET @sSQL1 = '	
	FROM MT1802
	INNER JOIN MT1801 ON MT1801.DivisionID = MT1802.DivisionID AND MT1801.VoucherID = MT1802.VoucherID
	LEFT JOIN AT1309 WITH (NOLOCK) ON AT1309.InventoryID = MT1802.ProductID AND AT1309.UnitID = MT1802.ProductUnitID
	AND ISNULL(AT1309.S01ID, '''') = ISNULL(MT1802.S01ID, '''')
	AND ISNULL(AT1309.S02ID, '''') = ISNULL(MT1802.S02ID, '''')
	AND ISNULL(AT1309.S03ID, '''') = ISNULL(MT1802.S03ID, '''')
	AND ISNULL(AT1309.S04ID, '''') = ISNULL(MT1802.S04ID, '''')
	AND ISNULL(AT1309.S05ID, '''') = ISNULL(MT1802.S05ID, '''')
	AND ISNULL(AT1309.S06ID, '''') = ISNULL(MT1802.S06ID, '''')
	AND ISNULL(AT1309.S07ID, '''') = ISNULL(MT1802.S07ID, '''')
	AND ISNULL(AT1309.S08ID, '''') = ISNULL(MT1802.S08ID, '''')
	AND ISNULL(AT1309.S09ID, '''') = ISNULL(MT1802.S09ID, '''')
	AND ISNULL(AT1309.S10ID, '''') = ISNULL(MT1802.S10ID, '''')
	AND ISNULL(AT1309.S11ID, '''') = ISNULL(MT1802.S11ID, '''')
	AND ISNULL(AT1309.S12ID, '''') = ISNULL(MT1802.S12ID, '''')
	AND ISNULL(AT1309.S13ID, '''') = ISNULL(MT1802.S13ID, '''')
	AND ISNULL(AT1309.S14ID, '''') = ISNULL(MT1802.S14ID, '''')
	AND ISNULL(AT1309.S15ID, '''') = ISNULL(MT1802.S15ID, '''')
	AND ISNULL(AT1309.S16ID, '''') = ISNULL(MT1802.S16ID, '''')
	AND ISNULL(AT1309.S17ID, '''') = ISNULL(MT1802.S17ID, '''')
	AND ISNULL(AT1309.S18ID, '''') = ISNULL(MT1802.S18ID, '''')
	AND ISNULL(AT1309.S19ID, '''') = ISNULL(MT1802.S19ID, '''')
	AND ISNULL(AT1309.S20ID, '''') = ISNULL(MT1802.S20ID, '''')	
	LEFT JOIN AT1319 WITH (NOLOCK) ON AT1309.FormulaID = AT1319.FormulaID
	LEFT JOIN AT0156 ON AT0156.DivisionID = MT1802.DivisionID AND AT0156.CombineID = MT1802.CombineID
	LEFT JOIN HT1101 ON HT1101.DivisionID = AT0156.DivisionID AND HT1101.TeamID = MT1801.TeamID
	LEFT JOIN AT0165 ON AT0165.DivisionID = MT1802.DivisionID AND AT0165.TableID = MT1802.TableID
	LEFT JOIN AT1202 ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = MT1801.ObjectID
	LEFT JOIN AT1103 ON AT1103.EmployeeID = MT1801.EmployeeID
	LEFT JOIN HV1400 ON HV1400.DivisionID = MT1801.DivisionID AND HV1400.EmployeeID = MT1801.VisorsID
	LEFT JOIN AT1302 A01 ON A01.InventoryID = MT1802.InventoryID AND A01.DivisionID IN (MT1802.DivisionID,''@@@'')
	LEFT JOIN AT1302 A02 ON A02.InventoryID = MT1802.ProductID AND A02.DivisionID IN (MT1802.DivisionID,''@@@'')
	LEFT JOIN AT1303 ON AT1303.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND AT1303.WarehouseID = MT1802.WarehouseID
	WHERE MT1801.DivisionID = '''+@DivisionID+'''
	AND MT1802.VoucherID = '''+ @VoucherID +'''
	ORDER BY MT1802.Orders '

PRINT @sSQL
PRINT @sSQL1	
EXEC (@sSQL+@sSQL1)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

