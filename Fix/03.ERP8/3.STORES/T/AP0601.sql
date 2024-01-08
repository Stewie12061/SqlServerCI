IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0601]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0601]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--created by Hoang Thi Lan
--Date 17/10/2003
--Purpose: Dung cho Report Doanh so hang mua theo mat hang(chi tiet)
--Edit by: Nguyen Quoc Huy Date: 26/06/2006
--Edit by: Dang Le Bao Quynh; Date: 21/05/2008
--Purpose: Them he so quy doi cho mat hang
/********************************************
'* Edited by: [GS] [Thanh Nguyen] [29/07/2010]
'********************************************/
--- Edited by: Bao Anh	Date: 11/07/2012
--- Purpose: Lay them truong MPT doi tuong, dien giai, dieu khoan thanh toan
---- Modified on 26/10/2012 by Lê Thị Thu Hiền : Bổ sung JOIN DivisionID
---- Modified on 03/05/2013 by Lê Thị Thu Hiền : Bổ sung 10 Khoản mục Ana01ID --> Ana10ID
---- Modified on 10/09/2015 by Tiểu Mai: Bổ sung 10 tham số Parameter
---- Modified on 08/01/2016 by Tiểu Mai: Bổ sung thông tin quy cách khi có thiết lập quản lý mặt hàng theo quy cách.
---- Modified on 12/04/2017 by Tiểu Mai: Fix bug in báo cáo lỗi
---- Modified on 25/04/2017 by Hải Long: Bổ sung trường Loại Đối tượng - ObjectTypeName và Tiền VAT - VATConvertedAmount (HHP)
---- Modified on 08/05/2017 by Bảo Thy: Sửa danh mục dùng chung
---- Modified on 24/04/2018 by Bảo Anh: Bổ sung InventoryName1
---- Modified on 02/10/2020 by Nhựt Trường: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified on 03/12/2020 by Hoài Phong:  Bổ sung điều kiện DivisionID IN cho bảng AT1208.
---- Modified on 20/05/2021 by Nhựt Trường: Bổ sung điều kiện DivisionID IN cho bảng AT1004.
---- Modified on 04/01/2023 by Văn Tài	  : Bổ sung lấy AT9000.VATNo, AT9000.InvoiceCode.
---- Modified by Đức Duy on 20/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Modified on 22/12/2023 by Kiều Nga: Bổ sung lấy thêm cột VATConvertedAmount_NNT lấy giá trị từ AT9000.VATConvertedAmount.
-- <Example>
---- 
---- EXEC AP0601 'AS', 'VoucherID = ''AS''', 0, 1
----
CREATE PROCEDURE [dbo].[AP0601] 
(	
	@DivisionID AS nvarchar(50), 
	@sSQLWhere AS nvarchar(4000), 
	@Group1ID AS tinyint,	---- = 0 la theo loai mat hang.
							---  = 1 la theo tai khoan doanh so
							---  = 2 la theo doi tuong
	@Group2ID AS TINYINT
)
AS

DECLARE @sSQL AS nvarchar(MAX)
DECLARE @sSQL1 AS nvarchar(MAX)
DECLARE @sWHERE AS NVARCHAR(MAX)
SET @sWHERE = ''

