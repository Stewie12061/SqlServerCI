IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WP0133_AG]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WP0133_AG]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Create by Tieu Mai on 16/03/2017
---- Purpose: Load chi tiet nhap xuat ton tai man hinh WF0133 (Customize cho ANGEL - 57)
---- Modified by Tiểu Mai on 22/05/2017: Bổ sung Indexs để sắp xếp chứng từ
---- Modified by Nhật Thanh on 01/04/2022: Bổ sung điều kiện divisionID dùng chung
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

-- <Example>

----
-- exec WP0133_AG @DivisionID=N'ANG',@WareHouseID=N'%',@FromInventoryID=N'TNRBSW500',@ToInventoryID=N'TNRBSW500',@FromMonth=1,@FromYear=2017,@ToMonth=1,@ToYear=2017,@FromDate='2017-01-11 00:00:00',@ToDate='2017-01-11 00:00:00',@IsDate=0,@IsInner=0, @IsAll = 1


CREATE PROCEDURE [dbo].[WP0133_AG]
       @DivisionID nvarchar(50) ,
       @WareHouseID AS NVARCHAR(50) ,
       @FromInventoryID AS nvarchar(50) ,
       @ToInventoryID AS nvarchar(50) ,
       @FromMonth AS int ,
       @FromYear AS int ,
       @ToMonth AS int ,
       @ToYear AS int ,
       @FromDate AS datetime ,
       @ToDate AS datetime ,
       @IsDate AS tinyint ,
       @IsInner AS tinyint,
	   @IsAll AS tinyint
AS

DECLARE
		@sSQlSelect AS nvarchar(4000) ,
		@sSQlFrom AS nvarchar(4000) ,
		@sSQlWhere AS nvarchar(4000) ,
		@sSQlUnionSelect AS nvarchar(4000) ,
		@sSQlUnionFrom AS nvarchar(4000) ,
		@sSQlUnionWhere AS nvarchar(4000) ,
		@sSQlSelect1 AS nvarchar(4000) ,
		@sSQlFrom1 AS nvarchar(4000) ,
		@sSQlWhere1 AS nvarchar(4000) ,
		@WareHouseName AS nvarchar(4000) ,
		@WareHouseName1 AS nvarchar(4000) ,
		@WareHouseID2 AS nvarchar(4000) ,
		@WareHouseID1 AS nvarchar(4000) ,
		@KindVoucherListIm AS nvarchar(4000) ,
		@KindVoucherListEx1 AS nvarchar(4000) ,
		@KindVoucherListEx2 AS nvarchar(4000),
		@FromMonthYearText NVARCHAR(20), 
		@ToMonthYearText NVARCHAR(20), 
		@FromDateText NVARCHAR(20), 
		@ToDateText NVARCHAR(20)
    
SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'


EXEC AP7015_AG @DivisionID , @WareHouseID , @FromInventoryID , @ToInventoryID , @FromMonth , @FromYear , @ToMonth , @ToYear , @FromDate , @ToDate , @IsDate, @IsAll


IF @IsInner = 0
	BEGIN
			SET @KindVoucherListEx1 = '(2,4,8,10,14,20) '
			SET @KindVoucherListEx2 = '(2,4,8,10,14,20) '
			SET @KindVoucherListIm = '(1,5,7,9,15,17) '
	END
ELSE
	BEGIN
			SET @KindVoucherListEx1 = '(2,4,3,8,10,14,20) '
			SET @KindVoucherListEx2 = '(2,4,8,10,14,20) '
			SET @KindVoucherListIm = '(1,3,5,7,9,15,17) '
	END

IF @IsAll = 1
	BEGIN
			SET @WareHouseID = '%'
			SET @WareHouseID2 = '''%'''
			SET @WareHouseID1 = '''%'''
			SET @WareHouseName = 'WFML000110'

	END
ELSE
	BEGIN
			SET @WareHouseID2 = ' AT2006.WareHouseID '
			SET @WareHouseID1 = ' CASE WHEN KindVoucherID = 3 then AT2006.WareHouseID2 else AT2006.WareHouseID end '
			SET @WareHouseName = +'"' + @WareHouseName1 + '"'

	END

