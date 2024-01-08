IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP30121]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP30121]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
--- Lay du lieu in bao cao nhap xuart ton FIFO! (Clone từ sotre AP3005)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Tấn Lộc - Creadate:20/04/2023
-- <Example>
/*
    AP3005 'HT',4,4,2012,2012,'01/01/2012','04/25/2012','K01','K99','0000000001','0000000001',0
*/


CREATE PROCEDURE WMP30121
(
	@DivisionID VARCHAR(50) = '',		
	@DivisionIDList	  AS NVARCHAR(MAX) = '',
	@WareHouseID      AS NVARCHAR(MAX) = '',
	@InventoryID	  AS NVARCHAR(MAX) = '',
	@FromDate AS DATETIME = NULL,
	@ToDate AS DATETIME ,
	@PeriodList	AS NVARCHAR(MAX) = '',
	@IsPeriod	AS TINYINT = 0, -- 0: Theo ngày, 1: Theo kỳ
	@UserID	AS VARCHAR(50)
)
AS

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	--EXEC WMP30121_QC @DivisionID,@DivisionIDList, @WareHouseID, @InventoryID, @FromDate, @ToDate, @PeriodList, @IsPeriod, @UserID
	print (N'EXEC WMP30121_QC')
END
ELSE
BEGIN
	DECLARE @sWhere AS NVARCHAR(MAX),
			@sWhere1 AS NVARCHAR(MAX),
			@sWhere2 AS NVARCHAR(MAX),
			@sWhere3 AS NVARCHAR(MAX),
            @sSQL1 NVARCHAR(MAX),
			@sSQL2 NVARCHAR(MAX),
			@sSQL3 NVARCHAR(MAX),
			@sSQL4 NVARCHAR(MAX), 
			@FromMonthYearText NVARCHAR(20), 
			@ToMonthYearText NVARCHAR(20), 
			@FromDateText NVARCHAR(20), 
			@ToDateText NVARCHAR(20),
			@sWhereInventoryID_AT0114 NVARCHAR(MAX),
			@sWhereInventoryID_AT0115 NVARCHAR(MAX)
	    
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
		SET @sWhereInventoryID_AT0114 = 'AND 1=1'
	SET @sWhereInventoryID_AT0115 = 'AND 1=1'

	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
	IF @IsPeriod = 0
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				-- Dùng cho những chỗ đang select từ bảng AT0114 (Quản lý nhập xuất kho theo lô)
				SET @sWhere = @sWhere + ' AND (AT0114.ReVoucherDate >= ''' + @FromDateText + ''')'
				-- Dùng cho những chỗ đang select từ bảng AT0115 (Bảng tính giá FIFO)
				SET @sWhere1 = @sWhere1 + ' AND (AT0115.VoucherDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				-- Dùng cho những chỗ đang select từ bảng AT0114 (Quản lý nhập xuất kho theo lô)
				SET @sWhere = @sWhere + ' AND (AT0114.ReVoucherDate <= ''' + @ToDateText + ''')'
				-- Dùng cho những chỗ đang select từ bảng AT0115 (Bảng tính giá FIFO)
				SET @sWhere1 = @sWhere1 + ' AND (AT0115.VoucherDate <= ''' + @ToDateText + ''')'

			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				-- Dùng cho những chỗ đang select từ bảng AT0114 (Quản lý nhập xuất kho theo lô)
				SET @sWhere = @sWhere + ' AND (AT0114.ReVoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
				-- Dùng cho những chỗ đang select từ bảng AT0115 (Bảng tính giá FIFO)
				SET @sWhere1 = @sWhere1 + ' AND (AT0115.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
	ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND ((SELECT FORMAT(AT0115.VoucherDate, ''MM/yyyy'')) IN (''' + @PeriodList + ''')'
		END

IF @IsPeriod = 1 --- theo ky 
BEGIN
	--Tao veiw AV3001- So du dau ky
SET	@sSQL1 = N'
	SELECT DISTINCT	AT0114.InventoryID, AT1302.InventoryName, ReVoucherNo VoucherNo, ReVoucherDate VoucherDate, 
		ReQuantity = AT0114.ReQuantity - ISNULL((SELECT SUM(PriceQuantity) FROM AT0115 WITH(NOLOCK)
													WHERE ((CASE WHEN  AT0115.TranMonth <10 THEN ''0''+rtrim(ltrim(str(AT0115.TranMonth)))+''/''+ltrim(Rtrim(str(AT0115.TranYear))) 
																ELSE rtrim(ltrim(str(AT0115.TranMonth)))+''/''+ltrim(Rtrim(str(AT0115.TranYear))) End) IN (''' + @PeriodList + '''))
															AND ReTransactionID = AT0114.ReTransactionID And DivisionID = AT0115.DivisionID), 0),

		ReAmount = Av3004.ConvertedAmount  - ISNULL((SELECT SUM(ConvertedAmount) FROM AT0115 WITH(NOLOCK)
														WHERE ((CASE WHEN  AT0115.TranMonth <10 THEN ''0''+rtrim(ltrim(str(AT0115.TranMonth)))+''/''+ltrim(Rtrim(str(AT0115.TranYear))) 
																ELSE rtrim(ltrim(str(AT0115.TranMonth)))+''/''+ltrim(Rtrim(str(AT0115.TranYear))) End) IN (''' + @PeriodList + '''))
															AND ReTransactionID = AT0114.ReTransactionID And DivisionID = AT0114.DivisionID), 0),

		AT0114.UnitPrice ReUnitPrice, NULL DeQuantity, NULL DeUnitPice, NULL FromVoucherNo , NULL FromVoucherDate,
		AT0114.WareHouseID, AV3004.UnitID,  AV3004.CurrencyID, AV3004.ExchangeRate, AT1302.Specification, AT1302.Notes01,
		AT1302.Notes02, AT1302.Notes03, Notes, AT0114.ReTransactionID TransactionID, AT0114.DivisionID '
	
SET @sSQL2 = N'
			FROM AT0114 WITH(NOLOCK)
				LEFT JOIN AV3004 ON AV3004.VoucherID = AT0114.ReVoucherID AND AV3004.TransactionID = AT0114.ReTransactionID AND AV3004.DivisionID = AT0114.DivisionID
				INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0114.DivisionID,''@@@'') AND AT1302.InventoryID = AT0114.InventoryID
			WHERE AT0114.DivisionID IN (''' + IIF(ISNULL(@DivisionIDList, '') != '', @DivisionIDList, @DivisionID) + ''') 
				AND AT0114.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))
				AND AT0114.WareHouseID IN (N''' + @WareHouseID + ''')
				AND ((CASE WHEN  AT0114.ReTranMonth <10 THEN ''0''+rtrim(ltrim(str(AT0114.ReTranMonth)))+''/''+ltrim(Rtrim(str(AT0114.ReTranYear))) 
							ELSE rtrim(ltrim(str(AT0114.ReTranMonth)))+''/''+ltrim(Rtrim(str(AT0114.ReTranYear))) End) IN (''' + @PeriodList + ''')
						OR TransactionTypeID =''T00'') '
		
END
ELSE
BEGIN
SET @sSQL1 = N'
	SELECT DISTINCT	AT0114.InventoryID, AT1302.InventoryName, ReVoucherNo VoucherNo, ReVoucherDate VoucherDate, 
		ReQuantity = ReQuantity - ISNULL((SELECT SUM(PriceQuantity) FROM AT0115 WITH(NOLOCK) 
													  WHERE'+@sWhere1+'
													  AND ReTransactionID = AT0114.ReTransactionID And DivisionID = AT0115.DivisionID), 0),
		ReAmount = AV3004.ConvertedAmount  - ISNULL((SELECT SUM(ConvertedAmount) FROM AT0115 WITH(NOLOCK) 
													  WHERE'+@sWhere1+'
													 AND ReTransactionID = AT0114.ReTransactionID AND DivisionID = AT0114.DivisionID), 0),
		AT0114.UnitPrice ReUnitPrice, NULL DeQuantity, NULL DeUnitPice, NULL FromVoucherNo, NULL FromVoucherDate,
		AT0114.WareHouseID, AV3004.UnitID, AV3004.CurrencyID, AV3004.ExchangeRate, AT1302.Specification, AT1302.Notes01,
		AT1302.Notes02, AT1302.Notes03, Notes, AT0114.ReTransactionID TransactionID, AT0114.DivisionID '
			
SET @sSQL2 = N'
	FROM AT0114 WITH(NOLOCK)
		LEFT JOIN AV3004 ON AV3004.VoucherID = AT0114.ReVoucherID AND AV3004.TransactionID = AT0114.ReTransactionID AND AV3004.DivisionID = AT0114.DivisionID
		INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0114.DivisionID,''@@@'') AND AT1302.InventoryID = AT0114.InventoryID
	WHERE AT0114.DivisionID IN (''' + IIF(ISNULL(@DivisionIDList, '') != '', @DivisionIDList, @DivisionID) + ''') 
	AND AT0114.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))
	AND AT0114.WareHouseID IN (N''' + @WareHouseID + ''')
	AND ((CASE WHEN  AT2008.TranMonth <10 THEN ''0''+rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) 
										ELSE rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) End) IN (''' + @PeriodList + ''') 
										OR TransactionTypeID =''T00'') '
END
Print @sSQL1
Print @sSQL2
Print @sSQL3
Print @sSQL4

IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype ='V' AND Name ='AV3001') EXEC ('CREATE VIEW AV3001 AS '+ @sSQL1+  @sSQL2)----tao boi WMP30121----
ELSE EXEC('ALTER VIEW AV3001 AS '+@sSQL1+  @sSQL2) ----tao boi WMP30121----

-----------Tao View AV3002 -Phat sinh trong ky
IF @IsPeriod = 1    -- theo kỳ
BEGIN
SET @sSQL1 = N'
	SELECT DISTINCT	AT0114.InventoryID, AT1302.InventoryName, AT0114.ReVoucherNo VoucherNo, AT0114.ReVoucherDate VoucherDate,
		ReQuantity, AT0114.UnitPrice ReUnitPrice, PriceQuantity DeQuantity, AT0115.UnitPrice DeUnitPice, AT2007.OriginalAmount,
		AT2007.ConvertedAmount, NULL FromVoucherNo, NULL FromVoucherDate, AT0114.WareHouseID, AT2007.UnitID,CurrencyID,ExchangeRate,
		AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, Notes,  AT0114.ReTransactionID TransactionID, AT0114.DivisionID '		
		
SET @sSQL2= N'
	FROM AT0114 WITH(NOLOCK)
		LEFT JOIN AT0115 WITH(NOLOCK) ON AT0115.TransactionID = AT0114.ReTransactionID AND AT0115.DivisionID = AT0114.DivisionID
		INNER JOIN AT2007 WITH(NOLOCK) ON AT2007.VoucherID = AT0114.ReVoucherID AND AT2007.DivisionID = AT0114.DivisionID AND AT2007.TransactionID = AT0114.ReTransactionID 
		INNER JOIN AT1302 WITH(NOLOCK) on AT1302.DivisionID IN (AT0114.DivisionID,''@@@'') AND AT1302.InventoryID = AT0114.InventoryID
	WHERE AT0114.DivisionID IN (''' + IIF(ISNULL(@DivisionIDList, '') != '', @DivisionIDList, @DivisionID) + ''') 
		AND AT0114.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))
		AND AT0114.WareHouseID IN (N''' + @WareHouseID + ''')
		AND (CASE WHEN  AT0114.ReTranMonth <10 THEN ''0''+rtrim(ltrim(str(AT0114.ReTranMonth)))+''/''+ltrim(Rtrim(str(AT0114.ReTranYear))) 
										ELSE rtrim(ltrim(str(AT0114.ReTranMonth)))+''/''+ltrim(Rtrim(str(AT0114.ReTranYear))) End) IN (''' + @PeriodList + ''') 
UNION ALL'
SET @sSQL3 = N'
	SELECT DISTINCT	AT0115.InventoryID, AT1302.InventoryName, VoucherNo DeVoucherNo, VoucherDate DeVoucherDate, NULL ReQuantity,
		NULL ReUnitPrice, PriceQuantity DeQuantity, AT0115.UnitPrice DeUnitPice, NULL OriginalAmount, NULL ConvertedAmount,
		AT0115.ReVoucherNo FromVoucherNo, AT0115.ReVoucherDate FromVoucherDate, AT0115.WareHouseID, AT2007. UnitID,CurrencyID,
		ExchangeRate, AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, Notes,  AT0115.TransactionID, AT0115.DivisionID '
SET @sSQL4 = N'
	FROM AT0115 WITH(NOLOCK)
		LEFT JOIN AT2007 WITH(NOLOCK) ON AT2007.VoucherID = AT0115.ReVoucherID AND AT2007.TransactionID = AT2007.RETransactionID AND AT2007.DivisionId = AT2007.DivisionID
		INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0115.DivisionID,''@@@'') AND AT1302.InventoryID = AT0115.InventoryID
		WHERE AT0115.DivisionID IN (''' + IIF(ISNULL(@DivisionIDList, '') != '', @DivisionIDList, @DivisionID) + ''') 
		AND AT0115.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))
		AND AT0115.WareHouseID IN (N''' + @WareHouseID + ''')
		AND (CASE WHEN  AT0115.TranMonth <10 THEN ''0''+rtrim(ltrim(str(AT0115.TranMonth)))+''/''+ltrim(Rtrim(str(AT0115.TranYear))) 
										ELSE rtrim(ltrim(str(AT0115.TranMonth)))+''/''+ltrim(Rtrim(str(AT0115.TranYear))) End) IN (''' + @PeriodList + ''')'
END
ELSE
BEGIN
SET @sSQL1 = N'
	SELECT DISTINCT	AT0114.InventoryID, AT1302.InventoryName, AT0114.ReVoucherNo VoucherNo, AT0114.ReVoucherDate VoucherDate,
		ReQuantity, AT0114.UnitPrice ReUnitPrice, PriceQuantity DeQuantity, AT0115.UnitPrice DeUnitPice, AT2007.OriginalAmount,
		AT2007.ConvertedAmount, NULL FromVoucherNo, NULL FromVoucherDate, AT0114.WareHouseID, AT2007.UnitID, CurrencyID,ExchangeRate,
		AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, Notes, AT0114.ReTransactionID as TransactionID, AT0114.DivisionID '
SET @sSQL2 = N'
	FROM AT0114 WITH(NOLOCK)
		LEFT JOIN AT0115 WITH(NOLOCK) ON AT0115.TransactionID = AT0114.ReTransactionID AND AT0115.DivisionID = AT0114.DivisionID
		INNER JOIN AT2007 WITH(NOLOCK) ON AT2007.VoucherID = AT0114.ReVoucherID AND AT2007.DivisionID = AT0114.DivisionID AND AT2007.TransactionID = AT0114.ReTransactionID 
		INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0114.DivisionID,''@@@'') AND AT1302.InventoryID = AT0114.InventoryID
	WHERE AT0114.DivisionID IN (''' + IIF(ISNULL(@DivisionIDList, '') != '', @DivisionIDList, @DivisionID) + ''')
		AND AT0114.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))
		AND AT0114.WareHouseID IN (N''' + @WareHouseID + ''') 
		'+@sWhere+'
UNION ALL'
SET @sSQL3 = N'
	SELECT AT0115.InventoryID, AT1302.InventoryName, VoucherNo DeVoucherNo, VoucherDate DeVoucherDate, NULL ReQuantity,
		NULL ReUnitPrice, PriceQuantity DeQuantity, AT0115.UnitPrice DeUnitPice, NULL OriginalAmount, NULL ConvertedAmount,
		AT0115.ReVoucherNo FromVoucherNo, AT0115.ReVoucherDate FromVoucherDate, AT0115.WareHouseID, AT2007.UnitID, CurrencyID,
		ExchangeRate, AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, Notes, AT0115.TransactionID, AT0115.DivisionID '
SET @sSQL4 = N'
	FROM AT0115 WITH(NOLOCK)
		LEFT JOIN AT2007 WITH(NOLOCK) ON AT2007.VoucherID = AT0115.ReVoucherID AND AT2007.TransactionID = AT0115.RETransactionID AND AT2007.DivisionID = AT0115.DivisionID
		INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0115.DivisionID,''@@@'') AND AT1302.InventoryID = AT0115.InventoryID
	WHERE AT0115.DivisionID IN (''' + IIF(ISNULL(@DivisionIDList, '') != '', @DivisionIDList, @DivisionID) + ''')
		AND AT0115.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))
		AND AT0115.WareHouseID IN (N''' + @WareHouseID + ''')
		'+@sWhere1+' '			
END
--Print @sSQL1
--Print @sSQL2
--Print @sSQL3
--Print @sSQL4

IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' and Name = 'AV3002') EXEC ('CREATE VIEW AV3002 AS '+ @sSQL1+@sSQL2+@sSQL3+@sSQL4 ) ----tao boi WMP30121----
ELSE EXEC ('ALTER VIEW AV3002 AS ' + @sSQL1 + @sSQL2 + @sSQL3 + @sSQL4) ----tao boi WMP30121----
-----Tao Veiw AV3003 --Ton cuoi ky
IF @IsPeriod = 1 -- theo kỳ
BEGIN
SET @sSQL1= N'
	SELECT DISTINCT	AT0114.InventoryID, AT1302.InventoryName, ReVoucherNo VoucherNo, ReVoucherDate VoucherDate,
		ReQuantity = ReQuantity - ISNULL((SELECT SUM(PriceQuantity) FROM AT0115 WITH(NOLOCK)
										  WHERE ((CASE WHEN  AT0115.TranMonth <10 THEN ''0''+rtrim(ltrim(str(AT0115.TranMonth)))+''/''+ltrim(Rtrim(str(AT0115.TranYear))) 
														ELSE rtrim(ltrim(str(AT0115.TranMonth)))+''/''+ltrim(Rtrim(str(AT0115.TranYear))) End) IN (''' + @PeriodList + '''))

										  AND ReTransactionID = AT0114.ReTransactionID 
										  AND DivisionID = AT0115.DivisionID), 0),

		 ReAmount = AV3004.ConvertedAmount - ISNULL((SELECT SUM(ConvertedAmount) FROM AT0115 WITH(NOLOCK)
										 WHERE ((CASE WHEN  AT0115.TranMonth <10 THEN ''0''+rtrim(ltrim(str(AT0115.TranMonth)))+''/''+ltrim(Rtrim(str(AT0115.TranYear))) 
													ELSE rtrim(ltrim(str(AT0115.TranMonth)))+''/''+ltrim(Rtrim(str(AT0115.TranYear))) End) IN (''' + @PeriodList + '''))
										AND ReTransactionID = AT0114.ReTransactionID
										AND DivisionID = AT0115.DivisionID), 0),

		AT0114.UnitPrice ReUnitPrice, NULL DeQuantity, NULL DeUnitPice, NULL FromVoucherNo, NULL FromVoucherDate, AT0114.WareHouseID, AV3004.UnitID, AV3004.CurrencyID,
		AV3004.ExchangeRate, AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, Notes, AT0114.ReTransactionID as TransactionID, AT0114.DivisionID '
SET @sSQL2 = N'
	FROM AT0114 WITH(NOLOCK)
		LEFT JOIN AV3004 ON AV3004.VoucherID = AT0114.ReVoucherID AND TransactionID = AT0114.ReTransactionID AND AV3004.DivisionID = AT0114.DivisionID
		INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0114.DivisionID,''@@@'') AND AT1302.InventoryID =AT0114.InventoryID
	WHERE AT0114.DivisionID IN (''' + IIF(ISNULL(@DivisionIDList, '') != '', @DivisionIDList, @DivisionID) + ''')
		AND AT0114.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))
		AND AT0114.WareHouseID IN (N''' + @WareHouseID + ''')
		AND ((CASE WHEN  AT0114.ReTranMonth <10 THEN ''0''+rtrim(ltrim(str(AT0114.ReTranMonth)))+''/''+ltrim(Rtrim(str(AT0114.ReTranYear))) 
					ELSE rtrim(ltrim(str(AT0114.ReTranMonth)))+''/''+ltrim(Rtrim(str(AT0114.ReTranYear))) End) IN (''' + @PeriodList + ''')
				OR TransactionTypeID =''T00'')'
END
ELSE
BEGIN
SET @sSQL1 = N'
	SELECT DISTINCT	AT0114.InventoryID, AT1302.InventoryName, ReVoucherNo VoucherNo, ReVoucherDate VoucherDate,
		ReQuantity = ReQuantity - ISNULL((SELECT SUM(PriceQuantity) FROM AT0115 WITH(NOLOCK)
										  WHERE'+@sWhere1+'
										  AND ReTransactionID = AT0114.ReTransactionID And DivisionID = AT0115.DivisionID), 0),

		ReAmount = AV3004.ConvertedAmount  - ISNULL((SELECT SUM(ConvertedAmount) FROM AT0115 WITH(NOLOCK)
											WHERE'+@sWhere1+'
											AND ReTransactionID = AT0114.ReTransactionID
											AND DivisionID = AT0115.DivisionID), 0),
		AT0114.UnitPrice ReUnitPrice, NULL DeQuantity, NULL DeUnitPice, NULL FromVoucherNo, NULL FromVoucherDate, AT0114.WareHouseID, AV3004.UnitID,
		AV3004.CurrencyID, AV3004.ExchangeRate, AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03,
		Notes, AT0114.ReTransactionID TransactionID, AT0114.DivisionID '			
SET @sSQL2 = N'
	FROM AT0114 WITH(NOLOCK)
		LEFT JOIN AV3004 ON AV3004.VoucherID = AT0114.ReVoucherID AND TransactionID = AT0114.ReTransactionID AND AV3004.DivisionID = AT0114.DivisionID
		INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT0114.DivisionID,''@@@'') AND AT1302.InventoryID = AT0114.InventoryID
	WHERE AT0114.DivisionID IN (''' + IIF(ISNULL(@DivisionIDList, '') != '', @DivisionIDList, @DivisionID) + ''')
		AND AT0114.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))
		AND AT0114.WareHouseID IN (N''' + @WareHouseID + ''')
		'+@sWhere+'
		OR TransactionTypeID = ''T00''' 
