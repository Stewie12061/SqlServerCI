IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP0182_AP]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP0182_AP]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Tiểu Mai on 06/09/2016: Load edit cho màn hình Kế hoạch sản xuất tháng MF0182 (AN PHÁT), In báo cáo Phụ kiện
---- Modified by Tiểu Mai on 10/10/2016: Bổ sung VoucherTypeID, ObjectID1, ObjectName1
---- Modified by Hải Long on 25/05/2017: Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 13/10/2020: (Sửa danh mục dùng chung) Bổ sung điều kiện DivisionID IN cho AT1302.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.

CREATE PROCEDURE [dbo].[MP0182_AP]
       @DivisionID NVARCHAR(50) ,
       @VoucherID NVARCHAR(50),
       @ObjectID1 NVARCHAR(50),
       @ObjectID2 NVARCHAR(50)
AS

	DECLARE @sSQL AS nvarchar(4000) ,
			@sSQL1 AS nvarchar(4000),
			@sWhere AS NVARCHAR(4000) 

SET @sWhere = ''

IF ISNULL(@ObjectID1,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND MT0182.ObjectID1 LIKE N'''+@ObjectID1+''' '
END

IF ISNULL(@ObjectID2,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND MT0182.ObjectID2 LIKE N'''+@ObjectID2+''' '
END
			
SET @sSQL = '		
SELECT MT0181.VoucherTypeID, AT1007.VoucherTypeName, MT0181.VoucherNo, MT0181.VoucherDate, MT0181.ObjectID, MT0181.EmployeeID, AT1103.FullName, MT0181.[Description], MT0181.[Disabled], 
	A21.ObjectName, A22.ObjectName as ObjectName2, AT1302.InventoryName,
	A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
	A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
	A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
	A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
	A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20,
	0 as ReQuantity, A32.ObjectName as ObjectName1, MT0181.InventoryTypeID, A32.Address as Address1, A32.Contactor, A32.VATNo, A32.BankAccountNo,
	A32.Tel, A32.Fax, A32.BankName, MT0182.DivisionID, MT0182.VoucherID	, MT0182.TransactionID, MT0182.TranMonth, MT0182.TranYear, MT0182.ObjectID2, 
	MT0182.PO, MT0182.InventoryID, MT0182.UnitID, MT0182.S01ID, MT0182.S02ID, MT0182.S03ID, MT0182.S04ID, MT0182.S05ID, MT0182.S06ID, MT0182.S07ID, MT0182.S08ID, MT0182.S09ID, MT0182.S10ID, 
	MT0182.S11ID, MT0182.S12ID, MT0182.S13ID, MT0182.S14ID, MT0182.S15ID, MT0182.S16ID, MT0182.S17ID, MT0182.S18ID, MT0182.S19ID, MT0182.S20ID, 
	Isnull(MT0182.Quantity,0) as Quantity, Isnull(MT0182.UnitPrice,0) as UnitPrice, Isnull(MT0182.ConvertedAmount,0) as ConvertedAmount, MT0182.SyncDate, MT0182.DeliverDate, MT0182.Notes, 
	MT0182.Ana01ID, MT0182.Ana02ID, MT0182.Ana03ID, MT0182.Ana04ID, MT0182.Ana05ID, MT0182.Ana06ID, MT0182.Ana07ID, MT0182.Ana08ID, MT0182.Ana09ID, MT0182.Ana10ID, 
	MT0182.Quantity01, MT0182.Quantity02, MT0182.Quantity03, MT0182.Quantity04, MT0182.Quantity05, MT0182.Quantity06, MT0182.Quantity07, MT0182.Quantity08, MT0182.Quantity09, MT0182.Quantity10, 
	MT0182.Quantity11, MT0182.Quantity12, MT0182.Quantity13, MT0182.Quantity14, MT0182.Quantity15, MT0182.Quantity16, MT0182.Quantity17, MT0182.Quantity18, MT0182.Quantity19, MT0182.Quantity20, 
	MT0182.Quantity21, MT0182.Quantity22, MT0182.Quantity23, MT0182.Quantity24, MT0182.Quantity25, MT0182.Quantity26, MT0182.Quantity27, MT0182.Quantity28, MT0182.Quantity29, MT0182.Quantity30, MT0182.Quantity31, 
	MT0182.NextQuantity, MT0182.Orders, MT0182.ObjectID1, MT0182.InvoiceNo, MT0182.InvoiceDate, Isnull(MT0182.ExchangeRate,0) as ExchangeRate, Isnull(MT0182.PhaseDecimal,0) as PhaseDecimal		
FROM MT0181 WITH (NOLOCK)
LEFT JOIN MT0182 WITH (NOLOCK) ON MT0181.DivisionID = MT0182.DivisionID AND MT0181.VoucherID = MT0182.VoucherID
LEFT JOIN AT1007 WITH (NOLOCK) ON AT1007.DivisionID = MT0181.DivisionID AND MT0181.VoucherTypeID = AT1007.VoucherTypeID
LEFT JOIN AT1103 WITH (NOLOCK) ON MT0181.EmployeeID = AT1103.EmployeeID
LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (MT0182.DivisionID,''@@@'') AND MT0182.InventoryID = AT1302.InventoryID
LEFT JOIN AT1202 A21 WITH (NOLOCK) ON A21.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND MT0181.ObjectID = A21.ObjectID
LEFT JOIN AT1202 A22 WITH (NOLOCK) ON A22.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND MT0182.ObjectID2 = A22.ObjectID
LEFT JOIN AT1202 A32 WITH (NOLOCK) ON A32.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND MT0182.ObjectID1 = A32.ObjectID
'

SET @sSQL1 = '
LEFT JOIN AT0128 A01 WITH (NOLOCK) ON MT0182.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
LEFT JOIN AT0128 A02 WITH (NOLOCK) ON MT0182.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
LEFT JOIN AT0128 A03 WITH (NOLOCK) ON MT0182.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
LEFT JOIN AT0128 A04 WITH (NOLOCK) ON MT0182.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
LEFT JOIN AT0128 A05 WITH (NOLOCK) ON MT0182.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
LEFT JOIN AT0128 A06 WITH (NOLOCK) ON MT0182.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
LEFT JOIN AT0128 A07 WITH (NOLOCK) ON MT0182.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
LEFT JOIN AT0128 A08 WITH (NOLOCK) ON MT0182.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
LEFT JOIN AT0128 A09 WITH (NOLOCK) ON MT0182.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
LEFT JOIN AT0128 A10 WITH (NOLOCK) ON MT0182.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
LEFT JOIN AT0128 A11 WITH (NOLOCK) ON MT0182.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
LEFT JOIN AT0128 A12 WITH (NOLOCK) ON MT0182.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
LEFT JOIN AT0128 A13 WITH (NOLOCK) ON MT0182.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
LEFT JOIN AT0128 A14 WITH (NOLOCK) ON MT0182.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
LEFT JOIN AT0128 A15 WITH (NOLOCK) ON MT0182.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
LEFT JOIN AT0128 A16 WITH (NOLOCK) ON MT0182.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
LEFT JOIN AT0128 A17 WITH (NOLOCK) ON MT0182.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
LEFT JOIN AT0128 A18 WITH (NOLOCK) ON MT0182.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
LEFT JOIN AT0128 A19 WITH (NOLOCK) ON MT0182.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
LEFT JOIN AT0128 A20 WITH (NOLOCK) ON MT0182.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20'' 
WHERE MT0181.DivisionID = '''+@DivisionID+''' 
	AND MT0181.VoucherID = '''+@VoucherID+'''   
' + @sWhere

EXEC (@sSQL + @sSQL1 )
PRINT @sSQL
PRINT @sSQL1
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
