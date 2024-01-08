IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP2044_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP2044_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Load chi tiết các phiếu kiểm kê để lên màn hình truy vấn theo quy cách
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by Tiểu Mai on 29/10/2015
---- Modified on 18/01/2016 by Bảo Anh: Bổ sung mã vạch thùng, số lượng thùng, số lượng định mức KIT (Angel)
---- Modified on 28/01/2016 by Bảo Anh: Bổ sung SL kém phẩm chất và mất phẩm chất (Angel)
---- Modified by Phương Thảo on 10/05/2016 : Sửa danh mục dùng chung
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
-- <Example>
/*
   exec AP2044 @DivisionID=N'HD',@UserID='ASOFTADMIN',@VoucherID='dc5d4f8c-6c19-4ca7-9cd9-e96ec6f70c86'
*/

 CREATE PROCEDURE AP2044_QC
(
     @DivisionID NVARCHAR(2000),
     @UserID VARCHAR(50),
	 @VoucherID VARCHAR(50)
)
AS
DECLARE @sSQL NVARCHAR(MAX)
SET @sSQL = '
SELECT A36.VoucherTypeID, A36.VoucherNo, A36.VoucherDate, A02.InventoryTypeID, A36.WareHouseID, A36.EmployeeID,
	A37.TransactionID, A36.VoucherID, A37.InventoryID, A02.InventoryName, A37.UnitID, A04.UnitName, A37.Quantity,
	A37.UnitPrice, A37.OriginalAmount, A37.ConvertedAmount, A37.AdjustQuantity, A37.AdjustUnitPrice, A37.AdjutsOriginalAmount,
	A36.[Description], A36.TranMonth, A36.TranYear, A36.DivisionID, A37.SourceNo, A37.DebitAccountID, A37.Orders, A37.LimitDate,
	A37.Notes, A37.ReVoucherID, A37.ReTransactionID, A37.isAdjust, A02.IsSource, A02.IsLimitDate, A02.IsLocation, A02.MethodID,
	A02.AccountID, A02.Specification, A02.Notes01, A02.Notes02, A02.Notes03, A36.CreateUserID,
	O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
	O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
	AT01.StandardName S01Name, AT02.StandardName S02Name, AT03.StandardName S03Name, AT04.StandardName S04Name, AT05.StandardName S05Name,
	AT06.StandardName S06Name, AT07.StandardName S07Name, AT08.StandardName S08Name, AT09.StandardName S09Name, AT10.StandardName S10Name,
	AT11.StandardName S11Name, AT12.StandardName S12Name, AT13.StandardName S13Name, AT14.StandardName S14Name, AT15.StandardName S15Name,
	AT16.StandardName S16Name, AT17.StandardName S17Name, AT18.StandardName S18Name, AT19.StandardName S19Name, AT20.StandardName S20Name,
	A37.KITID, A37.KITQuantity,
	(Select InventoryQuantity From AT1326 Where DivisionID = A37.DivisionID And KITID = A37.KITID And InventoryID = A37.InventoryID) as InventoryQuantity,
	A37.PoorQAQty, A37.DeterioratingQAQty
FROM AT2037 A37
LEFT JOIN AT1304 A04 ON A04.UnitID = A37.UnitID
LEFT JOIN AT1302 A02 ON A02.DivisionID IN (A37.DivisionID,''@@@'') AND A02.InventoryID = A37.InventoryID 
LEFT JOIN AT2036 A36 ON A36.DivisionID = A37.DivisionID AND A36.VoucherID = A37.VoucherID
LEFT JOIN WT8899 O99 ON O99.DivisionID = A37.DivisionID AND O99.TransactionID = A37.TransactionID AND O99.VoucherID = A37.VoucherID
LEFT JOIN AT0128 AT01 ON AT01.StandardID = O99.S01ID AND AT01.StandardTypeID = ''S01''
LEFT JOIN AT0128 AT02 ON AT02.StandardID = O99.S02ID AND AT02.StandardTypeID = ''S02''
LEFT JOIN AT0128 AT03 ON AT03.StandardID = O99.S03ID AND AT03.StandardTypeID = ''S03''
LEFT JOIN AT0128 AT04 ON AT04.StandardID = O99.S04ID AND AT04.StandardTypeID = ''S04''
LEFT JOIN AT0128 AT05 ON AT05.StandardID = O99.S05ID AND AT05.StandardTypeID = ''S05''
LEFT JOIN AT0128 AT06 ON AT06.StandardID = O99.S06ID AND AT06.StandardTypeID = ''S06''
LEFT JOIN AT0128 AT07 ON AT07.StandardID = O99.S07ID AND AT07.StandardTypeID = ''S07''
LEFT JOIN AT0128 AT08 ON AT08.StandardID = O99.S08ID AND AT08.StandardTypeID = ''S08''
LEFT JOIN AT0128 AT09 ON AT09.StandardID = O99.S09ID AND AT09.StandardTypeID = ''S09''
LEFT JOIN AT0128 AT10 ON AT10.StandardID = O99.S10ID AND AT10.StandardTypeID = ''S10''
LEFT JOIN AT0128 AT11 ON AT11.StandardID = O99.S11ID AND AT11.StandardTypeID = ''S11''
LEFT JOIN AT0128 AT12 ON AT12.StandardID = O99.S12ID AND AT12.StandardTypeID = ''S12''
LEFT JOIN AT0128 AT13 ON AT13.StandardID = O99.S13ID AND AT13.StandardTypeID = ''S13''
LEFT JOIN AT0128 AT14 ON AT14.StandardID = O99.S15ID AND AT14.StandardTypeID = ''S14''
LEFT JOIN AT0128 AT15 ON AT15.StandardID = O99.S15ID AND AT15.StandardTypeID = ''S15''
LEFT JOIN AT0128 AT16 ON AT16.StandardID = O99.S16ID AND AT16.StandardTypeID = ''S16''
LEFT JOIN AT0128 AT17 ON AT17.StandardID = O99.S17ID AND AT17.StandardTypeID = ''S17''
LEFT JOIN AT0128 AT18 ON AT18.StandardID = O99.S18ID AND AT18.StandardTypeID = ''S18''
LEFT JOIN AT0128 AT19 ON AT19.StandardID = O99.S19ID AND AT19.StandardTypeID = ''S19''
LEFT JOIN AT0128 AT20 ON AT20.StandardID = O99.S20ID AND AT20.StandardTypeID = ''S20''	
WHERE A37.DivisionID = '''+@DivisionID+'''
AND A37.VoucherID = '''+@VoucherID+''' '

EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON