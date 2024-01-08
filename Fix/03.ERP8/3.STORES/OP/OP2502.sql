IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[OP2502]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[OP2502]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Ke thua chao gia cho don hang ban,
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 19/07/2005 by Vo Thanh Huong
---- 
---- Last Edit : Thuy Tuyen , date : 10/09/2009, date: 26/10/2009
---- Last Edit : Thien Huynh , date : 10/05/2012 : Bo sung 5 Khoan muc
---- Last Edit : Việt Khánh , date : 18/09/2012 : Thêm 5 tham số tính số lượng
---- Modified on 21/12/2011 by 
---- Modified on 03/09/2015 by Tiểu Mai: Customize cho khách hàng An Phú Gia, bổ sung kế thừa chỉ kế thừa thành phẩm cho đơn hàng bán.
---- Modified by Tieu Mai on 18/11/2015: Bổ sung 20 cột quy cách khi có thiết lập quản lý mặt hàng theo quy cách.
---- Modified by Tiểu Mai on 06/06/2016: Bổ sung WITH (NOLOCK)
---- Modified by Tiểu Mai on 09/02/2017: Fix tràn chuỗi
---- Midified by Kim Vũ on 09/05/2017: Bổ sung lấy trường PriceListID
---- Modified by Phương Thảo on 10/05/2017: Bổ sung 10 tham số
---- Modified by TIểu Mai on 24/05/2017: Bổ sung chỉnh sửa danh mục dùng chung
---- Modified by Huỳnh Thử on 28/09/2020 : Bổ sung danh mục dùng chung
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
---- 


CREATE PROCEDURE  [dbo].[OP2502] 
		@DivisionID nvarchar(50),
		@VoucherID nvarchar(200),
		@VoucherDate DATETIME,
		@IsTP TINYINT
AS
DECLARE @sSQL nvarchar(4000), @sSQL1 NVARCHAR(4000), @sSQL2 NVARCHAR(4000)

