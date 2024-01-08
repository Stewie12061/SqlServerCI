IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0081]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0081]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Load edit/view chi tiết hóa đơn mua hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Thanh Sơn on: 23/06/2015
---- Modified by Tiểu Mai on 15/12/2015: Bổ sung điều kiện left join AT8899
---- Modified by Phương Thảo on 17/01/2016: Bổ sung trường IsMultiExR, ExchangeRateDate
---- Modified by Phương Thảo on 02/03/2016: Bổ sung trường IsWithhodingTax
---- Modified by Tiểu Mai on 03/06/2016: Tách kiểm tra thiết lập theo quy cách
---- Modified by Tiểu Mai on 11/08/2016: Bổ sung trường PeriodID
---- Modified by Hải Long on 25/08/2016: Bổ sung thêm trường cho ABA
---- Modified by Bảo Thy on 06/09/2016: Bổ sung trường OrderID để load thông tin kế thừa
---- Modified on 16/05/2017 by Hải Long: Chỉnh sửa danh mục dùng chung
---- Modified on 02/10/2020 by Nhựt Trường: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---  Modified by Đức Thông on 12/11/2020: Lấy tên đối tượng lưu trên phiếu hay vì trên thiết lập (tránh sai thông tin khi phát hành sau khi thay đổi tên ở thiết lập)
---  Modified by Đức Thông on 04/12/2020: Lấy thêm otransactionid lúc truy vấn phiếu mua hàng để lưu vết đơn hàng mua ở phiếu nhập kho
---  Modified by Nhật Thanh on 13/04/2022: Lấy thêm ProductID và ProductName
-- <Example>
/*
	AP0081 'PC', '', 'TV23711baf-f6f4-46ec-a4a5-d2d4ff6ad904'
*/
CREATE PROCEDURE AP0081
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@VoucherID VARCHAR(50)	
)
AS

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	SELECT A90.VoucherID,  A90.BatchID, A90.TransactionID, A90.TableID, A90.DivisionID, A90.TranMonth, A90.TranYear,
		A90.TransactionTypeID, A90.CurrencyID, A90.ObjectID, A90.ObjectName1, A90.VATObjectID, A90.VATObjectName, A90.VATNo, A90.VATObjectAddress,
		A90.SRDivisionName, A90.SRAddress, A90.SenderReceiver, A90.CreditAccountID, A90.DebitAccountID, A90.ExchangeRate,
		A90.OriginalAmount, A90.ConvertedAmount, A90.IsMultiTax, A90.VATGroupID, A90.VATOriginalAmount, A90.VATConvertedAmount,
		A90.VoucherDate, A90.DueDate, A90.OriginalAmountCN, A90.ExchangeRateCN, A90.CurrencyIDCN, A90.InvoiceDate, A90.VoucherTypeID,
		A90.VATTypeID, A90.VoucherNo, A90.Serial, A90.InvoiceNo, A90.Orders, A90.EmployeeID, A90.RefNo01, A90.RefNo02, A90.VDescription,
		A90.BDescription, A90.TDescription, A90.Quantity, A90.UnitPrice, A90.MarkQuantity, A90.DiscountRate, A90.DiscountAmount, 
		A90.UnitID, A90.Status, A90.IsAudit, A90.ImTaxOriginalAmount, A90.ImTaxConvertedAmount, A90.ExpenseOriginalAmount,
		A90.ExpenseConvertedAmount, A90.Ana01ID, A90.Ana02ID, A90.Ana03ID, A90.Ana04ID, A90.Ana05ID, A90.Ana06ID, A90.Ana07ID,
		A90.Ana08ID, A90.Ana09ID, A90.Ana10ID, A90.CreateDate, A90.CreateUserID, A90.LastModifyDate, A90.LastModifyUserID,
		A90.InventoryID, A90.UnitID, A90.Quantity, A90.UnitPrice, A90.DiscountRate,
		A90.DiscountAmount, A90.OriginalAmount, A90.ConvertedAmount, A90.DebitAccountID,
		A90.CreditAccountID, A90.ImTaxConvertedAmount, A90.ExpenseConvertedAmount,
		A90.TDescription, A90.TransactionID, A90.Ana01ID, A90.Ana02ID, A90.Ana03ID,
		A90.Ana04ID, A90.Ana05ID, A90.Ana06ID, A90.Ana07ID, A90.Ana08ID, A90.Ana09ID,
		A90.Ana10ID, AT1302.InventoryName, A90.InventoryName1, AT1302.IsSource, AT1302.IsLocation, AT1302.IsLimitDate,
		AT1302.IsStocked, AT1302.IsSource, AT1302.IsLimitDate, AT1302.IsLocation, AT1302.IsStocked,
		AT1302.AccountID AS IsDebitAccountID, A90.ConversionFactor, 0 AS F11, A90.IsLateInvoice,
		A90.RefVoucherNo, A90.ReBatchID, A90.ReTransactionID, A90.ConvertedUnitID, A90.UParameter01,
		A90.UParameter02, A90.UParameter03, A90.UParameter04, A90.UParameter05, A90.ConvertedQuantity,
		A90.ConvertedPrice, WQ1309.Operator, WQ1309.DataType, AT1319.FormulaDes, A90.PaymentTermID,
		A90.WOrderID, A90.WTransactionID, AT1302.Barcode, A90.PriceListID, A90.InvoiceCode,
		A90.InvoiceSign, A90.InheritTableID, A90.InheritVoucherID, A90.InheritTransactionID, 
		A90.AssignedSET, A90.SETOriginalAmount, A90.SETConvertedAmount, A90.SETQuantity, A90.AssignedSET,
		A90.SETID, A90.SETTaxRate, A90.SETConvertedUnit, A90.SETQuantity, A90.SETOriginalAmount, 
		A90.SETConvertedAmount, A90.SETConsistID, A90.SETTransactionID, A90.SETUnitID,			
		O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
		O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
		AT01.StandardName S01Name, AT02.StandardName S02Name, AT03.StandardName S03Name, AT04.StandardName S04Name, AT05.StandardName S05Name,
		AT06.StandardName S06Name, AT07.StandardName S07Name, AT08.StandardName S08Name, AT09.StandardName S09Name, AT10.StandardName S10Name,
		AT11.StandardName S11Name, AT12.StandardName S12Name, AT13.StandardName S13Name, AT14.StandardName S14Name, AT15.StandardName S15Name,
		AT16.StandardName S16Name, AT17.StandardName S17Name, AT18.StandardName S18Name, AT19.StandardName S19Name, AT20.StandardName S20Name,
		A90.IsMultiExR, A90.ExchangeRateDate,
		A90.IsWithhodingTax, A90.PeriodID, A90.OrderID,
		A90.ABParameter01, A90.ABParameter02, A90.ABParameter03, A90.ABParameter04, A90.ABParameter05, 
		A90.ABParameter06, A90.ABParameter07, A90.ABParameter08, A90.ABParameter09, A90.ABParameter10, A90.OTransactionID,
		Isnull(A90.IsStock,0) AS IsStock
	FROM AT9000 A90 WITH (NOLOCK)
		LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (A90.DivisionID,'@@@') AND A90.InventoryID = AT1302.InventoryID
		LEFT JOIN AT1309 WQ1309 WITH (NOLOCK) ON WQ1309.InventoryID = A90.InventoryID AND WQ1309.UnitID = A90.ConvertedUnitID
		LEFT JOIN AT1319 WITH (NOLOCK) ON WQ1309.FormulaID = AT1319.FormulaID
		LEFT JOIN AT8899 O99 WITH (NOLOCK) ON A90.DivisionID = O99.DivisionID and A90.VoucherID = O99.VoucherID and O99.TransactionID = A90.TransactionID
		LEFT JOIN AT0128 AT01 WITH (NOLOCK) ON AT01.StandardID = O99.S01ID AND AT01.StandardTypeID = 'S01'
		LEFT JOIN AT0128 AT02 WITH (NOLOCK) ON AT02.StandardID = O99.S02ID AND AT02.StandardTypeID = 'S02'
		LEFT JOIN AT0128 AT03 WITH (NOLOCK) ON AT03.StandardID = O99.S03ID AND AT03.StandardTypeID = 'S03'
		LEFT JOIN AT0128 AT04 WITH (NOLOCK) ON AT04.StandardID = O99.S04ID AND AT04.StandardTypeID = 'S04'
		LEFT JOIN AT0128 AT05 WITH (NOLOCK) ON AT05.StandardID = O99.S05ID AND AT05.StandardTypeID = 'S05'
		LEFT JOIN AT0128 AT06 WITH (NOLOCK) ON AT06.StandardID = O99.S06ID AND AT06.StandardTypeID = 'S06'
		LEFT JOIN AT0128 AT07 WITH (NOLOCK) ON AT07.StandardID = O99.S07ID AND AT07.StandardTypeID = 'S07'
		LEFT JOIN AT0128 AT08 WITH (NOLOCK) ON AT08.StandardID = O99.S08ID AND AT08.StandardTypeID = 'S08'
		LEFT JOIN AT0128 AT09 WITH (NOLOCK) ON AT09.StandardID = O99.S09ID AND AT09.StandardTypeID = 'S09'
		LEFT JOIN AT0128 AT10 WITH (NOLOCK) ON AT10.StandardID = O99.S10ID AND AT10.StandardTypeID = 'S10'
		LEFT JOIN AT0128 AT11 WITH (NOLOCK) ON AT11.StandardID = O99.S11ID AND AT11.StandardTypeID = 'S11'
		LEFT JOIN AT0128 AT12 WITH (NOLOCK) ON AT12.StandardID = O99.S12ID AND AT12.StandardTypeID = 'S12'
		LEFT JOIN AT0128 AT13 WITH (NOLOCK) ON AT13.StandardID = O99.S13ID AND AT13.StandardTypeID = 'S13'
		LEFT JOIN AT0128 AT14 WITH (NOLOCK) ON AT14.StandardID = O99.S15ID AND AT14.StandardTypeID = 'S14'
		LEFT JOIN AT0128 AT15 WITH (NOLOCK) ON AT15.StandardID = O99.S15ID AND AT15.StandardTypeID = 'S15'
		LEFT JOIN AT0128 AT16 WITH (NOLOCK) ON AT16.StandardID = O99.S16ID AND AT16.StandardTypeID = 'S16'
		LEFT JOIN AT0128 AT17 WITH (NOLOCK) ON AT17.StandardID = O99.S17ID AND AT17.StandardTypeID = 'S17'
		LEFT JOIN AT0128 AT18 WITH (NOLOCK) ON AT18.StandardID = O99.S18ID AND AT18.StandardTypeID = 'S18'
		LEFT JOIN AT0128 AT19 WITH (NOLOCK) ON AT19.StandardID = O99.S19ID AND AT19.StandardTypeID = 'S19'
		LEFT JOIN AT0128 AT20 WITH (NOLOCK) ON AT20.StandardID = O99.S20ID AND AT20.StandardTypeID = 'S20'
	WHERE A90.DivisionID = @DivisionID
		AND A90.VoucherID = @VoucherID
		AND A90.TransactionTypeID IN ('T03')
		AND A90.TableID = 'AT9000'	
	ORDER BY A90.Orders	