IF @sSQLWhere <> ''
SET @sWHERE = ' AND ' + @sSQLWhere
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	EXEC AP0601_QC @DivisionID, @sSQLWhere, @Group1ID, @Group2ID	
END
ELSE
BEGIN
	Set @sSQL='		
			SELECT	VoucherDate,
					VoucherID,
					VoucherNo,
					' + (CASE WHEN @Group1ID = 0 then 'AT9000.InventoryID'	when @Group1ID = 1 then 'AT9000.DebitAccountID'	else 'AT9000.ObjectID' end) + ' AS Group1ID,
					' + (CASE WHEN @Group1ID = 0 then 'AT1302.InventoryName'when @Group1ID = 1 then 'AT1005.AccountName' else 'AT1202.ObjectName' end) + ' AS Group1Name,
					' + (CASE WHEN @Group2ID = 0 then 'AT9000.InventoryID'	when @Group2ID = 1 then 'AT9000.DebitAccountID'	else 'AT9000.ObjectID' end) + ' AS Group2ID,
					' + (CASE WHEN @Group2ID = 0 then 'AT1302.InventoryName'when @Group2ID = 1 then 'AT1005.AccountName' else 'AT1202.ObjectName' end) + ' AS Group2Name,
					AT9000.InventoryID,
					AT1302.InventoryName,
					AT9000.InventoryName1,
					AT1302.UnitID,
					AT1304.UnitName,
					AT1309.UnitID AS ConversionUnitID,
					AT1309.ConversionFactor,
					AT1309.Operator,
					AT9000.ObjectID,
					AT1202.ObjectName,
					AT1202.Address,
					AT9000.CurrencyID,
					AT1004.CurrencyName,
					AT9000.UnitPrice,
					AT1302.RecievedPrice,		
					DebitAccountID,
					CreditAccountID,
					Serial,
					Quantity,
					InvoiceDate,
					InvoiceNo,
					VATRate,
					OriginalAmount,
					ConvertedAmount,
					ImTaxOriginalAmount,
					ImTaxConvertedAmount,
					ExpenseOriginalAmount,
					ExpenseConvertedAmount,
					AT9000.Duedate,
					AT9000.IsStock,
					AT9000.DivisionID,
					AT1202.O01ID, AT1202.O02ID, AT1202.O03ID, AT1202.O04ID, AT1202.O05ID,
					O1.AnaName AS O01Name, O2.AnaName AS O02Name, O3.AnaName AS O03Name, O4.AnaName AS O04Name, O5.AnaName AS O05Name,
					BDescription, TDescription, AT9000.PaymentTermID, AT1208.PaymentTermName,
					AT9000.Ana01ID, AT9000.Ana02ID, AT9000.Ana03ID, AT9000.Ana04ID, AT9000.Ana05ID, 
					AT9000.Ana06ID, AT9000.Ana07ID, AT9000.Ana08ID, AT9000.Ana09ID, AT9000.Ana10ID, 
					A1.AnaName AS Ana01Name,A2.AnaName AS Ana02Name,A3.AnaName AS Ana03Name,A4.AnaName AS Ana04Name,A5.AnaName AS Ana05Name,
					A6.AnaName AS Ana06Name,A7.AnaName AS Ana07Name,A8.AnaName AS Ana08Name,A9.AnaName AS Ana09Name,A10.AnaName AS Ana10Name,
					AT9000.Parameter01, AT9000.Parameter02, AT9000.Parameter03, AT9000.Parameter04, AT9000.Parameter05, AT9000.Parameter06, AT9000.Parameter07,
					AT9000.Parameter08, AT9000.Parameter09, AT9000.Parameter10,  
					AT1201.ObjectTypeName, ROUND(ISNULL(AT1010.VATRate, 0)*AT9000.ConvertedAmount/100, 0) AS VATConvertedAmount,isnull(AT9000.VATConvertedAmount,0) as VATConvertedAmount_NNT,
					AT9000.VATNo, AT9000.InvoiceCode
	'
	set @sSQL1 = '
	FROM	AT9000 WITH (NOLOCK) 
	LEFT JOIN AT1302 WITH (NOLOCK) ON AT1302.DivisionID IN (AT9000.DivisionID,''@@@'') AND AT9000.InventoryID = AT1302.InventoryID   	
	LEFT JOIN (SELECT	DivisionID, InventoryID,Min(UnitID) AS UnitID, 
						Min(ConversionFactor) AS ConversionFactor, 
						Min(Operator) AS Operator 
			   FROM		AT1309  WITH (NOLOCK)
			   GROUP BY DivisionID, InventoryID) AT1309 
		ON	AT9000.InventoryID = AT1309.InventoryID
	LEFT JOIN AT1202 WITH (NOLOCK) ON AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT9000.ObjectID = AT1202.ObjectID
	LEFT JOIN AT1201 WITH (NOLOCK) ON AT1201.ObjectTypeID = AT1202.ObjectTypeID  	
	LEFT JOIN AT1005 WITH (NOLOCK) ON AT9000.DebitAccountID = AT1005.AccountID 
	LEFT JOIN AT1010 WITH (NOLOCK) ON AT1010.VATGroupID = AT9000.VATGroupID 
	LEFT JOIN AT1004 WITH (NOLOCK) ON AT1004.DivisionID IN (N'''+@DivisionID+''',''@@@'') AND AT1004.CurrencyID = AT9000.CurrencyID
	LEFT JOIN AT1304 WITH (NOLOCK) ON AT9000.UnitID = AT1304.UnitID
	LEFT JOIN AT1015 O1 WITH (NOLOCK) ON AT1202.O01ID = O1.AnaID AND O1.AnaTypeID = ''O01''
	LEFT JOIN AT1015 O2 WITH (NOLOCK) ON AT1202.O02ID = O2.AnaID AND O2.AnaTypeID = ''O02''
	LEFT JOIN AT1015 O3 WITH (NOLOCK) ON AT1202.O03ID = O3.AnaID AND O3.AnaTypeID = ''O03''
	LEFT JOIN AT1015 O4 WITH (NOLOCK) ON AT1202.O04ID = O4.AnaID AND O4.AnaTypeID = ''O04''
	LEFT JOIN AT1015 O5 WITH (NOLOCK) ON AT1202.O05ID = O5.AnaID AND O5.AnaTypeID = ''O05''
	LEFT JOIN AT1208 WITH (NOLOCK) ON AT9000.DivisionID = AT1208.DivisionID AND AT9000.PaymentTermID = AT1208.PaymentTermID

	LEFT JOIN AT1011 A1 WITH (NOLOCK) ON A1.AnaID = AT9000.Ana01ID  AND A1.AnaTypeID = ''A01''
	LEFT JOIN AT1011 A2 WITH (NOLOCK) ON A2.AnaID = AT9000.Ana02ID  AND A2.AnaTypeID = ''A02''
	LEFT JOIN AT1011 A3 WITH (NOLOCK) ON A3.AnaID = AT9000.Ana03ID  AND A3.AnaTypeID = ''A03''
	LEFT JOIN AT1011 A4 WITH (NOLOCK) ON A4.AnaID = AT9000.Ana04ID  AND A4.AnaTypeID = ''A04''
	LEFT JOIN AT1011 A5 WITH (NOLOCK) ON A5.AnaID = AT9000.Ana05ID  AND A5.AnaTypeID = ''A05''
	LEFT JOIN AT1011 A6 WITH (NOLOCK) ON A6.AnaID = AT9000.Ana06ID  AND A6.AnaTypeID = ''A06''
	LEFT JOIN AT1011 A7 WITH (NOLOCK) ON A7.AnaID = AT9000.Ana07ID  AND A7.AnaTypeID = ''A07''
	LEFT JOIN AT1011 A8 WITH (NOLOCK) ON A8.AnaID = AT9000.Ana08ID  AND A8.AnaTypeID = ''A08''
	LEFT JOIN AT1011 A9 WITH (NOLOCK) ON A9.AnaID = AT9000.Ana09ID  AND A9.AnaTypeID = ''A09''
	LEFT JOIN AT1011 A10 WITH (NOLOCK) ON A10.AnaID = AT9000.Ana10ID AND A10.AnaTypeID = ''A10''
	
	WHERE	AT9000.DivisionID=N'''+@DivisionID+''' 
			AND AT9000.TransactionTypeID in (N''T03'', N''T30'')
			'
	


--PRINT @sSQL
--PRINT @sSQL1
--PRINT @sWHERE

IF NOT EXISTS (SELECT TOP 1 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE NAME = 'AV0601' AND XTYPE ='V')
	EXEC ('CREATE VIEW AV0601 -- AP0601
	 AS '+@sSQL + @sSQL1 +@sWHERE)
ELSE
	EXEC ('ALTER VIEW AV0601 -- AP0601
	AS '+@sSQL + @sSQL1 +@sWHERE)

END	

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