SET  @VoucherID = 	Replace(@VoucherID, ',', ''',''')
SET @sSQL1 =''
SET @sSQL = '
SELECT	OT2101.DivisionID, 
		OT2101.QuotationID, 
		OT2101.ObjectID, 	
		CASE WHEN ISNULL(OT2101.ObjectName, '''') <> '''' then OT2101.ObjectName else AT1202.ObjectName end AS ObjectName,
		CASE WHEN ISNULL(OT2101.Address, '''') <> '''' then OT2101.Address else AT1202.Address end AS Address,
 		IsUpdateName, 
		CASE WHEN ISNULL(AT1202.ReDueDays, 0) <> 0 then DATEADD(d,  AT1202.ReDueDays,  ''' + convert(nvarchar(50), @VoucherDate, 101) + ''') else NULL end  AS DueDate, 
		OT2101.EmployeeID, 
		AT1103.FullName,
		OT2101.InventoryTypeID, 
		OT2101.CurrencyID, 
		OT2101.ExchangeRate, 
		OT2101.PaymentID, 
		OT2101.PaymentTermID,
		OT2101.Transport, 
		OT2101.DeliveryAddress, 
		OT2101.SalesManID, 
		AT1103_S.FullName AS SalesManName, 
		OT2101.ClassifyID, 
		OT2101.Ana01ID, 
		OT2101.Ana02ID, 
		OT2101.Ana03ID, 
		OT2101.Ana04ID, 
		OT2101.Ana05ID,
		OT2101.Varchar01,
		OT2101.Varchar02,
		OT2101.Varchar03,
		OT2101.Varchar04,
		OT2101.Varchar05,
		OT2101.Varchar06,
		OT2101.Varchar07,
		OT2101.Varchar08,
		OT2101.Varchar09,
		OT2101.varchar10,
		OT2101.varchar11,
		OT2101.varchar12,
		OT2101.varchar13,
		OT2101.varchar14,
		OT2101.varchar15,
		OT2101.varchar16,
		OT2101.varchar17,
		OT2101.varchar18,
		OT2101.varchar19,
		OT2101.varchar20,
		OT2101.Description,
		OT2101.PriceListID			
FROM	OT2101 WITH (NOLOCK) 
LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT1202.ObjectID = OT2101.ObjectID
LEFT JOIN AT1103 WITH (NOLOCK) on  AT1103.EmployeeID = OT2101.EmployeeID
LEFT JOIN AT1103  AT1103_S  WITH (NOLOCK) on AT1103_S.EmployeeID = OT2101.SalesManID
WHERE	OT2101.DivisionID = ''' + @DivisionID + ''' and 
		OT2101.QuotationID in  (''' + @VoucherID + ''') '

IF  EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WHERE XTYPE = 'V' AND NAME = 'OV2502')
	DROP VIEW OV2502

EXEC('CREATE VIEW OV2502 ---tao boi OP2502
		AS ' + @sSQL)


DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang An Phu Gia khong (CustomerName = 48)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName = 48 AND @IsTP = 1
BEGIN
	SET @sSQL = '
SELECT	OT2102.DivisionID,
		OT2102.TransactionID,
		OT2102.QuotationID,
		OT2102.Orders, 
		OT2102.InventoryID, 
		CASE WHEN ISNULL(OT2102.InventoryCommonName, '''') <> '''' then OT2102.InventoryCommonName else AT1302.InventoryName end AS InventoryName,
		CASE WHEN ISNULL(OT2102.InventoryCommonName, '''') <> '''' then 1 else 0 end AS IsEditInventoryName,	
		CASE WHEN AT1302.IsStocked = 1 then 1 else 0 end AS IsPicking, 
		OT2102.UnitID, 
		OT2102.QuoQuantity01 AS OrderQuantity, 	
		UnitPrice = CASE WHEN ISNULL(OT2102.UnitPrice,0)<>0 then OT2102.UnitPrice ELSE (SUM(O02.OriginalAmount)/OT2102.QuoQuantity01) end, 
		OriginalAmount = CASE WHEN ISNULL(OT2102.OriginalAmount,0)<>0 then OT2102.OriginalAmount else SUM(O02.OriginalAmount) end, 
		ConvertedAmount = CASE WHEN ISNULL(OT2102.ConvertedAmount,0)<>0 then OT2102.ConvertedAmount else SUM(O02.ConvertedAmount) end, 
		
		isnull(OT2102.DiscountPercent,0) AS DiscountPercent, 
		DiscountOriginalAmount = isnull(CASE WHEN ISNULL(OT2102.DiscountOriginalAmount,0)<>0 THEN OT2102.DiscountOriginalAmount ELSE OT2102.DiscountPercent*SUM(O02.OriginalAmount)/100 END,0), 
		DiscountConvertedAmount =  isnull(CASE WHEN ISNULL(OT2102.DiscountConvertedAmount,0)<>0 THEN OT2102.DiscountConvertedAmount ELSE OT2102.DiscountPercent*SUM(O02.ConvertedAmount)/100 END,0), 
		
		ISNULL(O02.OriginalAmountOutput,SUM(O02.OriginalAmount) ) - ISNULL(O02.DiscountOriginalAmount,0)  AS OriginalAmountBeforeVAT,
		SUM(O02.ConvertedAmount)  - ISNULL(O02.DiscountConvertedAmount,0)  AS ConvertAmountBeforeVAT,
		
		OT2102.VATGroupID, 
		AT1010.VATRate as VATPercent, 
		VATOriginalAmount = CASE WHEN ISNULL(OT2102.OriginalAmount,0)<>0 then OT2102.OriginalAmount*AT1010.VATRate/100 else SUM(O02.OriginalAmount)*AT1010.VATRate/100 end,
		VATConvertedAmount = CASE WHEN ISNULL(OT2102.ConvertedAmount,0)<>0 then OT2102.ConvertedAmount*AT1010.VATRate/100 else SUM(O02.ConvertedAmount)*AT1010.VATRate/100 end, 		 

		(isnull(CASE WHEN ISNULL(OT2102.OriginalAmount,0)<>0 then OT2102.OriginalAmount else SUM(O02.OriginalAmount) END,0) - isnull(CASE WHEN ISNULL(OT2102.DiscountOriginalAmount,0)<>0 THEN OT2102.DiscountOriginalAmount ELSE OT2102.DiscountPercent*SUM(O02.OriginalAmount)/100 END,0) 
		+ isnull(CASE WHEN ISNULL(OT2102.OriginalAmount,0)<>0 then OT2102.OriginalAmount*AT1010.VATRate/100 else SUM(O02.OriginalAmount)*AT1010.VATRate/100 END,0)) AS OriginalAmountAfterVAT,
		
		(ISNULL(CASE WHEN ISNULL(OT2102.ConvertedAmount,0)<>0 then OT2102.ConvertedAmount else SUM(O02.ConvertedAmount) end,0) - ISNULL(CASE WHEN ISNULL(OT2102.DiscountConvertedAmount,0)<>0 THEN OT2102.DiscountConvertedAmount ELSE OT2102.DiscountPercent*SUM(O02.ConvertedAmount)/100 END,0) 
		+ ISNULL(CASE WHEN ISNULL(OT2102.ConvertedAmount,0)<>0 then OT2102.ConvertedAmount*AT1010.VATRate/100 else SUM(O02.ConvertedAmount)*AT1010.VATRate/100 END,0))  AS ConvertedAmountAfterVAT,
		'
SET @sSQL1 = '
		OT2102.Ana01ID, 
		OT2102.Ana02ID, 
		OT2102.Ana03ID, 
		OT2102.Ana04ID, 
		OT2102.Ana05ID, 
		OT2102.Ana06ID, 
		OT2102.Ana07ID, 
		OT2102.Ana08ID, 
		OT2102.Ana09ID, 
		OT2102.Ana10ID, 
		OT2102.Notes,
		OT2102.Notes01,
		OT2102.Notes02,
		AT1302.Barcode,
		OT2102.ConvertedQuantity,
		OT2102.ConvertedSalePrice,
		SUM(OT2102.OriginalAmount) AS OriginalAmountOutput ,
		OT2102.Markup,
		SUM(OT2102.ConvertedAmount)  AS ConvertedAmountOutput,
		OT2102.ConvertedSalepriceInput,
		OT2102.Parameter01, OT2102.Parameter02, OT2102.Parameter03, OT2102.Parameter04, OT2102.Parameter05,
		OT2102.QD01 as nvarchar01, OT2102.QD02 as nvarchar02,OT2102.QD03 as nvarchar03,OT2102.QD04 as nvarchar04,OT2102.QD05 as nvarchar05,
		OT2102.QD06 as nvarchar06,OT2102.QD07 as nvarchar07,OT2102.QD08 as nvarchar08,OT2102.QD09 as nvarchar09 ,OT2102.QD10 as nvarchar10 '
SET @sSQL2 = '	
FROM	OT2102 WITH (NOLOCK) 
LEFT JOIN AT1302  WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', OT2102.DivisionID) AND AT1302.InventoryID = OT2102.InventoryID
INNER JOIN OT2101 WITH (NOLOCK) on OT2101.QuotationID = OT2102.QuotationID And OT2101.DivisionID = OT2102.DivisionID
LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = OT2102.VATGroupID
LEFT JOIN OT2102 O02 WITH (NOLOCK) ON O02.DivisionID = OT2102.DivisionID AND O02.QuotationID = OT2102.QuotationID AND O02.Ana02ID = OT2102.Ana02ID
WHERE	OT2101.DivisionID = ''' + @DivisionID + ''' and 
		OT2101.QuotationID in  (''' + @VoucherID + ''') AND
		AT1302.InventoryTypeID = ''TP''
GROUP BY OT2102.OriginalAmount,OT2102.InventoryID, OT2102.Ana02ID,OT2102.QuoQuantity01, OT2102.DivisionID,OT2102.TransactionID,OT2102.QuotationID,
		OT2102.Orders,OT2102.InventoryCommonName,AT1302.InventoryName,	AT1302.IsStocked, OT2102.UnitID, OT2102.UnitPrice,OT2102.DiscountPercent,  
		O02.OriginalAmountOutput,O02.DiscountOriginalAmount,OT2102.DiscountConvertedAmount,OT2102.DiscountOriginalAmount,OT2102.OriginalAmount,
		OT2102.ConvertedAmount,O02.OriginalAmountOutput,O02.DiscountConvertedAmount,OT2102.VATGroupID,AT1010.VATRate,OT2102.VATOriginalAmount,OT2102.VATConvertedAmount,
		OT2102.Ana01ID, OT2102.Ana02ID,OT2102.Ana03ID,OT2102.Ana04ID,OT2102.Ana05ID, OT2102.Ana06ID,OT2102.Ana07ID, OT2102.Ana08ID,OT2102.Ana09ID, OT2102.Ana10ID, 
		OT2102.Notes,OT2102.Notes01,OT2102.Notes02,AT1302.Barcode,OT2102.ConvertedQuantity,OT2102.ConvertedSalePrice,OT2102.Markup,OT2102.ConvertedSalepriceInput,
		OT2102.Parameter01, OT2102.Parameter02, OT2102.Parameter03, OT2102.Parameter04, OT2102.Parameter05,
		OT2102.QD01, OT2102.QD02,OT2102.QD03,OT2102.QD04,OT2102.QD05,
		OT2102.QD06,OT2102.QD07,OT2102.QD08,OT2102.QD09 ,OT2102.QD10'
END
ELSE 
BEGIN
	SET @sSQL = '
		SELECT	OT2102.DivisionID,
				OT2102.TransactionID,
				OT2102.QuotationID,
				OT2102.Orders, 
				OT2102.InventoryID, 
				CASE WHEN ISNULL(OT2102.InventoryCommonName, '''') <> '''' then OT2102.InventoryCommonName else AT1302.InventoryName end AS InventoryName,
				CASE WHEN ISNULL(OT2102.InventoryCommonName, '''') <> '''' then 1 else 0 end AS IsEditInventoryName,	
				CASE WHEN AT1302.IsStocked = 1 then 1 else 0 end AS IsPicking, 
				OT2102.UnitID, 
				OT2102.QuoQuantity AS OrderQuantity, 
				OT2102.UnitPrice, 
				OT2102.OriginalAmount, 
				OT2102.ConvertedAmount, 
		
				OT2102.DiscountPercent, 
				OT2102.DiscountOriginalAmount, 
				OT2102.DiscountConvertedAmount, 
		
				--ISNULL(OT2102.OriginalAmountOutput,OT2102.OriginalAmount * ( 1 + ISNULL(OT2102.Markup,0)/100)) - ISNULL(OT2102.DiscountOriginalAmount,0)  AS OriginalAmountBeforeVAT,
				--OT2102.ConvertedAmount * ( 1 + ISNULL(OT2102.Markup,0)/100) - ISNULL(OT2102.DiscountConvertedAmount,0)  AS ConvertAmountBeforeVAT,
				ISNULL(OT2102.OriginalAmountOutput,OT2102.OriginalAmount ) - ISNULL(OT2102.DiscountOriginalAmount,0)  AS OriginalAmountBeforeVAT,
				OT2102.ConvertedAmount  - ISNULL(OT2102.DiscountConvertedAmount,0)  AS ConvertAmountBeforeVAT,
		
				OT2102.VATGroupID, 
				OT2102.VATPercent, 
				OT2102.VATOriginalAmount,
				OT2102.VATConvertedAmount, 		 
		
				--ISNULL(OT2102.OriginalAmountOutput,OT2102.OriginalAmount * ( 1 + ISNULL(OT2102.Markup,0)/100)) - ISNULL(OT2102.DiscountOriginalAmount,0) - OT2102.VATOriginalAmount AS OriginalAmountAfterVAT,
				--OT2102.ConvertedAmount * ( 1 + ISNULL(OT2102.Markup,0)/100) - ISNULL(OT2102.DiscountConvertedAmount,0) - OT2102.VATConvertedAmount  AS ConvertedAmountAfterVAT,
				ISNULL(OT2102.OriginalAmountOutput,OT2102.OriginalAmount ) - ISNULL(OT2102.DiscountOriginalAmount,0) + OT2102.VATOriginalAmount AS OriginalAmountAfterVAT,
				OT2102.ConvertedAmount  - ISNULL(OT2102.DiscountConvertedAmount,0) + OT2102.VATConvertedAmount  AS ConvertedAmountAfterVAT,
		'
	SET @sSQL1 = '
				OT2102.Ana01ID, 
				OT2102.Ana02ID, 
				OT2102.Ana03ID, 
				OT2102.Ana04ID, 
				OT2102.Ana05ID, 
				OT2102.Ana06ID, 
				OT2102.Ana07ID, 
				OT2102.Ana08ID, 
				OT2102.Ana09ID, 
				OT2102.Ana10ID, 
				OT2102.Notes,
				OT2102.Notes01,
				OT2102.Notes02,
				AT1302.Barcode,
				OT2102.ConvertedQuantity,
				OT2102.ConvertedSalePrice,
				--ISNULL(OT2102.OriginalAmountOutput,OT2102.OriginalAmount * ( 1 + ISNULL(OT2102.Markup,0)/100)) AS OriginalAmountOutput ,
				OT2102.OriginalAmount AS OriginalAmountOutput ,
				OT2102.Markup,
				--OT2102.ConvertedAmount * ( 1 + ISNULL(OT2102.Markup,0)/100) AS ConvertedAmountOutput,
				OT2102.ConvertedAmount  AS ConvertedAmountOutput,
				OT2102.ConvertedSalepriceInput,
				OT2102.Parameter01, OT2102.Parameter02, OT2102.Parameter03, OT2102.Parameter04, OT2102.Parameter05,
				OT2102.QD01 as nvarchar01, OT2102.QD02 as nvarchar02,OT2102.QD03 as nvarchar03,OT2102.QD04 as nvarchar04,OT2102.QD05 as nvarchar05,
				OT2102.QD06 as nvarchar06,OT2102.QD07 as nvarchar07,OT2102.QD08 as nvarchar08,OT2102.QD09 as nvarchar09 ,OT2102.QD10 as nvarchar10
				'
	SET @sSQL2 = '
		FROM	OT2102 WITH (NOLOCK) 
		LEFT JOIN AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (''@@@'', OT2102.DivisionID) AND AT1302.InventoryID = OT2102.InventoryID 
		INNER JOIN OT2101 WITH (NOLOCK) on OT2101.QuotationID = OT2102.QuotationID And OT2101.DivisionID = OT2102.DivisionID
		'

	IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	BEGIN
		SET @sSQL1 = @sSQL1 + ',
				O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID, 
				O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID 
			'
		SET @sSQL2 = @sSQL2 + '
		left join OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = OT2102.DivisionID AND O99.VoucherID = OT2102.QuotationID AND O99.TransactionID = OT2102.TransactionID AND O99.TableID = ''OT2102''
		'	
	END
SET @sSQL2 = @sSQL2 + '
	WHERE	OT2101.DivisionID = ''' + @DivisionID + ''' and 
			OT2101.QuotationID in  (''' + @VoucherID + ''')'

END

IF  EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WHERE XTYPE = 'V' AND NAME = 'OV2503')
	DROP VIEW OV2503

EXEC('CREATE VIEW OV2503 ---tao boi OP2502
		as ' + @sSQL + @sSQL1 + @sSQL2)

--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sSQL2


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

