IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP3020_PL]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP3020_PL]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Dung cho Report AR3014(report ban hang) - Phúc Long
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Created by Kim Thư on 12/09/2018
---- Edit by Kim Thư on 21/01/2019 : Thêm thông tin Barcode của mặt hàng trên report in hóa đơn
---- Edit by My Tuyen on 14/08/2019: Them thong tin Orders trong AT9000 tren report in hoa don
---- Edit by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
---- Example : 
/*
exec sp_executesql N'
      AP3020_PL ''PL'', @VoucherID, @IsParticularBill
    ',N'@VoucherID nvarchar(38),@ConnID nvarchar(2),@IsParticularBill bit',@VoucherID=N'AV2f119439-765d-4532-a2ca-6bba4352cb2d',@IsParticularBill=1
*/
CREATE PROCEDURE AP3020_PL
( 
		  @DivisionID NVARCHAR(50),
          @VoucherID NVARCHAR(50) 
 )
AS
DECLARE @sSql NVARCHAR(MAX),  
  @sSql1 NVARCHAR(MAX),  
  @CurrencyID VARCHAR(10),  
  @ObjectID NVARCHAR(50),  
  @VoucherDate DATETIME,  
  @sSQL4 NVARCHAR(100) ='',  
  @TransactionTypeID Varchar(5) = '' 

 
SELECT TOP 1 @TransactionTypeID =  TransactionTypeID,@ObjectID = ObjectID, @VoucherDate = VoucherDate  
FROM AT9000  
WHERE VoucherID = @VoucherID  
ORDER BY TransactionTypeID  
  
SET @ObjectID = ISNULL(@ObjectID, '')  
SET @VoucherDate = ISNULL(@VoucherDate, GETDATE())  
  
 IF @TransactionTypeID = 'T06' SET  @sSQL4 = 'AT9000.TransactionTypeID in (''T06'')'  
 ELSE SET @sSQL4 = 'AT9000.TransactionTypeID in (''T04'',''T40'',''T64'')'  
  
 
IF (@TransactionTypeID = 'T06')  
BEGIN  
 SET @CurrencyID =  'VND'
END  
ELSE   
BEGIN  
 SELECT @CurrencyID = currencyID
 FROM AT9000  
 WHERE VoucherID = @VoucherID AND TransactionTypeID IN ('T04','T40','T64') AND DivisionID = @DivisionID  
END  
  
SET @CurrencyID = ISNULL(@CurrencyID,'VND')  

