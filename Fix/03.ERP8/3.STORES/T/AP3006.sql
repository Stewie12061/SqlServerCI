IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WITH(NOLOCK) WHERE ID = OBJECT_ID(N'[DBO].[AP3006]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[AP3006]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
--- Lay du lieu in bao cao nhap xuat ton theo FIFO theo quy cách.
-- <Param>
---- Created by Tiểu Mai on 05/11/2015
----Modified by Phương Thảo on 27/05/2016: Bổ sung WITH(NOLOCK)
---- Modified by Tiểu Mai on 03/06/2016: Cải tiến store bỏ Left join
---- Modify on 25/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modify on 02/10/2020 by Nhựt Trường: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Duy on 21/02/2023: [2023/02/IS/0091] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục đối tượng - AT1202.
-- <Example>
/*
    AP3006 'PC',4,4,2012,2012,'01/01/2012','04/25/2012','K01','K99','0000000001','0000000001',1
*/

CREATE PROCEDURE AP3006
(
	@DivisionID VARCHAR(50),		
	@FromMonth INT,
	@ToMonth INT,
	@FromYear INT,
	@ToYear INT,
	@FromDate DATETIME,
	@ToDate DATETIME,
	@FromWareHouseID NVARCHAR(50),
	@ToWareHouseID VARCHAR(50),
	@FromInventoryID NVARCHAR(50),
	@ToInventoryID NVARCHAR(50),		
	@IsDate TINYINT
)
AS

		DECLARE @sSQL1 NVARCHAR(MAX),
				@sSQL2 NVARCHAR(MAX),
				@sSQL3 NVARCHAR(MAX),
				@sSQL4 NVARCHAR(MAX),
				@sSQL5 NVARCHAR(MAX), 
				@FromMonthYearText NVARCHAR(20), 
				@ToMonthYearText NVARCHAR(20), 
				@FromDateText NVARCHAR(20), 
				@ToDateText NVARCHAR(20)

-- Lấy những phiếu nhập và nhập VCNB
	SET @sSQL5 = '
		Select
			WareHouseID, 
			AT2007.TransactionID, AT2007.VoucherID, AT2007.InventoryID, AT2007.UnitID, 
			AT2007.ActualQuantity, 
			AT2007.MarkQuantity, AT2007.UnitPrice, 
			AT2007.OriginalAmount, AT2007.ConvertedAmount, AT2007.TranMonth, AT2007.TranYear, 
			AT2007.DivisionID, AT2007.ReTransactionID, AT2007.ReVoucherID,
			AT2007.exchangeRate,AT2007.currencyID,AT2007.notes,
			''T05''  as TransactionTypeID,
			AT2007.Parameter01, AT2007.Parameter02, AT2007.Parameter03, AT2007.Parameter04, AT2007.Parameter05,
			AT2007.Ana04ID, AT2007.Ana05ID, AT2007.ConvertedUnitID, AT2007.ConvertedQuantity, AT2006.VoucherTypeID,
			AT2007.Notes01, AT2007.Notes02, AT2007.Notes03, AT2007.Notes04, AT2007.Notes05, AT2007.Notes06, AT2007.Notes07, AT2007.Notes08,
			AT2007.Notes09, AT2007.Notes10, AT2007.Notes11, AT2007.Notes12, AT2007.Notes13, AT2007.Notes14, AT2007.Notes15,
			AT2006.ObjectID, AT1202.ObjectName, AT1304.UnitName as ConvertedUnitName,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
	
		From AT2007 WITH(NOLOCK) 
		inner Join AT2006 WITH(NOLOCK) On AT2006.VoucherID = AT2007.VoucherID And AT2006.DivisionID = AT2007.DivisionID and KindVoucherID in (1,3,5,7,9)
		left join AT1202 WITH(NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT2006.ObjectID = AT1202.ObjectID
		left join AT1304 WITH(NOLOCK) on AT2007.ConvertedUnitID = AT1304.UnitID
		left join WT8899 O99 WITH(NOLOCK) on O99.DivisionID = AT2007.DivisionID and O99.VoucherID = AT2007.VoucherID and O99.TransactionID = AT2007.TransactionID
		Union all
		Select   AT2016.WareHouseID, 
			AT2017.TransactionID, AT2017.VoucherID, AT2017.InventoryID, AT2017.UnitID, 
			AT2017.ActualQuantity,
			AT2017.MarkQuantity, AT2017.UnitPrice, 
			AT2017.OriginalAmount, AT2017.ConvertedAmount, AT2017.TranMonth, AT2017.TranYear, 
			AT2017.DivisionID, AT2017.ReTransactionID, AT2017.ReVoucherID ,
			AT2017.exchangeRate,AT2017.currencyID,AT2017.notes	,
			''T00'' as TransactionTypeID,
			AT2017.Parameter01, AT2017.Parameter02, AT2017.Parameter03, AT2017.Parameter04, AT2017.Parameter05,
			AT2017.Ana04ID, AT2017.Ana05ID, AT2017.ConvertedUnitID, AT2017.ConvertedQuantity, AT2016.VoucherTypeID,
			AT2017.Notes01, AT2017.Notes02, AT2017.Notes03, AT2017.Notes04, AT2017.Notes05, AT2017.Notes06, AT2017.Notes07, AT2017.Notes08,
			AT2017.Notes09, AT2017.Notes10, AT2017.Notes11, AT2017.Notes12, AT2017.Notes13, AT2017.Notes14, AT2017.Notes15,
			AT2016.ObjectID, AT1202.ObjectName, AT1304.UnitName as ConvertedUnitName,
			O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
			O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID	
		From AT2017 WITH(NOLOCK) 
		inner Join AT2016 WITH(NOLOCK) On AT2016.VoucherID = AT2017.VoucherID And AT2016.DivisionID = AT2017.DivisionID
		left join AT1202 WITH(NOLOCK) on AT1202.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') AND AT2016.ObjectID = AT1202.ObjectID
		left join AT1304 WITH(NOLOCK) on AT2017.ConvertedUnitID = AT1304.UnitID
		left join WT8899 O99 WITH(NOLOCK) on O99.DivisionID = AT2017.DivisionID and O99.VoucherID = AT2017.VoucherID and O99.TransactionID = AT2017.TransactionID'
	--PRINT @sSQL5				
	IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype ='V' AND Name ='AV3004_QC') EXEC ('CREATE VIEW AV3004_QC AS '+ @sSQL5)----tao boi AP3006----
	ELSE EXEC('ALTER VIEW AV3004_QC AS '+@sSQL5)
					    
	SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
	SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	IF @IsDate = 0 --- theo ky 
		BEGIN
	--Tao veiw AV3001- So du dau ky
			SET   @sSQL1 = N'
				SELECT DISTINCT	AT0114.InventoryID, AT1302.InventoryName, ReVoucherNo VoucherNo, ReVoucherDate VoucherDate, 
				ReQuantity = AT0114.ReQuantity - ISNULL((SELECT SUM(PriceQuantity) FROM AT0115 WITH(NOLOCK)
															WHERE TranMonth + TranYear*100   < '+@FromMonthYearText+'
															AND ReTransactionID = AT0114.ReTransactionID And DivisionID = AT0115.DivisionID), 0),
				ReAmount = Av3004.ConvertedAmount  - ISNULL((SELECT SUM(ConvertedAmount) FROM AT0115  WITH(NOLOCK)
																WHERE TranMonth + TranYear*100   < '+@FromMonthYearText+'
																AND ReTransactionID = AT0114.ReTransactionID And DivisionID = AT0114.DivisionID), 0),
				AT0114.UnitPrice ReUnitPrice, NULL DeQuantity, NULL DeUnitPice, NULL FromVoucherNo , NULL FromVoucherDate,
				AT0114.WareHouseID, AV3004.UnitID,  AV3004.CurrencyID, AV3004.ExchangeRate, AT1302.Specification, AT1302.Notes01,
				AT1302.Notes02, AT1302.Notes03, Notes, AT0114.ReTransactionID TransactionID, AT0114.DivisionID,
				S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID '
	
			SET @sSQL2 = N'
				FROM AT0114 WITH(NOLOCK)
				LEFT JOIN AV3004_QC AV3004 ON AV3004.VoucherID = AT0114.ReVoucherID AND AV3004.TransactionID = AT0114.ReTransactionID AND AV3004.DivisionID = AT0114.DivisionID
				INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0114.DivisionID,''@@@'') AND AT1302.InventoryID = AT0114.InventoryID
				WHERE AT0114.DivisionID ='''+@DivisionID+'''
				AND (AT0114.InventoryID BETWEEN '''+@FromInventoryID+''' AND ''' + @ToInventoryID + ''')
				AND (ReTranMonth + ReTranYear*100 < ''' + @FromMonthYearText +''' OR TransactionTypeID =''T00'')
				AND (AT0114.WareHouseID BETWEEN '''+@FromWareHouseID+''' AND ''' + @ToWareHouseID + ''')'
		
		END
	ELSE
		BEGIN
			SET @sSQL1 = N'
					SELECT DISTINCT	AT0114.InventoryID, AT1302.InventoryName, ReVoucherNo VoucherNo, ReVoucherDate VoucherDate, 
					ReQuantity = ReQuantity - ISNULL((SELECT SUM(PriceQuantity) FROM AT0115 WITH(NOLOCK)
													  WHERE VoucherDate  < '''+ @FromDateText +''' 
													  AND ReTransactionID = AT0114.ReTransactionID And DivisionID = AT0115.DivisionID), 0),
					ReAmount = AV3004.ConvertedAmount  - ISNULL((SELECT SUM(ConvertedAmount) FROM AT0115 WITH(NOLOCK)
																 WHERE VoucherDate  < '''+ @FromDateText +''' 
																 AND ReTransactionID = AT0114.ReTransactionID AND DivisionID = AT0114.DivisionID), 0),
					AT0114.UnitPrice ReUnitPrice, NULL DeQuantity, NULL DeUnitPice, NULL FromVoucherNo, NULL FromVoucherDate,
					AT0114.WareHouseID, AV3004.UnitID, AV3004.CurrencyID, AV3004.ExchangeRate, AT1302.Specification, AT1302.Notes01,
					AT1302.Notes02, AT1302.Notes03, Notes, AT0114.ReTransactionID TransactionID, AT0114.DivisionID,
					S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID '
			
				SET @sSQL2 = N'
					FROM AT0114 WITH(NOLOCK)
					LEFT JOIN AV3004_QC AV3004 ON AV3004.VoucherID = AT0114.ReVoucherID AND AV3004.TransactionID = AT0114.ReTransactionID AND AV3004.DivisionID = AT0114.DivisionID
					INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0114.DivisionID,''@@@'') AND AT1302.InventoryID = AT0114.InventoryID
					WHERE AT0114.DivisionID ='''+@DivisionID+'''
					AND (AT0114.InventoryID BETWEEN '''+@FromInventoryID+''' AND ''' + @ToInventoryID + ''')
					AND (AT0114.ReVoucherDate <'''+@FromDateText+''' or TransactionTypeID =''T00'' )
					AND (AT0114.WareHouseID BETWEEN '''+@FromWareHouseID+''' AND ''' + @ToWareHouseID + ''')'
			END
			
	IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype ='V' AND Name ='AV3001_QC') EXEC ('CREATE VIEW AV3001_QC AS '+ @sSQL1+  @sSQL2)----tao boi AP3006----
	ELSE EXEC('ALTER VIEW AV3001_QC AS '+@sSQL1+  @sSQL2) ----tao boi AP3006----

