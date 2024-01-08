IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0074_QC]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP0074_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Lấy dữ liệu phiếu mua hàng để lập phiếu trả hàng mua (AF073) theo quy cách
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create by Tieu Mai on 16/12/2015: Thay câu query load chi tiết hóa đơn mua hàng hiện tại 
---- Modified by Bảo Thy on 11/05/2017: Sửa danh mục dùng chung
---- Modified by Bảo Thy on 06/09/2017: Chỉ cho kế thừa mặt hàng không phải loại mặt hàng chi phí (chuẩn)
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
-- <Example>
---- 
CREATE PROCEDURE [DBO].[AP0074_QC]
(
	@DivisionID AS NVARCHAR(50),	
	@VoucherID AS NVARCHAR(50) 
) 
AS
	SELECT AT9000.VoucherID,AT9000.BatchID,AT9000.TransactionID,AT9000.TableID,AT9000.DivisionID,AT9000.TranMonth,AT9000.TranYear,AT9000.TransactionTypeID,AT9000.CurrencyID,
		AT9000.ObjectID,AT9000.VATObjectID,AT9000.VATObjectName,AT9000.VATNo,AT9000.VATObjectAddress,AT9000.SRDivisionName,AT9000.SRAddress,AT9000.SenderReceiver,AT9000.CreditAccountID,
		AT9000.DebitAccountID,AT9000.ExchangeRate,AT9000.OriginalAmount,AT9000.ConvertedAmount,AT9000.IsMultiTax,AT9000.VATGroupID,AT9000.VATOriginalAmount,AT9000.VATConvertedAmount,
		AT9000.VoucherDate,AT9000.DueDate,AT9000.OriginalAmountCN,AT9000.ExchangeRateCN,AT9000.CurrencyIDCN,AT9000.InvoiceDate,AT9000.VoucherTypeID,AT9000.VATTypeID,AT9000.VoucherNo,AT9000.Serial,
		AT9000.InvoiceNo,AT9000.Orders,AT9000.EmployeeID,AT9000.RefNo01,AT9000.RefNo02,AT9000.VDescription,AT9000.BDescription,AT9000.TDescription,AT9000.Quantity,
		AT9000.UnitPrice,AT9000.DiscountRate,AT9000.InventoryID,AT9000.UnitID,AT9000.Status,AT9000.IsAudit,AT9000.ImTaxOriginalAmount,AT9000.ImTaxConvertedAmount,AT9000.ExpenseOriginalAmount,
		AT9000.ExpenseConvertedAmount,AT9000.Ana01ID,AT9000.Ana02ID,AT9000.Ana03ID,AT9000.Ana04ID,AT9000.Ana05ID,AT9000.Ana06ID,AT9000.Ana07ID,AT9000.Ana08ID,AT9000.Ana09ID,
		AT9000.Ana10ID,AT9000.CreateDate,AT9000.CreateUserID,AT9000.LastModifyDate,AT9000.LastModifyUserID,AT9000.ReVoucherID,AT9000.IsStock, AT1302.InventoryName,AT1302.IsSource,AT1302.IsLimitDate,
		AT1302.IsLocation,AT1302.IsStocked,AT1302.AccountID AS IsDebitAccountID,AT1302.Barcode,AT1302.MethodID,'' AS InventoryName1,
		CAST(Isnull(WQ1309.ConversionFactor,0) AS DECIMAL) AS ConversionFactor,
		AT9000.ConvertedUnitID, AT9000.ConvertedQuantity, AT9000.ConvertedPrice, AT9000.MarkQuantity,
		AT9000.UParameter01, AT9000.UParameter02, AT9000.UParameter03, AT9000.UParameter04, AT9000.UParameter05,
		WQ1309.Operator, WQ1309.DataType, WQ1309.FormulaDes,AT9000.InvoiceCode,AT9000.InvoiceSign,			
		O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
		O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID,
		AT01.StandardName S01Name, AT02.StandardName S02Name, AT03.StandardName S03Name, AT04.StandardName S04Name, AT05.StandardName S05Name,
		AT06.StandardName S06Name, AT07.StandardName S07Name, AT08.StandardName S08Name, AT09.StandardName S09Name, AT10.StandardName S10Name,
		AT11.StandardName S11Name, AT12.StandardName S12Name, AT13.StandardName S13Name, AT14.StandardName S14Name, AT15.StandardName S15Name,
		AT16.StandardName S16Name, AT17.StandardName S17Name, AT18.StandardName S18Name, AT19.StandardName S19Name, AT20.StandardName S20Name
	FROM AT9000 WITH (NOLOCK) LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,'@@@') AND AT9000.InventoryID = AT1302.InventoryID
		Left join WQ1309 On WQ1309.DivisionID IN (AT9000.DivisionID, '@@@') And AT9000.InventoryID = WQ1309.InventoryID
		And AT9000.ConvertedUnitID = WQ1309.ConvertedUnitID
		left join AT8899 O99 WITH (NOLOCK) on O99.DivisionID = AT9000.DivisionID and O99.VoucherID = AT9000.VoucherID and O99.TransactionID = AT9000.TransactionID AND O99.TableID = 'AT9000'
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
      WHERE AT9000.VoucherID = @VoucherID
      AND AT9000.TransactionTypeID IN ('T03')
      AND AT9000.TableID = 'AT9000'
	  AND ISNULL(AT1302.IsExpense,0) <> 1
      AND AT9000.DivisionID = @DivisionID
      ORDER BY Orders

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