IF @IsDate = 0
	BEGIN
			SET @sSQlSelect = '--- Phan Nhap kho
			SELECT 	' + @WareHouseID2 + ' AS WareHouseID,
					N''' + isnull(@WareHouseName,'') + ''' AS WareHouseName, 
					AT2007.VoucherID,
					AT2006.TranMonth,
					AT2006.TranYear,
					AT2006.TableID,
					AT2006.BatchID,
					AT2007.TransactionID,
					AT2007.Orders,
					VoucherDate,
					VoucherNo,
					KindVoucherID,	
					VoucherDate AS ImVoucherDate,
					VoucherNo AS ImVoucherNo,		
					SourceNo AS ImSourceNo,
					LimitDate AS ImLimitDate,	
 					AT2006.WareHouseID AS ImWareHouseID,		
					AT2006.RefNo01 AS ImRefNo01 , AT2006.RefNo02 AS ImRefNo02 , 
					AT2007.ActualQuantity AS ImQuantity,
					AT2007.UnitPrice AS ImUnitPrice ,
					Isnull(AT2007.ConvertedAmount, AT2007.OriginalAmount) AS ImConvertedAmount,
					AT2007.OriginalAmount AS ImOriginalAmount,
					isnull(AT2007.ConversionFactor ,1)*ActualQuantity AS ImConvertedQuantity,
					Null AS ExVoucherDate,
					Null AS ExVoucherNo,		
					Null AS ExSourceNo,
					Null AS ExLimitDate,	
 					Null AS ExWareHouseID,		
					Null AS ExRefNo01 , Null AS ExRefNo02 , 
					0 AS ExQuantity,
					Null AS ExUnitPrice ,
					0 AS ExConvertedAmount,
					0 AS ExOriginalAmount,
					0 AS ExConvertedQuantity,
					VoucherTypeID,
					AT2006.Description,
					AT2007.Notes,
					AT2007.InventoryID,	
					AT1302.InventoryName,
					AT2007.UnitID,		
					isnull(AT2007.ConversionFactor ,1) AS ConversionFactor,
					isnull(AV7015.BeginQuantity,0) AS BeginQuantity,
					isnull(AV7015.BeginAmount,0) AS BeginAmount,
					(CASE WHEN KindVoucherID = 7 then 3 else 1 end) AS ImExOrders,
					AT2007.DebitAccountID, AT2007.CreditAccountID,
					At2006.ObjectID,
					AT1202.ObjectName,
					AT1302.Notes01,
					AT1302.Notes02,
					AT1302.Notes03, AT2007.DivisionID, AT2007.ConvertedUnitID,
					AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, AT2007.Ana06ID, AT2007.Ana07ID, AT2007.Ana08ID, AT2007.Ana09ID, AT2007.Ana10ID ,
					(Select Distinct InvoiceNo from AT9000 WITH (NOLOCK) Where VoucherID = AT2007.VoucherID and TransactionID = AT2007.TransactionID and Isnull(InvoiceNo,'''')<>'''') as InvoiceNo,
					A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
					A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name,
					AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
					case	when AT2006.KindVoucherID IN (1, 5, 7, 9 ,15, 17) THEN 1
									WHEN AT2006.KindVoucherID = 3 THEN 2
									ELSE 3 end as Indexs  '

		SET @sSQlFrom = ' 
			FROM AT1302 WITH (NOLOCK)	 	
			INNER JOIN AT2007 WITH (NOLOCK) on AT1302.InventoryID = AT2007.InventoryID AND AT1302.DivisionID in (''@@@'',AT2007.DivisionID)
			INNER JOIN AT2006 WITH (NOLOCK) on AT2006.VoucherID = AT2007.VoucherID  AND AT2006.DivisionID = AT2007.DivisionID
			LEFT JOIN AV7015_AG AV7015 on AV7015.InventoryID = AT2007.InventoryID AND AV7015.DivisionID = AT2007.DivisionID
			INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID in (''@@@'','''+@DivisionID+''') AND AT1303.WareHouseID = AT2006.WareHouseID
			LEFT  JOIN AT1202 WITH (NOLOCK) on AT1202.ObjectID = AT2006.ObjectID  AND AT1202.DivisionID in (''@@@'',AT2007.DivisionID)
			LEFT JOIN AT1011 AS A01 WITH (NOLOCK) ON A01.DivisionID = AT2007.DivisionID AND A01.AnaID = AT2007.Ana01ID AND A01.AnaTypeID = ''A01''
			LEFT JOIN AT1011 AS A02 WITH (NOLOCK) ON A02.DivisionID = AT2007.DivisionID AND A02.AnaID = AT2007.Ana02ID AND A02.AnaTypeID = ''A02''
			LEFT JOIN AT1011 AS A03 WITH (NOLOCK) ON A03.DivisionID = AT2007.DivisionID AND A03.AnaID = AT2007.Ana03ID AND A03.AnaTypeID = ''A03''
			LEFT JOIN AT1011 AS A04 WITH (NOLOCK) ON A04.DivisionID = AT2007.DivisionID AND A04.AnaID = AT2007.Ana04ID AND A04.AnaTypeID = ''A04''
			LEFT JOIN AT1011 AS A05 WITH (NOLOCK) ON A05.DivisionID = AT2007.DivisionID AND A05.AnaID = AT2007.Ana05ID AND A05.AnaTypeID = ''A05''
			LEFT JOIN AT1011 AS A06 WITH (NOLOCK) ON A06.DivisionID = AT2007.DivisionID AND A06.AnaID = AT2007.Ana06ID AND A06.AnaTypeID = ''A06''
			LEFT JOIN AT1011 AS A07 WITH (NOLOCK) ON A07.DivisionID = AT2007.DivisionID AND A07.AnaID = AT2007.Ana07ID AND A07.AnaTypeID = ''A07''
			LEFT JOIN AT1011 AS A08 WITH (NOLOCK) ON A08.DivisionID = AT2007.DivisionID AND A08.AnaID = AT2007.Ana08ID AND A08.AnaTypeID = ''A08''
			LEFT JOIN AT1011 AS A09 WITH (NOLOCK) ON A09.DivisionID = AT2007.DivisionID AND A09.AnaID = AT2007.Ana09ID AND A09.AnaTypeID = ''A09''
			LEFT JOIN AT1011 AS A10 WITH (NOLOCK) ON A10.DivisionID = AT2007.DivisionID AND A10.AnaID = AT2007.Ana10ID AND A10.AnaTypeID = ''A10''
			'
			
		SET @sSQlWhere = ' 
			WHERE	AT2007.DivisionID =N''' + @DivisionID + ''' ' +
					(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) + ' AND
					(Isnull(AT2007.TranMonth,AT2006.TranMonth) + 100*Isnull(AT2007.TranYear,AT2006.TranYear) between '+@FromMonthYearText+' AND  '+@ToMonthYearText+' )  AND
					KindVoucherID in ' + @KindVoucherListIm + ' AND
					(AT2007.InventoryID between N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') AND
					AT2006.WareHouseID '+CASE WHEN ISNULL(@WareHouseID,'%') =  '%' THEN ' LIKE N''%'' ' ELSE ' = '''+@WareHouseID+''' ' END 
			--PRINT @sSQlWhere	

		SET @sSQlUnionSelect = N' 
		UNION
	--- Phan Xuat kho
	SELECT 	' + @WareHouseID1 + ' AS WareHouseID,
			N''' + isnull(@WareHouseName,'') + ''' AS WareHouseName, 
			AT2007.VoucherID,
			AT2006.TranMonth,
			AT2006.TranYear,
			AT2006.TableID,
			AT2006.BatchID,
			AT2007.TransactionID,
			AT2007.Orders,
			VoucherDate,
			VoucherNo,	
			KindVoucherID,
			Null AS ImVoucherDate,
			Null AS ImVoucherNo,		
			Null AS ImSourceNo,
			Null AS ImLimitDate,	
 			Null AS ExWareHouseID,	
			Null AS ImRefNo01 , Null  AS ImRefNo02 , 
			0 AS ImQuantity,
			Null AS ImUnitPrice ,
			0 AS ImConvertedAmount,
			0 AS ImOriginalAmount,
			0 AS ImConvertedQuantity,
			VoucherDate AS ExVoucherDate,
			VoucherNo AS ExVoucherNo,		
			SourceNo AS ExSourceNo,
			LimitDate AS ExLimitDate,	
 			(CASE WHEN KindVoucherID = 3 then WareHouseID2 else AT2006.WareHouseID end) AS ExWareHouseID,	
			AT2006.RefNo01 AS ExRefNo01 , AT2006.RefNo02 AS ExRefNo02 , 
			AT2007.ActualQuantity AS ExQuantity,
			AT2007.UnitPrice AS ExUnitPrice ,
			AT2007.ConvertedAmount AS ExConvertedAmount,
			AT2007.OriginalAmount AS ExOriginalAmount,
			isnull(AT2007.ConversionFactor ,1)*ActualQuantity AS ExConvertedQuantity,
			VoucherTypeID,
			AT2006.Description,
			AT2007.Notes,
			AT2007.InventoryID,	
			AT1302.InventoryName,
			AT2007.UnitID,		
			isnull(AT2007.ConversionFactor ,1) AS ConversionFactor,
			isnull(AV7015.BeginQuantity,0) AS BeginQuantity,
			isnull(AV7015.BeginAmount,0) AS BeginAmount,
			2 AS ImExOrders,
			AT2007.DebitAccountID, AT2007.CreditAccountID,
			At2006.ObjectID,
			AT1202.ObjectName,
			AT1302.Notes01,
			AT1302.Notes02,
			AT1302.Notes03, AT2007.DivisionID,  AT2007.ConvertedUnitID,
			AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, AT2007.Ana06ID, AT2007.Ana07ID, AT2007.Ana08ID, AT2007.Ana09ID, AT2007.Ana10ID,
			(Select Distinct InvoiceNo from AT9000 WITH (NOLOCK) Where VoucherID = AT2007.VoucherID and TransactionID = AT2007.TransactionID and Isnull(InvoiceNo,'''')<>'''') as InvoiceNo,
			A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
			A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name,
			AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
			case	when AT2006.KindVoucherID IN (1, 5, 7, 9 ,15, 17) THEN 1
									WHEN AT2006.KindVoucherID = 3 THEN 2
									ELSE 3 end as Indexs   '
	SET @sSQlUnionFrom = ' 
		FROM AT1302 WITH (NOLOCK) 	
		LEFT JOIN AT2007 WITH (NOLOCK) on AT1302.InventoryID = AT2007.InventoryID AND AT1302.DivisionID in (''@@@'',AT2007.DivisionID)
		INNER JOIN AT2006 WITH (NOLOCK) on At2006.VoucherID = AT2007.VoucherID AND At2006.DivisionID = AT2007.DivisionID
		LEFT JOIN AV7015_AG AV7015 on AV7015.InventoryID = AT2007.InventoryID	AND AV7015.DivisionID = AT2007.DivisionID
		INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID in (''@@@'','''+@DivisionID+''') AND AT1303.WareHouseID = ( CASE WHEN KindVoucherID = 3 Then AT2006.WareHouseID2  Else AT2006.WareHouseID end)
		LEFT JOIN AT1202 on AT1202.ObjectID = AT2006.ObjectID  AND AT1202.DivisionID in (''@@@'',AT2007.DivisionID)
		LEFT JOIN AT1011 AS A01 WITH (NOLOCK) ON A01.DivisionID = AT2007.DivisionID AND A01.AnaID = AT2007.Ana01ID AND A01.AnaTypeID = ''A01''
		LEFT JOIN AT1011 AS A02 WITH (NOLOCK) ON A02.DivisionID = AT2007.DivisionID AND A02.AnaID = AT2007.Ana02ID AND A02.AnaTypeID = ''A02''
		LEFT JOIN AT1011 AS A03 WITH (NOLOCK) ON A03.DivisionID = AT2007.DivisionID AND A03.AnaID = AT2007.Ana03ID AND A03.AnaTypeID = ''A03''
		LEFT JOIN AT1011 AS A04 WITH (NOLOCK) ON A04.DivisionID = AT2007.DivisionID AND A04.AnaID = AT2007.Ana04ID AND A04.AnaTypeID = ''A04''
		LEFT JOIN AT1011 AS A05 WITH (NOLOCK) ON A05.DivisionID = AT2007.DivisionID AND A05.AnaID = AT2007.Ana05ID AND A05.AnaTypeID = ''A05''
		LEFT JOIN AT1011 AS A06 WITH (NOLOCK) ON A06.DivisionID = AT2007.DivisionID AND A06.AnaID = AT2007.Ana06ID AND A06.AnaTypeID = ''A06''
		LEFT JOIN AT1011 AS A07 WITH (NOLOCK) ON A07.DivisionID = AT2007.DivisionID AND A07.AnaID = AT2007.Ana07ID AND A07.AnaTypeID = ''A07''
		LEFT JOIN AT1011 AS A08 WITH (NOLOCK) ON A08.DivisionID = AT2007.DivisionID AND A08.AnaID = AT2007.Ana08ID AND A08.AnaTypeID = ''A08''
		LEFT JOIN AT1011 AS A09 WITH (NOLOCK) ON A09.DivisionID = AT2007.DivisionID AND A09.AnaID = AT2007.Ana09ID AND A09.AnaTypeID = ''A09''
		LEFT JOIN AT1011 AS A10 WITH (NOLOCK) ON A10.DivisionID = AT2007.DivisionID AND A10.AnaID = AT2007.Ana10ID AND A10.AnaTypeID = ''A10''
		'
	SET @sSQlUnionWhere = ' 
	WHERE	AT2007.DivisionID = N''' + @DivisionID + ''' ' +
				(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) + ' AND
			AT2006.KindVoucherID in ' + @KindVoucherListEx1 + ' AND
			(Isnull(AT2007.TranMonth,AT2006.TranMonth) + 100*Isnull(AT2007.TranYear,AT2006.TranYear) between '+@FromMonthYearText+' AND  '+@ToMonthYearText+' )  AND	
			(AT2007.InventoryID between N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') AND
			( (KindVoucherID in ' + @KindVoucherListEx2 + ' AND AT2006.WareHouseID '+CASE WHEN ISNULL(@WareHouseID,'%') =  '%' THEN ' LIKE N''%'' ' ELSE ' = '''+@WareHouseID+''' ' END +' )
			or  ( KindVoucherID = 3 AND WareHouseID2 '+CASE WHEN ISNULL(@WareHouseID,'%') =  '%' THEN ' LIKE N''%'' ' ELSE ' = '''+@WareHouseID+''' ' END +')) '
END
ELSE
BEGIN
	SET @sSQlSelect = N'
--- Phan Nhap kho
SELECT 	' + @WareHouseID2 + ' AS WareHouseID,
		N''' + isnull(@WareHouseName,'') + ''' AS WareHouseName, 
		AT2007.VoucherID,
		AT2006.TranMonth,
		AT2006.TranYear,
		AT2006.TableID,
		AT2006.BatchID,
		AT2007.TransactionID,
		AT2007.Orders,
		VoucherDate,
		VoucherNo,	
		KindVoucherID,
		VoucherDate AS ImVoucherDate,
		VoucherNo AS ImVoucherNo,		
		SourceNo AS ImSourceNo,
		LimitDate AS ImLimitDate,	
 		AT2006.WareHouseID AS ImWareHouseID,		
		AT2006.RefNo01 AS ImRefNo01 , AT2006.RefNo02 AS ImRefNo02 , 
		AT2007.ActualQuantity AS ImQuantity,
		AT2007.UnitPrice AS ImUnitPrice ,
		AT2007.ConvertedAmount AS ImConvertedAmount,
		AT2007.OriginalAmount AS ImOriginalAmount,
		isnull(AT2007.ConversionFactor ,1)*ActualQuantity AS ImConvertedQuantity,
		Null AS ExVoucherDate,
		Null AS ExVoucherNo,		
		Null AS ExSourceNo,
		Null AS ExLimitDate,	
 		Null AS ExWareHouseID,		
		Null AS ExRefNo01 , Null AS ExRefNo02 , 
		0 AS ExQuantity,
		Null AS ExUnitPrice ,
		0 AS ExConvertedAmount,
		0 AS ExOriginalAmount,
		0 AS ExConvertedQuantity,
		VoucherTypeID,
		AT2006.Description,
		AT2007.Notes,
		AT2007.InventoryID,	
		AT1302.InventoryName,
		AT2007.UnitID,		
		isnull(AT2007.ConversionFactor ,1) AS ConversionFactor,
		isnull(AV7015.BeginQuantity,0) AS BeginQuantity,
		isnull(AV7015.BeginAmount,0) AS BeginAmount,
		(CASE WHEN KindVoucherID = 7 then 3 else 1 end) AS ImExOrders,
		AT2007.DebitAccountID, AT2007.CreditAccountID,
		At2006.ObjectID,
		AT1202.ObjectName,
		AT1302.Notes01,
		AT1302.Notes02,
		AT1302.Notes03, AT2007.DivisionID, AT2007.ConvertedUnitID,
		AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, AT2007.Ana06ID, AT2007.Ana07ID, AT2007.Ana08ID, AT2007.Ana09ID, AT2007.Ana10ID,
		(Select Distinct InvoiceNo from AT9000 WITH (NOLOCK) Where VoucherID = AT2007.VoucherID and TransactionID = AT2007.TransactionID and Isnull(InvoiceNo,'''')<>'''') as InvoiceNo,
		A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
		A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name,
		AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
		case	when AT2006.KindVoucherID IN (1, 5, 7, 9 ,15, 17) THEN 1
									WHEN AT2006.KindVoucherID = 3 THEN 2
									ELSE 3 end as Indexs  '
				
SET @sSQlFrom = ' 
	FROM AT1302 WITH (NOLOCK)	
	LEFT JOIN AT2007  WITH (NOLOCK) on AT1302.InventoryID = AT2007.InventoryID AND AT1302.DivisionID in (''@@@'',AT2007.DivisionID)
	INNER JOIN AT2006  WITH (NOLOCK)on At2006.VoucherID = AT2007.VoucherID AND At2006.DivisionID = AT2007.DivisionID
	LEFT JOIN AV7015_AG AV7015 on AV7015.InventoryID = AT2007.InventoryID AND AV7015.DivisionID = AT2007.DivisionID
	INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID in (''@@@'','''+@DivisionID+''') AND AT1303.WareHouseID = AT2006.WareHouseID
	LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.ObjectID = AT2006.ObjectID  AND AT1202.DivisionID in (''@@@'',AT2007.DivisionID)
	LEFT JOIN AT1011 AS A01 WITH (NOLOCK) ON A01.DivisionID = AT2007.DivisionID AND A01.AnaID = AT2007.Ana01ID AND A01.AnaTypeID = ''A01''
	LEFT JOIN AT1011 AS A02 WITH (NOLOCK) ON A02.DivisionID = AT2007.DivisionID AND A02.AnaID = AT2007.Ana02ID AND A02.AnaTypeID = ''A02''
	LEFT JOIN AT1011 AS A03 WITH (NOLOCK) ON A03.DivisionID = AT2007.DivisionID AND A03.AnaID = AT2007.Ana03ID AND A03.AnaTypeID = ''A03''
	LEFT JOIN AT1011 AS A04 WITH (NOLOCK) ON A04.DivisionID = AT2007.DivisionID AND A04.AnaID = AT2007.Ana04ID AND A04.AnaTypeID = ''A04''
	LEFT JOIN AT1011 AS A05 WITH (NOLOCK) ON A05.DivisionID = AT2007.DivisionID AND A05.AnaID = AT2007.Ana05ID AND A05.AnaTypeID = ''A05''
	LEFT JOIN AT1011 AS A06 WITH (NOLOCK) ON A06.DivisionID = AT2007.DivisionID AND A06.AnaID = AT2007.Ana06ID AND A06.AnaTypeID = ''A06''
	LEFT JOIN AT1011 AS A07 WITH (NOLOCK) ON A07.DivisionID = AT2007.DivisionID AND A07.AnaID = AT2007.Ana07ID AND A07.AnaTypeID = ''A07''
	LEFT JOIN AT1011 AS A08 WITH (NOLOCK) ON A08.DivisionID = AT2007.DivisionID AND A08.AnaID = AT2007.Ana08ID AND A08.AnaTypeID = ''A08''
	LEFT JOIN AT1011 AS A09 WITH (NOLOCK) ON A09.DivisionID = AT2007.DivisionID AND A09.AnaID = AT2007.Ana09ID AND A09.AnaTypeID = ''A09''
	LEFT JOIN AT1011 AS A10 WITH (NOLOCK) ON A10.DivisionID = AT2007.DivisionID AND A10.AnaID = AT2007.Ana10ID AND A10.AnaTypeID = ''A10''	
	'
				
SET @sSQlWhere = ' 
	WHERE	AT2007.DivisionID = N''' + @DivisionID + ''' ' +
			(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) + ' AND
			(CONVERT(DATETIME, CONVERT(VARCHAR(10), VoucherDate, 101), 101) Between ''' +@FromDateText + ''' AND ''' + @ToDateText + ''' ) AND
			KindVoucherID in ' + @KindVoucherListIm + ' AND
			(AT2007.InventoryID between N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') AND
			AT2006.WareHouseID '+CASE WHEN ISNULL(@WareHouseID,'%') =  '%' THEN ' LIKE N''%'' ' ELSE ' = '''+@WareHouseID+''' ' END 

SET @sSQlUnionSelect = ' 
	UNION
--- Phan Xuat kho
	SELECT  ' + @WareHouseID1 + ' AS WareHouseID,
			N''' + isnull(@WareHouseName,'') + ''' AS WareHouseName, 
			AT2007.VoucherID,
			AT2006.TranMonth,
			AT2006.TranYear,
			AT2006.TableID,
			AT2006.BatchID,
			AT2007.TransactionID,
			AT2007.Orders,
			VoucherDate,
			VoucherNo,	
			KindVoucherID,
			Null AS ImVoucherDate,
			Null AS ImVoucherNo,		
			Null AS ImSourceNo,
			Null AS ImLimitDate,	
 			Null AS ExWareHouseID,	
			Null AS ImRefNo01 , Null AS ImRefNo02 , 
			0 AS ImQuantity,
			Null AS ImUnitPrice ,
			0 AS ImConvertedAmount,
			0 AS ImOriginalAmount,
			0 AS ImConvertedQuantity,
			VoucherDate AS ExVoucherDate,
			VoucherNo AS ExVoucherNo,		
			SourceNo AS ExSourceNo,
			LimitDate AS ExLimitDate,	
 			(CASE WHEN KindVoucherID = 3 then WareHouseID2 else AT2006.WareHouseID end) AS ExWareHouseID,	
			AT2006.RefNo01 AS ExRefNo01 , AT2006.RefNo02 AS ExRefNo02 , 
			AT2007.ActualQuantity AS ExQuantity,
			AT2007.UnitPrice AS ExUnitPrice ,
			AT2007.ConvertedAmount AS ExConvertedAmount,
			AT2007.OriginalAmount AS ExOriginalAmount,
			isnull(AT2007.ConversionFactor ,1)*ActualQuantity AS ExConvertedQuantity,
			VoucherTypeID,
			AT2006.Description,
			AT2007.Notes,
			AT2007.InventoryID,	
			AT1302.InventoryName,
			AT2007.UnitID,		 							isnull(AT2007.ConversionFactor ,1) AS ConversionFactor,
			isnull(AV7015.BeginQuantity,0) AS BeginQuantity,
			isnull(AV7015.BeginAmount,0) AS BeginAmount,
			2 AS ImExOrders,
			AT2007.DebitAccountID, AT2007.CreditAccountID,
			At2006.ObjectID,
			AT1202.ObjectName,
			AT1302.Notes01,
			AT1302.Notes02,
			AT1302.Notes03,AT2007.DivisionID, AT2007.ConvertedUnitID,
			AT2007.Ana01ID, AT2007.Ana02ID, AT2007.Ana03ID, AT2007.Ana04ID, AT2007.Ana05ID, AT2007.Ana06ID, AT2007.Ana07ID, AT2007.Ana08ID, AT2007.Ana09ID, AT2007.Ana10ID ,
			(Select Distinct InvoiceNo from AT9000 WITH (NOLOCK) Where VoucherID = AT2007.VoucherID and TransactionID = AT2007.TransactionID and Isnull(InvoiceNo,'''')<>'''') as InvoiceNo,
			A01.AnaName AS Ana01Name, A02.AnaName AS Ana02Name, A03.AnaName AS Ana03Name, A04.AnaName AS Ana04Name, A05.AnaName AS Ana05Name,
			A06.AnaName AS Ana06Name, A07.AnaName AS Ana07Name, A08.AnaName AS Ana08Name, A09.AnaName AS Ana09Name, A10.AnaName AS Ana10Name,
			AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
			case	when AT2006.KindVoucherID IN (1, 5, 7, 9 ,15, 17) THEN 1
									WHEN AT2006.KindVoucherID = 3 THEN 2
									ELSE 3 end as Indexs '	
							
	SET @sSQlUnionFrom = ' 
		FROM AT1302  WITH (NOLOCK)	
		LEFT JOIN AT2007 WITH (NOLOCK) on AT1302.InventoryID = AT2007.InventoryID AND AT1302.DivisionID in (''@@@'',AT2007.DivisionID)
		INNER JOIN AT2006 WITH (NOLOCK) on At2006.VoucherID = AT2007.VoucherID AND AT2006.DivisionID = AT2007.DivisionID
		LEFT JOIN AV7015_AG AV7015 on AV7015.InventoryID = AT2007.InventoryID AND AV7015.DivisionID = AT2007.DivisionID
		INNER JOIN AT1303 WITH (NOLOCK) on AT1303.DivisionID in (''@@@'','''+@DivisionID+''') AND AT1303.WareHouseID = ( CASE WHEN KindVoucherID = 3 Then AT2006.WareHouseID2  Else AT2006.WareHouseID end)
		LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.ObjectID = AT2006.ObjectID  AND AT1202.DivisionID in (''@@@'',AT2007.DivisionID)
		LEFT JOIN AT1011 AS A01 WITH (NOLOCK) ON A01.DivisionID = AT2007.DivisionID AND A01.AnaID = AT2007.Ana01ID AND A01.AnaTypeID = ''A01''
		LEFT JOIN AT1011 AS A02 WITH (NOLOCK) ON A02.DivisionID = AT2007.DivisionID AND A02.AnaID = AT2007.Ana02ID AND A02.AnaTypeID = ''A02''
		LEFT JOIN AT1011 AS A03 WITH (NOLOCK) ON A03.DivisionID = AT2007.DivisionID AND A03.AnaID = AT2007.Ana03ID AND A03.AnaTypeID = ''A03''
		LEFT JOIN AT1011 AS A04 WITH (NOLOCK) ON A04.DivisionID = AT2007.DivisionID AND A04.AnaID = AT2007.Ana04ID AND A04.AnaTypeID = ''A04''
		LEFT JOIN AT1011 AS A05 WITH (NOLOCK) ON A05.DivisionID = AT2007.DivisionID AND A05.AnaID = AT2007.Ana05ID AND A05.AnaTypeID = ''A05''
		LEFT JOIN AT1011 AS A06 WITH (NOLOCK) ON A06.DivisionID = AT2007.DivisionID AND A06.AnaID = AT2007.Ana06ID AND A06.AnaTypeID = ''A06''
		LEFT JOIN AT1011 AS A07 WITH (NOLOCK) ON A07.DivisionID = AT2007.DivisionID AND A07.AnaID = AT2007.Ana07ID AND A07.AnaTypeID = ''A07''
		LEFT JOIN AT1011 AS A08 WITH (NOLOCK) ON A08.DivisionID = AT2007.DivisionID AND A08.AnaID = AT2007.Ana08ID AND A08.AnaTypeID = ''A08''
		LEFT JOIN AT1011 AS A09 WITH (NOLOCK) ON A09.DivisionID = AT2007.DivisionID AND A09.AnaID = AT2007.Ana09ID AND A09.AnaTypeID = ''A09''
		LEFT JOIN AT1011 AS A10 WITH (NOLOCK) ON A10.DivisionID = AT2007.DivisionID AND A10.AnaID = AT2007.Ana10ID AND A10.AnaTypeID = ''A10''
		'

	SET @sSQlUnionWhere = ' 
		WHERE	AT2007.DivisionID = N''' + @DivisionID + ''' ' +
				(CASE WHEN @IsAll = 1 THEN ' AND AT1303.IsTemp = 0 ' ELSE '' END) + ' AND
				AT2006.KindVoucherID in ' + @KindVoucherListEx1 + ' AND
				(CONVERT(DATETIME, CONVERT(VARCHAR(10), VoucherDate, 101), 101) Between ''' +@FromDateText+ ''' AND ''' +@ToDateText+ ''' ) AND
				(AT2007.InventoryID between N''' + @FromInventoryID + ''' AND N''' + @ToInventoryID + ''') AND
				( (KindVoucherID in ' + @KindVoucherListEx2 + '  AND 
					AT2006.WareHouseID '+CASE WHEN ISNULL(@WareHouseID,'%') =  '%' THEN ' LIKE N''%'' ' ELSE ' = '''+@WareHouseID+''' ' END +') 
					or  (KindVoucherID = 3 AND WareHouseID2 '+CASE WHEN ISNULL(@WareHouseID,'%') =  '%' THEN ' LIKE N''%'' ' ELSE ' = '''+@WareHouseID+''' ' END +')) '
	END	 
PRINT @sSQlSelect
PRINT @sSQlFrom
PRINT @sSQlWhere
PRINT @sSQlUnionSelect
PRINT @sSQlUnionFrom
PRINT @sSQlUnionWhere		

IF NOT EXISTS ( SELECT 1 FROM SysObjects WITH (NOLOCK) WHERE Xtype = 'V' AND Name = 'AV2028_AG' )
	BEGIN
			EXEC ( 'CREATE VIEW AV2028_AG --CREATED BY AP2018
					AS '+@sSQLSelect+@sSQlFrom+@sSQlWhere+@sSQlUnionSelect+@sSQlUnionFrom+@sSQlUnionWhere )
	END
ELSE
	BEGIN
			EXEC ( 'ALTER VIEW AV2028_AG --CREATED BY AP2018
					as '+@sSQLSelect+@sSQlFrom+@sSQlWhere+@sSQlUnionSelect+@sSQlUnionFrom+@sSQlUnionWhere )
	END
		 
--- Lay du su va phat sinh
SET @sSQLSelect = N'
SELECT * FROM ( 
SELECT	AV2028.WareHouseID, AV2028.WareHouseName, AV2028.VoucherID, AV2028.TranMonth, AV2028.TranYear, AV2028.TableID, AV2028.BatchID,  NEWID() as TransactionID, --AV2028.Orders,
		DATEADD(d, 0, DATEDIFF(d, 0, AV2028.VoucherDate)) AS VoucherDate, AV2028.VoucherNo, AV2028.KindVoucherID, AV2028.ImVoucherDate, AV2028.ImVoucherNo, AV2028.ImSourceNo,
		AV2028.ImLimitDate, AV2028.ImWareHouseID, 
		AV2028.ImRefNo01, AV2028.ImRefNo02,
		SUM(AV2028.ImQuantity) AS ImQuantity, AV2028.ImUnitPrice, SUM(AV2028.ImConvertedAmount) AS ImConvertedAmount,
		SUM(AV2028.ImOriginalAmount) AS ImOriginalAmount, SUM(AV2028.ImConvertedQuantity) AS ImConvertedQuantity,  
		AV2028.ExVoucherDate, AV2028.ExVoucherNo, AV2028.ExSourceNo,
		AV2028.ExLimitDate, AV2028.ExWareHouseID, 
		AV2028.ExRefNo01, AV2028.ExRefNo02,
		SUM(AV2028.ExQuantity) AS ExQuantity, AV2028.ExUnitPrice, SUM(AV2028.ExConvertedAmount) AS ExConvertedAmount,
		SUM(AV2028.ExOriginalAmount) AS ExOriginalAmount, SUM(AV2028.ExConvertedQuantity) AS ExConvertedQuantity, 
		AV2028.VoucherTypeID, AV2028.Description,
		AV2028.Notes, AV2028.InventoryID, AV2028.InventoryName, AV2028.UnitID,  AT1304.UnitName, AV2028.ConversionFactor,
		AT1309.UnitID AS ConversionUnitID, AT1309.ConversionFactor AS  ConversionFactor01, AT1309.Operator,
		AV2028.BeginQuantity, AV2028.BeginAmount, AV2028.ImExOrders, AV2028.DebitAccountID, AV2028.CreditAccountID,
		AV2028.ObjectID, AV2028.ObjectName, AV2028.Notes01, AV2028.Notes02, AV2028.Notes03, AV2028.DivisionID,
		MAX(AV2028.Ana01ID) AS Ana01ID, MAX(AV2028.Ana02ID) AS Ana02ID, MAX(AV2028.Ana03ID) AS Ana03ID, MAX(AV2028.Ana04ID) AS Ana04ID, MAX(AV2028.Ana05ID) AS Ana05ID, 
		MAX(AV2028.Ana06ID) AS Ana06ID, MAX(AV2028.Ana07ID) AS Ana07ID, MAX(AV2028.Ana08ID) AS Ana08ID, MAX(AV2028.Ana09ID) AS Ana09ID, MAX(AV2028.Ana10ID) AS Ana10ID,
		MAX(AV2028.Ana01Name) AS Ana01Name, MAX(AV2028.Ana02Name) AS Ana02Name, MAX(AV2028.Ana03Name) AS Ana03Name, MAX(AV2028.Ana04Name) AS Ana04Name, MAX(AV2028.Ana05Name) AS Ana05Name, 
		MAX(AV2028.Ana06Name) AS Ana06Name, MAX(AV2028.Ana07Name) AS Ana07Name, MAX(AV2028.Ana08Name) AS Ana08Name, MAX(AV2028.Ana09Name) AS Ana09Name, MAX(AV2028.Ana10Name) AS Ana10Name,
		AV2028.InvoiceNo, AV2028.ConvertedUnitID,
		AV2028.Parameter01,AV2028.Parameter02,AV2028.Parameter03,AV2028.Parameter04,AV2028.Parameter05, Indexs
			
FROM	AV2028_AG  AV2028
LEFT JOIN AT1304 WITH (NOLOCK) on AT1304.UnitID = AV2028.UnitID AND  AT1304.DivisionID in (''@@@'',AV2028.DivisionID)
LEFT JOIN AT1309 WITH (NOLOCK) on AT1309.InventoryID = AV2028.InventoryID AND AT1309.UnitID = AV2028.UnitID AND AT1309.DivisionID = AV2028.DivisionID 

WHERE	AV2028.BeginQuantity <> 0 or AV2028.BeginAmount <> 0 or AV2028.ImQuantity <> 0 or
		AV2028.ImConvertedAmount <> 0 or AV2028.ExQuantity <> 0 or AV2028.ExConvertedAmount <> 0 
'
SET @sSQlSelect1 = '
GROUP BY		
AV2028.WareHouseID, AV2028.WareHouseName, AV2028.VoucherID, AV2028.TranMonth, AV2028.TranYear, AV2028.TableID, AV2028.BatchID, --AV2028.TransactionID, AV2028.Orders,
		AV2028.VoucherDate, AV2028.VoucherNo, AV2028.KindVoucherID, AV2028.ImVoucherDate, AV2028.ImVoucherNo, AV2028.ImSourceNo,
		AV2028.ImLimitDate, AV2028.ImWareHouseID, 
		AV2028.ImRefNo01, AV2028.ImRefNo02,
		AV2028.ImUnitPrice,  
		AV2028.ExVoucherDate, AV2028.ExVoucherNo, AV2028.ExSourceNo,
		AV2028.ExLimitDate, AV2028.ExWareHouseID, 
		AV2028.ExRefNo01, AV2028.ExRefNo02,
		AV2028.ExUnitPrice,
		AV2028.VoucherTypeID, AV2028.Description,
		AV2028.Notes, AV2028.InventoryID, AV2028.InventoryName, AV2028.UnitID,  AT1304.UnitName, AV2028.ConversionFactor,
		AT1309.UnitID, AT1309.ConversionFactor, AT1309.Operator,
		AV2028.BeginQuantity, AV2028.BeginAmount, AV2028.ImExOrders, AV2028.DebitAccountID, AV2028.CreditAccountID,
		AV2028.ObjectID, AV2028.ObjectName, AV2028.Notes01, AV2028.Notes02, AV2028.Notes03, AV2028.DivisionID,
		--AV2028.Ana01ID, AV2028.Ana02ID, AV2028.Ana03ID, AV2028.Ana04ID, AV2028.Ana05ID, AV2028.Ana06ID, AV2028.Ana07ID, AV2028.Ana08ID, AV2028.Ana09ID, AV2028.Ana10ID ,
		--AV2028.Ana01Name, AV2028.Ana02Name, AV2028.Ana03Name, AV2028.Ana04Name, AV2028.Ana05Name, AV2028.Ana06Name, AV2028.Ana07Name, AV2028.Ana08Name, AV2028.Ana09Name, AV2028.Ana10Name ,
		AV2028.InvoiceNo, AV2028.ConvertedUnitID,
		AV2028.Parameter01,AV2028.Parameter02,AV2028.Parameter03,AV2028.Parameter04,AV2028.Parameter05, Indexs
'

SET @sSQlUnionSelect = N' 
UNION 

SELECT  AV7015.WareHouseID  AS WareHouseID, AV7015.WareHouseName AS WareHouseName, NULL as TranMonth, NULL as TranYear, Null AS VoucherID, Null as TableID, Null as BatchID, Null AS TransactionID, 
		--Null AS Orders,
		null AS VoucherDate, null AS VoucherNo, null as KindVoucherID, null AS ImVoucherDate, null AS ImVoucherNo, 
		null AS ImSourceNo,null AS ImLimitDate, null AS ImWareHouseID,
    	Null AS ImRefNo01, Null AS  ImRefNo02,

		0 AS ImQuantity, 0 AS ImUnitPrice, 0 AS ImConvertedAmount,
		0 AS ImOriginalAmount, 0 AS ImConvertedQuantity,   0 AS ExVoucherDate, null AS ExVoucherNo, 
		null AS ExSourceNo, null AS ExLimitDate, null AS ExWareHouseID, 
		Null AS ExRefNo01, Null AS  ExRefNo02,
		0 AS ExQuantity, 0 AS ExUnitPrice, 
		0 AS ExConvertedAmount,0 AS ExOriginalAmount, 0 AS ExConvertedQuantity, 
        null AS VoucherTypeID, null AS Description,null AS Notes, 
		AV7015.InventoryID, InventoryName, AV7015.UnitID, AT1304.UnitName, 1 AS ConversionFactor,
		AT1309.UnitID AS ConversionUnitID, AT1309.ConversionFactor AS  ConversionFactor01, AT1309.Operator,
		BeginQuantity, BeginAmount, 0 AS ImExOrders,NULL AS DebitAccountID, NULL AS CreditAccountID,
		null AS ObjectID,  null AS ObjectName,null AS Notes01, Null AS Notes02, Null AS Notes03, AV7015.DivisionID,
		NULL AS Ana01ID, NULL AS Ana02ID, NULL AS Ana03ID, NULL AS Ana04ID, NULL AS Ana05ID, NULL AS Ana06ID, NULL AS Ana07ID, NULL AS Ana08ID, NULL AS Ana09ID, NULL AS Ana10ID,
		NULL as Ana01Name, NULL as Ana02Name, NULL as Ana03Name, NULL as Ana04Name, NULL as Ana05Name, NULL as Ana06Name, NULL as Ana07Name, NULL as Ana08Name, NULL as Ana09Name, NULL as Ana10Name , 
		NULL AS InvoiceNo, NULL AS ConvertedUnitID,
		NULL as Parameter01,NULL as Parameter02,NULL as Parameter03,NULL as Parameter04,NULL as Parameter05, NULL as Indexs
			
FROM	AV7015_AG AV7015
INNER JOIN AT1304 WITH (NOLOCK) on AT1304.UnitID = AV7015.UnitID AND AT1304.DivisionID in (''@@@'',AV7015.DivisionID)
LEFT JOIN AT1309 WITH (NOLOCK) on AT1309.InventoryID = AV7015.InventoryID AND AT1309.UnitID = AV7015.UnitID AND AT1309.DivisionID = AV7015.DivisionID

WHERE AV7015.InventoryID not in (Select InventoryID From AV2028_AG) AND (BeginQuantity<>0 or BeginAmount<>0)
) A
ORDER BY VoucherDate, Indexs
		 
'


--Print @sSQLSelect
--PRINT @sSQlSelect1
--PRINT @sSQlUnionSelect
EXEC (@sSQLSelect+ @sSQlSelect1+@sSQlUnionSelect)
		




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