-----------Tao View AV3002 -Phat sinh trong ky
		 IF @Isdate = 0    -- theo ngày
			BEGIN
				SET @sSQL1 = N'
					SELECT DISTINCT	AT0114.InventoryID, AT1302.InventoryName, AT0114.ReVoucherNo VoucherNo, AT0114.ReVoucherDate VoucherDate,
						ReQuantity, AT0114.UnitPrice ReUnitPrice, PriceQuantity DeQuantity, AT0115.UnitPrice DeUnitPice, AT2007.OriginalAmount,
						AT2007.ConvertedAmount, NULL FromVoucherNo, NULL FromVoucherDate, AT0114.WareHouseID, AT2007.UnitID,CurrencyID,ExchangeRate,
						AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, Notes,  AT0114.ReTransactionID TransactionID, AT0114.DivisionID,
						O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
						O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID '		
		
				SET @sSQL2= N'
					FROM AT0114 WITH(NOLOCK)
					LEFT JOIN AT0115 WITH(NOLOCK) ON AT0115.TransactionID = AT0114.ReTransactionID AND AT0115.DivisionID = AT0114.DivisionID
					INNER JOIN AT2007 WITH(NOLOCK) ON AT2007.VoucherID = AT0114.ReVoucherID AND AT2007.DivisionID = AT0114.DivisionID AND AT2007.TransactionID = AT0114.ReTransactionID
					left join WT8899 O99 WITH(NOLOCK) on O99.DivisionID = AT2007.DivisionID and O99.VoucherID = AT2007.VoucherID and O99.TransactionID = AT2007.TransactionID 
					INNER JOIN AT1302 WITH(NOLOCK) on AT1302.DivisionID IN (AT0114.DivisionID,''@@@'') AND AT1302.InventoryID = AT0114.InventoryID
					WHERE AT0114.DivisionID = '''+@DivisionID+'''
						AND (AT0114.InventoryID BETWEEN '''+@FromInventoryID+''' AND ''' + @ToInventoryID + ''')
						AND (ReTranMonth + ReTranYear*100 BETWEEN ''' + @FromMonthYearText + ''' AND ''' +	@ToMonthYearText + ''')
						AND (AT0114.WareHouseID BETWEEN '''+@FromWareHouseID+''' AND ''' + @ToWareHouseID + ''')	
					UNION ALL'
				SET @sSQL3 = N'
					SELECT DISTINCT	AT0115.InventoryID, AT1302.InventoryName, VoucherNo DeVoucherNo, VoucherDate DeVoucherDate, NULL ReQuantity,
						NULL ReUnitPrice, PriceQuantity DeQuantity, AT0115.UnitPrice DeUnitPice, NULL OriginalAmount, NULL ConvertedAmount,
						AT0115.ReVoucherNo FromVoucherNo, AT0115.ReVoucherDate FromVoucherDate, AT0115.WareHouseID, AT2007. UnitID,CurrencyID,
						ExchangeRate, AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, Notes,  AT0115.TransactionID, AT0115.DivisionID,
						O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
						O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID '
				SET @sSQL4 = N'
					FROM AT0115 WITH(NOLOCK)
					LEFT JOIN AT2007 WITH(NOLOCK) ON AT2007.VoucherID = AT0115.ReVoucherID AND AT2007.TransactionID = AT2007.RETransactionID AND AT2007.DivisionId = AT2007.DivisionID
					left join WT8899 O99 WITH(NOLOCK) on O99.DivisionID = AT2007.DivisionID and O99.VoucherID = AT2007.VoucherID and O99.TransactionID = AT2007.TransactionID
					INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0115.DivisionID,''@@@'') AND AT1302.InventoryID = AT0115.InventoryID
					WHERE AT0115.DivisionID = '''+@DivisionID+'''
					AND (AT0115.InventoryID BETWEEN '''+@FromInventoryID+''' AND ''' + @ToInventoryID + ''')
					AND (AT0115.TranMonth + AT0115.TranYear*100 BETWEEN '''+ @FromMonthYearText + ''' AND ''' + @ToMonthYearText + ''') 
					AND (AT0115.WareHouseID between '''+@FromWareHouseID+'''  AND ''' + @ToWareHouseID + ''')'
			END
		ELSE
			BEGIN
				SET @sSQL1 = N'
					SELECT DISTINCT	AT0114.InventoryID, AT1302.InventoryName, AT0114.ReVoucherNo VoucherNo, AT0114.ReVoucherDate VoucherDate,
						ReQuantity, AT0114.UnitPrice ReUnitPrice, PriceQuantity DeQuantity, AT0115.UnitPrice DeUnitPice, AT2007.OriginalAmount,
						AT2007.ConvertedAmount, NULL FromVoucherNo, NULL FromVoucherDate, AT0114.WareHouseID, AT2007.UnitID, CurrencyID,ExchangeRate,
						AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, Notes, AT0114.ReTransactionID as TransactionID, AT0114.DivisionID,
						O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
						O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID '
				SET @sSQL2 = N'
					FROM AT0114 WITH(NOLOCK)
					LEFT JOIN AT0115 WITH(NOLOCK) ON AT0115.TransactionID = AT0114.ReTransactionID AND AT0115.DivisionID = AT0114.DivisionID
					INNER JOIN AT2007 WITH(NOLOCK) ON AT2007.VoucherID = AT0114.ReVoucherID AND AT2007.DivisionID = AT0114.DivisionID AND AT2007.TransactionID = AT0114.ReTransactionID
					left join WT8899 O99 WITH(NOLOCK) on O99.DivisionID = AT2007.DivisionID and O99.VoucherID = AT2007.VoucherID and O99.TransactionID = AT2007.TransactionID 
					INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0114.DivisionID,''@@@'') AND AT1302.InventoryID = AT0114.InventoryID
					WHERE AT0114.DivisionID = '''+@DivisionID+'''
						AND (AT0114.InventoryID BETWEEN '''+@FromInventoryID+''' AND ''' + @ToInventoryID + ''')
						AND (AT0114.ReVoucherDate BETWEEN '''+@FromDateText+'''  AND '''+@ToDateText+''')
						AND (AT0114.WareHouseID between '''+@FromWareHouseID+''' AND ''' + @ToWareHouseID + ''')	 
					UNION ALL'
				SET @sSQL3 = N'
					SELECT AT0115.InventoryID, AT1302.InventoryName, VoucherNo DeVoucherNo, VoucherDate DeVoucherDate, NULL ReQuantity,
						NULL ReUnitPrice, PriceQuantity DeQuantity, AT0115.UnitPrice DeUnitPice, NULL OriginalAmount, NULL ConvertedAmount,
						AT0115.ReVoucherNo FromVoucherNo, AT0115.ReVoucherDate FromVoucherDate, AT0115.WareHouseID, AT2007.UnitID, CurrencyID,
						ExchangeRate, AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, Notes, AT0115.TransactionID, AT0115.DivisionID,
						O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID,
						O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID '
				SET @sSQL4 = N'
					FROM AT0115 WITH(NOLOCK)
					LEFT JOIN AT2007 WITH(NOLOCK) ON AT2007.VoucherID = AT0115.ReVoucherID AND AT2007.TransactionID = AT2007.RETransactionID AND AT2007.DivisionID = AT2007.DivisionID
					left join WT8899 O99 WITH(NOLOCK) on O99.DivisionID = AT2007.DivisionID and O99.VoucherID = AT2007.VoucherID and O99.TransactionID = AT2007.TransactionID
					INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0115.DivisionID,''@@@'') AND AT1302.InventoryID = AT0115.InventoryID
					WHERE AT0115.DivisionID = '''+@DivisionID+'''
						AND (AT0115.InventoryID BETWEEN '''+@FromInventoryID+''' AND ''' + @ToInventoryID + ''')
						AND (AT0115.VoucherDate Between '''+@FromDateText+'''  AND  '''+@ToDateText+''')
						AND (AT0115.WareHouseID between '''+@FromWareHouseID+'''  AND ''' + @ToWareHouseID + ''')'			
			END