SET @sSql = '  
SELECT AT9000.Ana01ID, AT9000.Orders,AT9000.Ana02ID, AT9000.Ana03ID, AT9000.Ana04ID, AT9000.Ana05ID,  
 AT9000.Ana06ID, AT9000.Ana07ID, AT9000.Ana08ID, AT9000.Ana09ID, AT9000.Ana10ID,  
 A1.AnaName AS AnaName1, A2.AnaName AS AnaName2, A3.AnaName AS AnaName3, A4.AnaName AS AnaName4,  
 A5.AnaName AS AnaName5, A6.AnaName AS AnaName6, A7.AnaName AS AnaName7, A8.AnaName AS AnaName8,  
 A9.AnaName AS AnaName9, A10.AnaName AS AnaName10, 
 AT9000.InventoryID,   
 AT9000.UnitID, AT1304.UnitName,  
 AT9000.UnitPrice, AT9000.Quantity, AT9000.OriginalAmount, Cast(isnull(AT9000.DiscountRate,0) AS Decimal(28,8)) AS DiscountRate,  
 AT9000.DiscountAmount, AT9000.ConvertedAmount,  
 AT9000.Serial, AT9000.InvoiceNo, AT9000.InvoiceDate, AT9000.ObjectID, AT9000.Parameter01, AT9000.Parameter02, AT9000.Parameter03, AT9000.Parameter04, 
 AT9000.Parameter05, AT9000.Parameter06, AT9000.Parameter07, AT9000.Parameter08, AT9000.Parameter09, AT9000.Parameter10, 
 AT9000.VoucherNo, AT9000.VoucherDate, AT9000.BDescription,  AT1302.RecievedPrice,

 CASE WHEN isnull(AT9000.InventoryName1,'''') ='''' THEN AT1302.InventoryName ELSE AT9000.InventoryName1 end AS InventoryName ,  
  A.BankName, A.BankAccountNo,
 (CASE WHEN Isnull(AT9000.VATObjectAddress, '''') <> '''' THEN AT9000.VATObjectAddress ELSE 
		CASE WHEN isnull(AT9000.VATObjectID,'''') ='''' THEN  A.Address ELSE B.Address end  End ) AS ObAddress,
 AT1010.VATRate,
 (CASE WHEN B.IsUpdateName =1 THEN AT9000.VATObjectName ELSE 
	CASE WHEN isnull(AT9000.VATObjectID,'''') <>''''  THEN B.ObjectName
		ELSE A.ObjectName  End End) AS ObjectName,
(CASE WHEN   B.IsUpdateName =1 THEN  AT9000.VATNo ELSE 
	CASE WHEN isnull(AT9000.VATObjectID,'''') <>''''  THEN B.VATNo
		ELSE A.VATNo  End End) AS VATNo,
 AT1302.IsDiscount, 
 CASE WHEN AT9000.TransactiontypeID = ''T14'' THEN AT9000.TDescription ELSE AT9000.VDescription END as VDescription,  
 OriginalAmountTax = (CASE WHEN (SELECT Sum(isnull(OriginalAmount,0)) 
			FROM AT9000 T9 WITH (NOLOCK) 
			WHERE TransactiontypeID in (''T14'',''T40'')  AND VoucherID = AT9000.VoucherID AND DivisionID = ''' + @DivisionID + ''') is null
			then 0 ELSE (SELECT Sum(isnull(OriginalAmount,0)) 
			FROM AT9000 T9 WITH (NOLOCK)  
			WHERE TransactiontypeID in (''T14'',''T40'')  AND VoucherID = AT9000.VoucherID  AND DivisionID = ''' + @DivisionID + ''') end),
AT1302.Image01ID,
AT1302.Image02ID,
(CASE WHEN AT1302.Image01ID IS NULL THEN 0 ELSE 1 END ) AS IsImage01,
AT1302.Barcode
'

SET @sSql1 = '  
FROM AT9000  WITH (NOLOCK)   
LEFT JOIN AT1011 A1 WITH (NOLOCK) on	( A1.AnaID = AT9000.Ana01ID AND  A1.AnaTypeID = ''A01'' AND A1.DivisionID = AT9000.DivisionID)
LEFT JOIN AT1011 A2 WITH (NOLOCK) on	( A2.AnaID = AT9000.Ana02ID AND  A2.AnaTypeID = ''A02'' AND A2.DivisionID = AT9000.DivisionID)
LEFT JOIN AT1011 A3 WITH (NOLOCK) on	( A3.AnaID = AT9000.Ana03ID AND  A3.AnaTypeID = ''A03'' AND A3.DivisionID = AT9000.DivisionID)
LEFT JOIN AT1011 A4 WITH (NOLOCK) on	( A4.AnaID = AT9000.Ana04ID AND  A4.AnaTypeID = ''A04'' AND A4.DivisionID = AT9000.DivisionID)
LEFT JOIN AT1011 A5 WITH (NOLOCK) on	( A5.AnaID = AT9000.Ana05ID AND  A5.AnaTypeID = ''A05'' AND A5.DivisionID = AT9000.DivisionID)
LEFT JOIN AT1011 A6 WITH (NOLOCK) on	( A6.AnaID = AT9000.Ana06ID AND  A6.AnaTypeID = ''A06'' AND A6.DivisionID = AT9000.DivisionID)
LEFT JOIN AT1011 A7 WITH (NOLOCK) on	( A7.AnaID = AT9000.Ana07ID AND  A7.AnaTypeID = ''A07'' AND A7.DivisionID = AT9000.DivisionID)
LEFT JOIN AT1011 A8 WITH (NOLOCK) on	( A8.AnaID = AT9000.Ana08ID AND  A8.AnaTypeID = ''A08'' AND A8.DivisionID = AT9000.DivisionID)
LEFT JOIN AT1011 A9 WITH (NOLOCK) on	( A9.AnaID = AT9000.Ana09ID AND  A9.AnaTypeID = ''A09'' AND A9.DivisionID = AT9000.DivisionID)
LEFT JOIN AT1011 A10 WITH (NOLOCK) on	( A10.AnaID = AT9000.Ana10ID AND  A10.AnaTypeID = ''A10'' AND A10.DivisionID = AT9000.DivisionID)
LEFT JOIN AT1302 WITH (NOLOCK) ON (AT1302.InventoryID = AT9000.InventoryID AND AT1302.DivisionID IN (AT9000.DivisionID,''@@@''))
LEFT JOIN AT1304 ON (AT1304.UnitID = AT9000.UnitID AND AT1304.DivisionID = AT9000.DivisionID)
LEFT JOIN AT1202 A WITH (NOLOCK) ON (A.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND A.ObjectID = AT9000.ObjectID)
LEFT JOIN AT1202 B WITH (NOLOCK) ON (B.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND B.ObjectID = AT9000.VATObjectID)
LEFT JOIN AT1010 WITH (NOLOCK) ON (AT1010.VATGroupID = AT9000.VATGroupID AND AT1010.DivisionID = AT9000.DivisionID)

WHERE  AT9000.DivisionID = ''' + @DivisionID + ''' AND AT9000.VoucherID ='''+@VoucherID+''' AND   
        '+@sSQL4+' 

'

exec (@sSql+@sSQL1)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