END
ELSE
BEGIN
	SELECT A90.VoucherID,  A90.BatchID, A90.TransactionID, A90.TableID, A90.DivisionID, A90.TranMonth, A90.TranYear,
		A90.TransactionTypeID, A90.CurrencyID, A90.ObjectID, A90.ObjectName1, A90.VATObjectID, A90.VATObjectName, A90.VATNo, A90.VATObjectAddress,
		A90.SRDivisionName, A90.SRAddress, A90.SenderReceiver, A90.CreditAccountID, A90.DebitAccountID, A90.ExchangeRate,
		A90.OriginalAmount, A90.ConvertedAmount, A90.IsMultiTax, A90.VATGroupID, A90.VATOriginalAmount, A90.VATConvertedAmount,
		A90.VoucherDate, A90.DueDate, A90.OriginalAmountCN, A90.ExchangeRateCN, A90.CurrencyIDCN, A90.InvoiceDate, A90.VoucherTypeID,
		A90.VATTypeID, A90.VoucherNo, A90.Serial, A90.InvoiceNo, A90.Orders, A90.EmployeeID, A90.RefNo01, A90.RefNo02, A90.VDescription,
		A90.BDescription, A90.TDescription, A90.Quantity, A90.UnitPrice, A90.MarkQuantity, A90.DiscountRate, A90.DiscountAmount, 
		A90.UnitID, A90.Status, A90.IsAudit, A90.ImTaxOriginalAmount, A90.ImTaxConvertedAmount, A90.ExpenseOriginalAmount,
		A90.ExpenseConvertedAmount, A90.Ana01ID, A90.Ana02ID, A90.Ana03ID, A90.Ana04ID, A90.Ana05ID, A90.Ana06ID, A90.Ana07ID,
		A90.Ana08ID, A90.Ana09ID, A90.Ana10ID, A90.CreateDate, A90.CreateUserID, A90.LastModifyDate, A90.LastModifyUserID,
		A90.InventoryID, A90.UnitID, A90.Quantity, A90.UnitPrice, A90.DiscountRate,
		A90.DiscountAmount, A90.OriginalAmount, A90.ConvertedAmount, A90.DebitAccountID,
		A90.CreditAccountID, A90.ImTaxConvertedAmount, A90.ExpenseConvertedAmount,
		A90.TDescription, A90.TransactionID, A90.Ana01ID, A90.Ana02ID, A90.Ana03ID,
		A90.Ana04ID, A90.Ana05ID, A90.Ana06ID, A90.Ana07ID, A90.Ana08ID, A90.Ana09ID,
		A90.Ana10ID, A13.InventoryName, A90.InventoryName1, A13.IsSource, A13.IsLocation, A13.IsLimitDate,
		A13.IsStocked, A13.IsSource, A13.IsLimitDate, A13.IsLocation, A13.IsStocked,
		A13.AccountID AS IsDebitAccountID, A90.ConversionFactor, 0 AS F11, A90.IsLateInvoice,
		A90.RefVoucherNo, A90.ReBatchID, A90.ReTransactionID, A90.ConvertedUnitID, A90.UParameter01,
		A90.UParameter02, A90.UParameter03, A90.UParameter04, A90.UParameter05, A90.ConvertedQuantity,
		A90.ConvertedPrice, WQ1309.Operator, WQ1309.DataType, AT1319.FormulaDes, A90.PaymentTermID,
		A90.WOrderID, A90.WTransactionID, A13.Barcode, A90.PriceListID, A90.InvoiceCode,
		A90.InvoiceSign, A90.InheritTableID, A90.InheritVoucherID, A90.InheritTransactionID, 
		A90.AssignedSET, A90.SETOriginalAmount, A90.SETConvertedAmount, A90.SETQuantity, A90.AssignedSET,
		A90.SETID, A90.SETTaxRate, A90.SETConvertedUnit, A90.SETQuantity, A90.SETOriginalAmount, 
		A90.SETConvertedAmount, A90.SETConsistID, A90.SETTransactionID, A90.SETUnitID,			
		A90.IsMultiExR, A90.ExchangeRateDate,
		A90.IsWithhodingTax, A90.PeriodID, A90.OrderID,
		A90.ABParameter01, A90.ABParameter02, A90.ABParameter03, A90.ABParameter04, A90.ABParameter05, 
		A90.ABParameter06, A90.ABParameter07, A90.ABParameter08, A90.ABParameter09, A90.ABParameter10,
		Isnull(A90.IsStock,0) AS IsStock, A90.OTransactionID, ProductID, A13_2.InventoryName as ProductName
	FROM AT9000 A90 WITH (NOLOCK)
		LEFT JOIN AT1302 A13 WITH (NOLOCK) ON A13.DivisionID IN (A90.DivisionID,'@@@') AND A90.InventoryID = A13.InventoryID
		LEFT JOIN AT1302 A13_2 WITH (NOLOCK) ON A13_2.DivisionID IN (A90.DivisionID,'@@@') AND A90.ProductID = A13_2.InventoryID
		LEFT JOIN AT1309 WQ1309 WITH (NOLOCK) ON WQ1309.InventoryID = A90.InventoryID AND WQ1309.UnitID = A90.ConvertedUnitID
		LEFT JOIN AT1319 WITH (NOLOCK) ON WQ1309.FormulaID = AT1319.FormulaID
	WHERE A90.DivisionID = @DivisionID
		AND A90.VoucherID = @VoucherID
		AND A90.TransactionTypeID IN ('T03')
		AND A90.TableID = 'AT9000'	
	ORDER BY A90.Orders
	
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