--Print @sSQL1+@sSQL2+@sSQL3+@sSQL4
		
	IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' and Name = 'AV3002_QC') EXEC ('CREATE VIEW AV3002_QC AS '+ @sSQL1+@sSQL2+@sSQL3+@sSQL4 ) ----tao boi AP3006----
	ELSE EXEC ('ALTER VIEW AV3002_QC AS ' + @sSQL1 + @sSQL2 + @sSQL3 + @sSQL4) ----tao boi AP3006----
-----Tao Veiw AV3003 --Ton cuoi ky
		IF @IsDate = 0
			BEGIN
				SET @sSQL1= N'
						SELECT DISTINCT	AT0114.InventoryID, AT1302.InventoryName, ReVoucherNo VoucherNo, ReVoucherDate VoucherDate,
						ReQuantity = ReQuantity - ISNULL((SELECT SUM(PriceQuantity) FROM AT0115 WITH(NOLOCK)
														  WHERE TranMonth + TranYear * 100 <= '+@ToMonthYearText+'
														  AND ReTransactionID = AT0114.ReTransactionID 
														  AND DivisionID = AT0115.DivisionID), 0),
						AT0114.UnitPrice ReUnitPrice, ReAmount = AV3004.ConvertedAmount  - ISNULL((SELECT SUM(ConvertedAmount) FROM AT0115 WITH(NOLOCK)
																								   WHERE TranMonth + TranYear * 100 <= '+@ToMonthYearText+'
																								   AND ReTransactionID = AT0114.ReTransactionID
																								   AND DivisionID = AT0115.DivisionID), 0),			
						NULL DeQuantity, NULL DeUnitPice, NULL FromVoucherNo, NULL FromVoucherDate, AT0114.WareHouseID, AV3004.UnitID, AV3004.CurrencyID,
						AV3004.ExchangeRate, AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, Notes, AT0114.ReTransactionID as TransactionID, AT0114.DivisionID,
						S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID '
				SET @sSQL2 = N'
						FROM AT0114 WITH(NOLOCK)
						LEFT JOIN AV3004_QC AV3004 ON AV3004.VoucherID = AT0114.ReVoucherID AND TransactionID = AT0114.ReTransactionID AND AV3004.DivisionID = AT0114.DivisionID
						INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0114.DivisionID,''@@@'') AND AT1302.InventoryID =AT0114.InventoryID
						WHERE AT0114.DivisionID = '''+@DivisionID+'''
						AND (AT0114.InventoryID BETWEEN '''+@FromInventoryID+''' AND ''' + @ToInventoryID + ''')
						AND (ReTranMonth + ReTranYear*100 <= ''' +	@ToMonthYearText + ''' OR TransactionTypeID =''T00'')
						AND (AT0114.WareHouseID BETWEEN '''+@FromWareHouseID+''' AND ''' + @ToWareHouseID + ''')'		
			END
		ELSE
			BEGIN
				SET @sSQL1 = N'
						SELECT DISTINCT	AT0114.InventoryID, AT1302.InventoryName, ReVoucherNo VoucherNo, ReVoucherDate VoucherDate,
						ReQuantity = ReQuantity - ISNULL((SELECT SUM(PriceQuantity) FROM AT0115 WITH(NOLOCK)
														  WHERE VoucherDate <= '''+ @ToDateText +'''
														  AND ReTransactionID = AT0114.ReTransactionID And DivisionID = AT0115.DivisionID), 0),
						AT0114.UnitPrice ReUnitPrice, ReAmount = AV3004.ConvertedAmount  - ISNULL((SELECT SUM(ConvertedAmount) FROM AT0115  WITH(NOLOCK)
																								   WHERE VoucherDate <= '''+ @ToDateText +'''
																								   AND ReTransactionID = AT0114.ReTransactionID
																								   AND DivisionID = AT0115.DivisionID), 0),
						NULL DeQuantity, NULL DeUnitPice, NULL FromVoucherNo, NULL FromVoucherDate, AT0114.WareHouseID, AV3004.UnitID,
						AV3004.CurrencyID, AV3004.ExchangeRate, AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03,
						Notes, AT0114.ReTransactionID TransactionID, AT0114.DivisionID,
						S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID '			
				SET @sSQL2 = N'
						FROM AT0114 WITH(NOLOCK)
						LEFT JOIN AV3004_QC AV3004 ON AV3004.VoucherID = AT0114.ReVoucherID AND TransactionID = AT0114.ReTransactionID AND AV3004.DivisionID = AT0114.DivisionID
						INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0114.DivisionID,''@@@'') AND AT1302.InventoryID = AT0114.InventoryID
						WHERE AT0114.DivisionID ='''+@DivisionID+'''
							AND (AT0114.InventoryID BETWEEN '''+@FromInventoryID+''' AND ''' + @ToInventoryID + ''')
							AND ( AT0114.ReVoucherDate <= '''+@ToDateText+''' OR TransactionTypeID = ''T00'' )
							AND (AT0114.WareHouseID BETWEEN '''+@FromWareHouseID+''' AND  ''' + @ToWareHouseID + ''')' 
			END
	IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV3003_QC') EXEC ('CREATE VIEW AV3003_QC AS '+ @sSQL1+@sSQL2 ) ----tao boi AP3006----
	ELSE EXEC ('ALTER VIEW AV3003_QC AS ' + @sSQL1 + @sSQL2) ----tao boi AP3006----