END
IF NOT EXISTS (SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV3003') EXEC ('CREATE VIEW AV3003 AS '+ @sSQL1+@sSQL2 ) ----tao boi WMP30121----
ELSE EXEC ('ALTER VIEW AV3003 AS ' + @sSQL1 + @sSQL2) ----tao boi WMP30121----
---Print  @sSQL1+@sSQL2

SET @sSQL1 = N'
	SELECT 1 [Type], InventoryID, InventoryName, VoucherNo, VoucherDate, ISNULL(ReQuantity,0) AS ReQuantity, ISNULL(ReUnitPrice,0) AS ReUnitPrice, NULL OriginalAmount, 
		ISNULL(ReAmount,0) AS ConvertedAmount, ISNULL(DeQuantity,0) AS DeQuantity, ISNULL(DeUnitPice,0) AS DeUnitPice, CAST(FromVoucherNo AS NVARCHAR(20)) AS FromVoucherNo, FromVoucherDate, 
		WareHouseID, UnitID, CurrencyID, ExchangeRate, Specification, Notes01, Notes02, Notes03, Notes, TransactionID, DivisionID,
		ISNULL(DeQuantity,0)* ISNULL(DeUnitPice,0) AS DeConvertedAmount'
	
SET @sSQL2 = N'
	FROM AV3001
	WHERE ReQuantity > 0
UNION ALL
	SELECT 2 [Type], InventoryID, InventoryName, VoucherNo,VoucherDate, ISNULL(ReQuantity,0) AS ReQuantity, ISNULL(ReUnitPrice,0) AS ReUnitPrice,  OriginalAmount,ISNULL(ConvertedAmount,0) AS ConvertedAmount, 
		ISNULL(DeQuantity,0) AS DeQuantity, ISNULL(DeUnitPice,0) AS DeUnitPice, FromVoucherNo , FromVoucherDate, WareHouseID, UnitID, CurrencyID, ExchangeRate, Specification,
		Notes01, Notes02, Notes03, Notes, TransactionID, DivisionID,
		ISNULL(DeQuantity,0)* ISNULL(DeUnitPice,0) AS DeConvertedAmount
	FROM AV3002
UNION ALL'
SET @sSQL3 = N'
	SELECT 3 [Type], InventoryID, InventoryName, VoucherNo, VoucherDate, ISNULL(ReQuantity,0) AS ReQuantity, ISNULL(ReUnitPrice,0) AS ReUnitPrice, NULL OriginalAmount, ISNULL(ReAmount,0) AS ConvertedAmount,  
		ISNULL(DeQuantity,0) AS DeQuantity, ISNULL(DeUnitPice,0) AS DeUnitPice, CAST(FromVoucherNo AS NVARCHAR(20)) AS FromVoucherNo , FromVoucherDate, WareHouseID, UnitID, CurrencyID, ExchangeRate, 
		Specification, Notes01, Notes02, Notes03, Notes ,TransactionID, DivisionID,
		ISNULL(DeQuantity,0)* ISNULL(DeUnitPice,0) AS DeConvertedAmount
	FROM AV3003
	WHERE ReQuantity > 0 '

	EXEC (@sSQL1+ @sSQL2 + @sSQL3)
	print (@sSQL1+ @sSQL2 + @sSQL3)
		--If not Exists (Select 1 From  sysObjects Where Xtype ='V' and Name ='AV3005')
		--	Exec(' Create view AV3005 as '+ @sSQL1+ @sSQL2 + @sSQL3 ) ----tao boi WMP30121----
		--Else
		--	Exec(' Alter view AV3005 as '+@sSQL1+ @sSQL2 + @sSQL3) ----tao boi WMP30121----
END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