---Print  @sSQL1+@sSQL2

	SET @sSQL1 = N'
	SELECT A.*,
		A10.StandardName AS StandardName01, A11.StandardName AS StandardName02, A12.StandardName AS StandardName03, A13.StandardName AS StandardName04, A14.StandardName AS StandardName05,
		A15.StandardName AS StandardName06, A16.StandardName AS StandardName07, A17.StandardName AS StandardName08, A18.StandardName AS StandardName09, A19.StandardName AS StandardName10,
		A20.StandardName AS StandardName11, A21.StandardName AS StandardName12, A22.StandardName AS StandardName13, A23.StandardName AS StandardName14, A24.StandardName AS StandardName15, 
		A25.StandardName AS StandardName16, A26.StandardName AS StandardName17, A27.StandardName AS StandardName18, A28.StandardName AS StandardName19, A29.StandardName AS StandardName20 
	FROM 
	'
	SET @sSQL2 = '(
		SELECT 1 [Type], InventoryID, InventoryName, VoucherNo, VoucherDate, ReQuantity, ReUnitPrice, NULL OriginalAmount, 
			ReAmount ConvertedAmount, DeQuantity, DeUnitPice, CAST(FromVoucherNo AS NVARCHAR(20)) AS FromVoucherNo, FromVoucherDate, 
			WareHouseID, UnitID, CurrencyID, ExchangeRate, Specification, Notes01, Notes02, Notes03, AV3001_QC.Notes, TransactionID, AV3001_QC.DivisionID,
			S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
		FROM AV3001_QC
		WHERE ReQuantity > 0
		UNION ALL
		SELECT 2 [Type], InventoryID, InventoryName, VoucherNo,VoucherDate, ReQuantity, ReUnitPrice,  OriginalAmount,ConvertedAmount, 
			DeQuantity, DeUnitPice ,FromVoucherNo , FromVoucherDate, WareHouseID, UnitID, CurrencyID, ExchangeRate, Specification,
			Notes01, Notes02, Notes03, AV3002_QC.Notes, TransactionID, AV3002_QC.DivisionID,
			S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
		FROM AV3002_QC
		UNION ALL
		SELECT 3 [Type], InventoryID, InventoryName, VoucherNo, VoucherDate, ReQuantity, ReUnitPrice, NULL OriginalAmount, ReAmount ConvertedAmount,  
			DeQuantity, DeUnitPice, CAST(FromVoucherNo AS NVARCHAR(20)) AS FromVoucherNo , FromVoucherDate, WareHouseID, UnitID, CurrencyID, ExchangeRate, 
			Specification, Notes01, Notes02, Notes03, AV3003_QC.Notes ,TransactionID, AV3003_QC.DivisionID,
			S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
		FROM AV3003_QC
		WHERE ReQuantity > 0 
	) A
	'	
	SET @sSQL3 = N'
		LEFT JOIN AT0128 A10 WITH(NOLOCK) ON A10.StandardID = A.S01ID AND A10.StandardTypeID = ''S01''
		LEFT JOIN AT0128 A11 WITH(NOLOCK) ON A11.StandardID = A.S02ID AND A11.StandardTypeID = ''S02''
		LEFT JOIN AT0128 A12 WITH(NOLOCK) ON A12.StandardID = A.S03ID AND A12.StandardTypeID = ''S03''
		LEFT JOIN AT0128 A13 WITH(NOLOCK) ON A13.StandardID = A.S04ID AND A13.StandardTypeID = ''S04''
		LEFT JOIN AT0128 A14 WITH(NOLOCK) ON A14.StandardID = A.S05ID AND A14.StandardTypeID = ''S05''
		LEFT JOIN AT0128 A15 WITH(NOLOCK) ON A15.StandardID = A.S06ID AND A15.StandardTypeID = ''S06''
		LEFT JOIN AT0128 A16 WITH(NOLOCK) ON A16.StandardID = A.S07ID AND A16.StandardTypeID = ''S07''
		LEFT JOIN AT0128 A17 WITH(NOLOCK) ON A17.StandardID = A.S08ID AND A17.StandardTypeID = ''S08''
		LEFT JOIN AT0128 A18 WITH(NOLOCK) ON A18.StandardID = A.S09ID AND A18.StandardTypeID = ''S09''
		LEFT JOIN AT0128 A19 WITH(NOLOCK) ON A19.StandardID = A.S10ID AND A19.StandardTypeID = ''S10''
		LEFT JOIN AT0128 A20 WITH(NOLOCK) ON A20.StandardID = A.S11ID AND A20.StandardTypeID = ''S11''
		LEFT JOIN AT0128 A21 WITH(NOLOCK) ON A21.StandardID = A.S12ID AND A21.StandardTypeID = ''S12''
		LEFT JOIN AT0128 A22 WITH(NOLOCK) ON A22.StandardID = A.S13ID AND A22.StandardTypeID = ''S13''
		LEFT JOIN AT0128 A23 WITH(NOLOCK) ON A23.StandardID = A.S14ID AND A23.StandardTypeID = ''S14''
		LEFT JOIN AT0128 A24 WITH(NOLOCK) ON A24.StandardID = A.S15ID AND A24.StandardTypeID = ''S15''
		LEFT JOIN AT0128 A25 WITH(NOLOCK) ON A25.StandardID = A.S16ID AND A25.StandardTypeID = ''S16''
		LEFT JOIN AT0128 A26 WITH(NOLOCK) ON A26.StandardID = A.S17ID AND A26.StandardTypeID = ''S17''
		LEFT JOIN AT0128 A27 WITH(NOLOCK) ON A27.StandardID = A.S18ID AND A27.StandardTypeID = ''S18''
		LEFT JOIN AT0128 A28 WITH(NOLOCK) ON A28.StandardID = A.S19ID AND A28.StandardTypeID = ''S19''
		LEFT JOIN AT0128 A29 WITH(NOLOCK) ON A29.StandardID = A.S20ID AND A29.StandardTypeID = ''S20''
'
	
	--PRINT @sSQL1
	--PRINT @sSQL2
	--PRINT @sSQL3
	EXEC (@sSQL1+ @sSQL2 + @sSQL3)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
