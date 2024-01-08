IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP30101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP30101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---- Nhập xuất tồn theo kho (tất cả các kho) (Copy From AP3008)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create ON 13/03/2023 by Hoài Bảo
---- Modified on 29/05/2023 by Anh Đô: Bổ sung order theo kho
---- Modified on 19/12/2023 by Thanh Lượng: [2023/11/TA/0219] - Bổ sung chỉnh sửa điều kiện nếu không nhập "Mặt hàng".
---- Modified ON ... by ...
---- <Example>
---- EXEC WMP30101 @DivisionID=N''1B'',@DivisionIDList=''1B'',@WareHouseID=''CCDC'''',''''HH'',@InventoryID=N''ABC001'',@FromDate=N''2023-03-14 00:00:00'',@ToDate=N''2023-03-14 00:00:00'',@PeriodList=NULL,@IsPeriod=0,@IsGroupID=1,@GroupID1=NULL,@GroupID2=N''I03'',@UserID=N''ASOFTADMIN''

CREATE PROCEDURE WMP30101
(
    @DivisionID		  AS NVARCHAR(50)  = '',
	@DivisionIDList	  AS NVARCHAR(MAX) = '',
    @WareHouseID      AS NVARCHAR(MAX) = '',
    @InventoryID	  AS NVARCHAR(MAX) = '',
    @FromDate         AS DATETIME = NULL,
    @ToDate           AS DATETIME = NULL,
	@PeriodList		  AS NVARCHAR(MAX) = '',
    @IsPeriod         AS TINYINT = 0, -- 0: Theo ngày, 1: Theo kỳ
    @IsGroupID		  AS TINYINT, --- 0 Khong nhom; 1 Nhom 1 cap; 2 Nhom 2 cap
    @GroupID1		  AS NVARCHAR(50),
    @GroupID2		  AS NVARCHAR(50),--- Note : GroupID nhan cac gia tri S1, S2, S3, CI1, CI2, CI3
	@UserID			  AS VARCHAR(50)
)
AS

DECLARE @GroupID VARCHAR(50)

SET @GroupID = (SELECT TOP 1 AT1402.GroupID FROM AT1402 WITH(NOLOCK) WHERE AT1402.UserID = @UserID AND AT1402.DivisionID = @DivisionID)

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC WMP30101_QC @DivisionID, @DivisionIDList, @WareHouseID, @InventoryID, @FromDate, @ToDate, @PeriodList, @IsPeriod, @IsGroupID, @GroupID1, @GroupID2, @UserID
ELSE
BEGIN
	DECLARE
		@sWhere AS NVARCHAR(MAX),
		@sSQL1 AS NVARCHAR(4000), 
		@sSQL2 AS NVARCHAR(4000), 
		@sSQL2a AS NVARCHAR(MAX),
		@sSQL2b AS NVARCHAR(4000),
		@sSQL2c AS NVARCHAR(4000),
		@sSQL3 AS NVARCHAR(4000), 
		@sSQL4 AS NVARCHAR(4000), 
		@sSQLDrop AS NVARCHAR(4000), 
		@GroupField1 AS NVARCHAR(20), 
		@GroupField2 AS NVARCHAR(20),  
		@FromDateText NVARCHAR(20), 
		@ToDateText NVARCHAR(20),
		@sSQL2d AS NVARCHAR(4000),
		@sSQL2e AS NVARCHAR(4000),
		@sWhere1 AS NVARCHAR(MAX) ='',
		@sWhere2 AS NVARCHAR(MAX) ='',
		@sWhere3 AS NVARCHAR(MAX) =''


	SET @sWhere = ''
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

	-- Check Para FromDate và ToDate
	-- Trường hợp search theo từ ngày đến ngày
	IF @IsPeriod = 0
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND (AV7001.VoucherDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (AV7001.VoucherDate <= ''' + @ToDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (AV7001.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
	ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
		BEGIN
			SET @sWhere = @sWhere + ' AND ((SELECT FORMAT(AV7001.VoucherDate, ''MM/yyyy'')) IN (''' + @PeriodList + ''')'
		END

	IF ISNULL(@InventoryID, '') != ''
	BEGIN 
		SET @sWhere1 = @sWhere1 + 'AND AT2008.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))'
		SET @sWhere2 = @sWhere2 + 'AND V7.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))'
		SET @sWhere3 = @sWhere3 + 'AND AV7001.InventoryID IN (SELECT Value FROM dbo.StringSplit(''' +@InventoryID+ ''', '',''))'
	END
	--- Xóa các bảng tạm nếu đã tồn tại
	SET @sSQLDrop='
	IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N''tempdb.dbo.##AV7016'+LTRIM(@@SPID)+''')) 
		DROP TABLE ##AV7016'+LTRIM(@@SPID)+'

	IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N''tempdb.dbo.##AV3088'+LTRIM(@@SPID)+''')) 
		DROP TABLE ##AV3088'+LTRIM(@@SPID)+'

	IF EXISTS (SELECT *	FROM tempdb.dbo.sysobjects WHERE ID = OBJECT_ID(N''tempdb.dbo.##AV3098'+LTRIM(@@SPID)+''')) 
		DROP TABLE ##AV3098'+LTRIM(@@SPID)+'
	'
	EXEC (@sSQLDrop)

	IF @IsPeriod = 1 --theo ky
	BEGIN
		SET @sSQL1 = N'
			SELECT AT2008.InventoryID, AT1302.InventoryName, AT1302.UnitID, AT1302.VATPercent, AT1302.Barcode, AT1309.UnitID AS ConversionUnitID,
			AT1309.ConversionFactor, AT1309.Operator, AT1302.S1, AT1302.S2, AT1302.S3, AT1302.I01ID, AT1302.I02ID, AT1302.I03ID, AT1302.I04ID,
			AT1302.I05ID, AT1302.InventoryTypeID, AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, AT1302.Varchar01, AT1302.Varchar02,
			AT1302.Varchar03,AT1302.Varchar04,AT1302.Varchar05, AT1304.UnitName, AT1303.WareHouseID, AT1303.WareHouseName,
			SUM(CASE WHEN (Case When  AT2008.TranMonth <10 then ''0''+rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) 
										Else rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) End) IN (''' + @PeriodList + ''')
				 THEN ISNULL(BeginQuantity, 0) ELSE 0 END) AS BeginQuantity,

			SUM(CASE WHEN (Case When  AT2008.TranMonth <10 then ''0''+rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) 
										Else rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) End) IN (''' + @PeriodList + ''')
				 THEN ISNULL(EndQuantity, 0) ELSE 0 END) AS EndQuantity,


			'+CASE WHEN ISNULL(@WareHouseID,'') != '' THEN 'SUM(ISNULL(DebitQuantity, 0) - ISNULL(InDebitQuantity, 0))' ELSE 'SUM(ISNULL(DebitQuantity, 0))' END +' AS DebitQuantity,
			'+CASE WHEN Isnull(@WareHouseID,'') != '' THEN 'SUM(ISNULL(CreditQuantity, 0) - ISNULL(InCreditQuantity, 0))' ELSE'SUM(ISNULL(CreditQuantity, 0))' END +'AS CreditQuantity,

			SUM(CASE WHEN (CASE WHEN  AT2008.TranMonth <10 THEN ''0''+rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) 
										ELSE rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) End) IN (''' + @PeriodList + ''')
				 THEN ISNULL(BeginAmount, 0) ELSE 0 END) AS BeginAmount,

			SUM(CASE WHEN (CASE WHEN  AT2008.TranMonth <10 THEN ''0''+rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) 
										ELSE rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) End) IN (''' + @PeriodList + ''')
				 THEN ISNULL(EndAmount, 0) ELSE 0 END) AS EndAmount,


			'+CASE WHEN ISNULL(@WareHouseID,'') != '' THEN 'SUM(ISNULL(DebitAmount, 0) - ISNULL(InDebitAmount, 0))' ELSE 'SUM(ISNULL(DebitAmount, 0)) 'END +'  AS DebitAmount,
			'+CASE WHEN ISNULL(@WareHouseID,'') != '' THEN 'SUM(ISNULL(CreditAmount, 0) - ISNULL(InCreditAmount, 0))'ELSE'SUM(ISNULL(CreditAmount, 0))'  END +' AS CreditAmount,
			SUM(ISNULL(InDebitAmount, 0)) AS InDebitAmount, SUM(ISNULL(InCreditAmount, 0)) AS InCreditAmount, SUM(ISNULL(InDebitQuantity, 0)) AS InDebitQuantity,
			SUM(ISNULL(InCreditQuantity, 0)) AS InCreditQuantity, AT2008.DivisionID
			'
	
		SET @sSQL2 = N'
			INTO ##AV3098'+LTRIM(@@SPID)+'
			FROM AT2008 WITH(NOLOCK)
			INNER JOIN AT1302 WITH(NOLOCK) ON AT1302.DivisionID IN (AT2008.DivisionID,''@@@'') AND AT1302.InventoryID = AT2008.InventoryID
			LEFT JOIN AT1304 WITH(NOLOCK) ON AT1302.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1304.UnitID = AT1302.UnitID AND AT1304.DivisionID IN ('''+@DivisionID+''', ''@@@'')
			INNER JOIN AT1303 WITH(NOLOCK) ON AT1303.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND AT1303.WareHouseID = AT2008.WareHouseID
			LEFT JOIN AT1309 WITH(NOLOCK) ON AT1309.InventoryID = AT2008.InventoryID AND AT1309.UnitID = AT1302.UnitID

			WHERE AT1303.IsTemp = 0 
			AND AT2008.DivisionID IN (''' + IIF(ISNULL(@DivisionIDList, '') != '', @DivisionIDList, @DivisionID) + ''')
			'+@sWhere1+'
			AND (CASE WHEN  AT2008.TranMonth <10 THEN ''0''+rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) 
										ELSE rtrim(ltrim(str(AT2008.TranMonth)))+''/''+ltrim(Rtrim(str(AT2008.TranYear))) End) IN (''' + @PeriodList + ''') '

		SET @sSQL2a =N'AND AT2008.WareHouseID IN (N''' + @WareHouseID + ''') '

		SET @sSQL2b=N'GROUP BY AT2008.InventoryID, InventoryName, AT1302.UnitID, AT1304.UnitName, AT1303.WareHouseID, AT1303.WareHouseName, AT1302.VATPercent, AT1302.Barcode,
			AT1309.UnitID, AT1309.ConversionFactor, AT1309.Operator, AT1302.S1, AT1302.S2, AT1302.S3, AT1302.I01ID, AT1302.I02ID,
			AT1302.I03ID, AT1302.I04ID, AT1302.I05ID, AT1302.InventoryTypeID, AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03,
			AT1302.Varchar01, AT1302.Varchar02, AT1302.Varchar03, AT1302.Varchar04, AT1302.Varchar05, AT2008.DivisionID
			'

		PRINT @sSQL1
		PRINT @sSQL2
		PRINT @sSQL2a
		PRINT @sSQL2b
		EXEC(@sSQL1 + @sSQL2 + @sSQL2a + @sSQL2b)
	END
	ELSE -- theo ngay
	BEGIN	
		SET @sSQL1 = N'
			SELECT V7.DivisionID, V7.InventoryID, V7.InventoryName, V7.UnitID, V7.Barcode, V7.S1, V7.S2, V7.S3, V7.I01ID,
			V7.I02ID, V7.I03ID, V7.I04ID, V7.I05ID, V7.UnitName, V7.VATPercent, V7.InventoryTypeID, V7.Specification, V7.Notes01, V7.Notes02, V7.Notes03,
			V7.Varchar01, V7.Varchar02, V7.Varchar03, V7.Varchar04, V7.Varchar05, SUM(V7.BeginQuantity) AS BeginQuantity, SUM(V7.BeginAmount) AS BeginAmount,
			V7.WareHouseID, V7.WarehouseName
			'
	
		SET @sSQL2 = N' INTO ##AV7016'+LTRIM(@@SPID)+'
			FROM (
				-- Số dư nợ
				SELECT D17.DivisionID, D16.WareHouseID, D03.WarehouseName, D03.FullName AS WHFullName, D16.VoucherDate, D17.InventoryID, D02.InventoryName, D02.UnitID, D02.Barcode,
				D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D04.UnitName, D02.VATPercent, D02.InventoryTypeID, D02.Specification, 
				D02.Notes01 AS Notes01, D02.Notes02 AS Notes02, D02.Notes03 AS Notes03, D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05,
				D17.ActualQuantity AS BeginQuantity, D17.ConvertedAmount AS BeginAmount,''BD'' AS D_C
				FROM AT2017 AS D17 WITH (NOLOCK)
				INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID
				INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
				LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID AND D04.DivisionID IN ('''+@DivisionID+''', ''@@@'')
				INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D03.WareHouseID = D16.WareHouseID
				WHERE ISNULL(D17.DebitAccountID,'''') <> ''''
			'

		SET @sSQL2a=N'	
				UNION ALL -- Số dư có
				SELECT D17.DivisionID, D16.WareHouseID, D03.WareHouseName, D03.FullName AS WHFullName, D16.VoucherDate, D17.InventoryID, D02.InventoryName, D02.UnitID, D02.Barcode,
				D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D04.UnitName, D02.VATPercent, D02.InventoryTypeID, D02.Specification, D02.Notes01 AS Notes01,
				D02.Notes02 AS Notes02, D02.Notes03 AS Notes03, D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05, -D17.ActualQuantity AS BeginQuantity,
				-D17.ConvertedAmount AS BeginAmount,''BC'' AS D_C
				FROM AT2017 AS D17 WITH (NOLOCK)
				INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.VoucherID = D17.VoucherID AND D16.DivisionID = D17.DivisionID
				INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
				LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID AND D04.DivisionID IN ('''+@DivisionID+''', ''@@@'')
				INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.WareHouseID = D16.WareHouseID AND D03.DivisionID IN ('''+@DivisionID+''', ''@@@'')
				WHERE ISNULL(D17.CreditAccountID,'''') <> ''''
			'

		SET @sSQL2b=N'
				UNION ALL -- Nhập kho
				SELECT D07.DivisionID, D06.WareHouseID, D03.WareHouseName, D03.FullName AS WHFullName, D06.VoucherDate, D07.InventoryID, D02.InventoryName, D02.UnitID, D02.Barcode,
				D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D04.UnitName, D02.VATPercent, D02.InventoryTypeID, D02.Specification, 
				D02.Notes01 AS Notes01, D02.Notes02 AS Notes02, D02.Notes03 AS Notes03, D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05,
				D07.ActualQuantity AS BeginQuantity, D07.ConvertedAmount AS BeginAmount,''D'' AS D_C
				FROM AT2007 AS D07 WITH (NOLOCK)
				INNER JOIN AT2006 AS D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
				INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
				LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID AND D04.DivisionID IN ('''+@DivisionID+''', ''@@@'')
				INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D03.WareHouseID = D06.WareHouseID
				WHERE D06.KindVoucherID IN (1' +CASE WHEN ISNULL(@WareHouseID,'') != '' THEN '' ELSE ',3' END + ',5,7,9,15,17) AND ISNULL(D06.TableID,'''') <> ''AT0114''
			'

		SET @sSQL2c=N'
				UNION ALL -- Xuat kho
				SELECT D07.DivisionID, CASE WHEN D06.KindVoucherID = 3 THEN D06.WareHouseID2 ELSE D06.WareHouseID END AS WarehouseID, D03.WarehouseName, 
				D03.FullName AS WHFullName, D06.VoucherDate, D07.InventoryID, D02.InventoryName, D02.UnitID, D02.Barcode, D02.S1, D02.S2, D02.S3, D02.I01ID,
				D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D04.UnitName, D02.VATPercent, D02.InventoryTypeID, D02.Specification, D02.Notes01 AS Notes01,
				D02.Notes02 AS Notes02, D02.Notes03 AS Notes03, D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05,
				-D07.ActualQuantity AS BeginQuantity, -D07.ConvertedAmount AS BeginAmount,''C'' AS D_C
				FROM AT2007 AS D07 WITH (NOLOCK)
				INNER JOIN AT2006 AS D06 WITH (NOLOCK) ON D06.VoucherID = D07.VoucherID AND D06.DivisionID = D07.DivisionID
				INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
				LEFT JOIN AT1304  AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID  AND D04.DivisionID IN ('''+@DivisionID+''', ''@@@'')
				INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D03.WareHouseID = CASE WHEN D06.KindVoucherID = 3 THEN D06.WareHouseID2 ELSE D06.WareHouseID END
				WHERE D06.KindVoucherID IN (2' +CASE WHEN ISNULL(@WareHouseID,'') != '' THEN '' ELSE ',3' END + ',4,6,8,10,14,20)
				) V7
				WHERE V7.DivisionID IN (''' + IIF(ISNULL(@DivisionIDList, '') != '', @DivisionIDList, @DivisionID) + ''')
					  AND (V7.VoucherDate < ''' + @FromDateText + ''' OR V7.D_C = ''BD'') 
					  '+@sWhere2+'
					  '

		SET @sSQL2d = N'AND V7.WareHouseID IN (N''' + @WareHouseID + ''')'

		SET @sSQL2e = N'GROUP BY V7.DivisionID, V7.InventoryID, V7.InventoryName, V7.UnitID, V7.Barcode, V7.S1, V7.S2, V7.S3, V7.I01ID, V7.I02ID, V7.I03ID,
								 V7.I04ID, V7.I05ID, V7.UnitName, V7.VATPercent, V7.InventoryTypeID, V7.Specification, V7.Notes01, V7.Notes02, V7.Notes03, 
								 V7.Varchar01, V7.Varchar02, V7.Varchar03, V7.Varchar04, V7.Varchar05, V7.WareHouseID, V7.WarehouseName
			'

		PRINT @sSQL1
		PRINT @sSQL2
		PRINT @sSQL2a
		PRINT @sSQL2b
		PRINT @sSQL2c
		PRINT @sSQL2d
		PRINT @sSQL2e
		EXEC(@sSQL1 + @sSQL2 + @sSQL2a + @sSQL2b + @sSQL2c + @sSQL2d + @sSQL2e)

		SET @sSQL1 = N'
			SELECT AV7016.DivisionID, InventoryID, InventoryName, UnitID, Barcode, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, VATPercent, InventoryTypeID, Specification, 
			Notes01, Notes02, Notes03, Varchar01, Varchar02, Varchar03, Varchar04, Varchar05, UnitName, BeginQuantity, BeginAmount, 0 AS DebitQuantity, 0 AS CreditQuantity,
			0 AS DebitAmount, 0 AS CreditAmount, 0 AS EndQuantity, 0 AS EndAmount, AV7016.WareHouseID, AV7016.WarehouseName
		'

		SET @sSQL2 = N' INTO ##AV3088'+LTRIM(@@SPID)+'
		FROM ##AV7016'+LTRIM(@@SPID)+' AV7016
		'

		SET @sSQL2a = N'
		UNION ALL

		SELECT AV7001.DivisionID, AV7001.InventoryID, AV7001.InventoryName, AV7001.UnitID, Barcode, AV7001.S1, AV7001.S2, AV7001.S3, AV7001.I01ID, AV7001.I02ID,
		AV7001.I03ID, AV7001.I04ID, AV7001.I05ID, AV7001.VATPercent, AV7001.InventoryTypeID, AV7001.Specification, AV7001.Notes01, AV7001.Notes02, AV7001.Notes03,
		AV7001.Varchar01,AV7001.Varchar02,AV7001.Varchar03,AV7001.Varchar04,AV7001.Varchar05, AV7001.UnitName, 0 AS BeginQuantity, 0 AS BeginAmount, 
		SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7001.ActualQuantity, 0) ELSE 0 END) AS DebitQuantity, 
		SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7001.ActualQuantity, 0) ELSE 0 END) AS CreditQuantity, 
		SUM(CASE WHEN D_C = ''D'' THEN ISNULL(AV7001.ConvertedAmount, 0) ELSE 0 END) AS DebitAmount, 
		SUM(CASE WHEN D_C = ''C'' THEN ISNULL(AV7001.ConvertedAmount, 0) ELSE 0 END) AS CreditAmount, 
		0 AS EndQuantity, 0 AS EndAmount, AV7001.WarehouseID, AV7001.WarehouseName
		'

		SET @sSQL2b =N'
		FROM ( -- Số dư nợ
			SELECT D17.DivisionID, D16.WarehouseID, D03.WarehouseName, D16.VoucherDate, D17.InventoryID, D02.InventoryName, D02.UnitID, D02.Barcode,
			D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.VATPercent, D02.InventoryTypeID, D02.Specification, 
			D02.Notes01, D02.Notes02, D02.Notes03, D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05, 
			D04.UnitName, D17.ActualQuantity, D17.ConvertedAmount, ''BD'' AS D_C, ISNULL(D03.IsTemp,0) AS IsTemp, D03.FullName AS WHFullName
			FROM AT2017 AS D17 WITH (NOLOCK)
			INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.DivisionID = D17.DivisionID AND D16.VoucherID = D17.VoucherID
			INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
			LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID
			INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D03.WareHouseID = D16.WareHouseID
			WHERE ISNULL(D17.DebitAccountID,'''') <> ''''

			UNION ALL -- Số dư có

			SELECT D17.DivisionID, D16.WarehouseID, D03.WarehouseName, D16.VoucherDate, D17.InventoryID, D02.InventoryName, D02.UnitID, D02.Barcode,
			D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.VATPercent, D02.InventoryTypeID, D02.Specification, 
			D02.Notes01, D02.Notes02, D02.Notes03, D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05, 
			D04.UnitName, D17.ActualQuantity, D17.ConvertedAmount, ''BC'' AS D_C, ISNULL(D03.IsTemp,0) AS IsTemp, D03.FullName AS WHFullName
			FROM AT2017 AS D17 WITH (NOLOCK)
			INNER JOIN AT2016 AS D16 WITH (NOLOCK) ON D16.DivisionID = D17.DivisionID AND D16.VoucherID = D17.VoucherID
			INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D17.DivisionID,''@@@'') AND D02.InventoryID = D17.InventoryID
			LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID AND D04.DivisionID IN ('''+@DivisionID+''', ''@@@'')
			INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D03.WareHouseID = D16.WareHouseID
			WHERE ISNULL(D17.CreditAccountID,'''') <> ''''
		'

		SET @sSQL2c=N'
			UNION ALL
			SELECT D07.DivisionID, D06.WarehouseID, D03.WarehouseName, D06.VoucherDate, D07.InventoryID, D02.InventoryName, D02.UnitID, D02.Barcode,
			D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.VATPercent, D02.InventoryTypeID, D02.Specification, 
			D02.Notes01, D02.Notes02, D02.Notes03, D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05, D04.UnitName, D07.ActualQuantity,
			D07.ConvertedAmount, ''D'' AS D_C, ISNULL(D03.IsTemp,0) AS IsTemp, D03.FullName AS WHFullName
			FROM AT2007 AS D07 WITH (NOLOCK)
			INNER JOIN AT2006 AS D06 WITH (NOLOCK) ON D06.DivisionID = D07.DivisionID AND D06.VoucherID = D07.VoucherID
			INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
			LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID AND D04.DivisionID IN ('''+@DivisionID+''', ''@@@'')
			INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D03.WareHouseID = D06.WareHouseID
			WHERE D06.KindVoucherID IN (1' +CASE WHEN ISNULL(@WareHouseID,'') != '' THEN '' ELSE ',3' END + ',5,7,9)

			UNION ALL

			SELECT D07.DivisionID, CASE WHEN D06.KindVoucherID = 3 THEN D06.WareHouseID2 ELSE  D06.WareHouseID END AS WarehouseID, D03.WarehouseName, D06.VoucherDate,
			D07.InventoryID, D02.InventoryName, D02.UnitID, D02.Barcode, D02.S1, D02.S2, D02.S3, D02.I01ID, D02.I02ID, D02.I03ID, D02.I04ID, D02.I05ID, D02.VATPercent,
			D02.InventoryTypeID, D02.Specification, D02.Notes01, D02.Notes02, D02.Notes03, D02.Varchar01, D02.Varchar02, D02.Varchar03, D02.Varchar04, D02.Varchar05, 
			D04.UnitName, D07.ActualQuantity, D07.ConvertedAmount, ''C'' AS D_C, ISNULL(D03.IsTemp,0) AS IsTemp, D03.FullName AS WHFullName
			FROM AT2007 AS D07 WITH (NOLOCK)
			INNER JOIN AT2006 AS D06 WITH (NOLOCK) ON D06.DivisionID = D07.DivisionID AND D06.VoucherID = D07.VoucherID
			INNER JOIN AT1302 AS D02 WITH (NOLOCK) ON D02.DivisionID IN (D07.DivisionID,''@@@'') AND D02.InventoryID = D07.InventoryID
			LEFT JOIN AT1304 AS D04 WITH (NOLOCK) ON D04.UnitID = D02.UnitID  AND D04.DivisionID IN ('''+@DivisionID+''', ''@@@'')
			INNER JOIN AT1303 AS D03 WITH (NOLOCK) ON D03.DivisionID IN ('''+@DivisionID+''', ''@@@'') AND D03.WareHouseID = D06.WareHouseID
			WHERE D06.KindVoucherID IN (2' +CASE WHEN ISNULL(@WareHouseID,'') != '' THEN '' ELSE ',3' END + ',4,10)
		)	AV7001
		'

		SET @sSQL3=N'
		WHERE AV7001.IsTemp = 0
		AND AV7001.D_C IN (''D'', ''C'')
		AND AV7001.DivisionID IN (''' + IIF(ISNULL(@DivisionIDList, '') != '', @DivisionIDList, @DivisionID) + ''')
		'+@sWhere3+'
		' +@sWhere

		SET @sSQL2d =N'AND AV7001.WareHouseID IN (N''' + @WareHouseID + ''')'

		SET @sSQL2e =N'GROUP BY AV7001.DivisionID, AV7001.InventoryID, AV7001.InventoryName, AV7001.UnitID, AV7001.Barcode, AV7001.UnitName,
		AV7001.S1, AV7001.S2, AV7001.S3, AV7001.I01ID, AV7001.I02ID, AV7001.I03ID, AV7001.I04ID, AV7001.I05ID, AV7001.VATPercent, AV7001.InventoryTypeID,
		AV7001.Specification, AV7001.Notes01, AV7001.Notes02, AV7001.Notes03, AV7001.Varchar01,AV7001.Varchar02,AV7001.Varchar03,AV7001.Varchar04,AV7001.Varchar05,
		AV7001.WareHouseID, AV7001.WarehouseName
		'

		PRINT @sSQL1
		PRINT @sSQL2
		PRINT @sSQL2a
		PRINT @sSQL2b
		PRINT @sSQL2c
		PRINT @sSQL3
		PRINT @sSQL2d
		PRINT @sSQL2e
		EXEC (@sSQL1 + @sSQL2 + @sSQL2a + @sSQL2b + @sSQL2c + @sSQL3 + @sSQL2d + @sSQL2e)

		SET @sSQL1 = N'
			SELECT AV3088.InventoryID, InventoryName, AV3088.UnitID, UnitName, AV3088.VATPercent, Barcode, AV3088.InventoryTypeID, Specification,
			AV3088.Notes01, AV3088.Notes02, AV3088.Notes03, AV3088.Varchar01, AV3088.Varchar02, AV3088.Varchar03, AV3088.Varchar04, AV3088.Varchar05,
			AT1309.UnitID AS ConversionUnitID, AT1309.ConversionFactor, AT1309.Operator, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID,
			SUM(BeginQuantity) AS BeginQuantity, SUM(BeginAmount) AS BeginAmount, SUM(DebitQuantity) AS DebitQuantity,
			SUM(CreditQuantity) AS CreditQuantity, SUM(DebitAmount) AS DebitAmount, SUM(CreditAmount) AS CreditAmount,
			0 AS InDebitAmount, 0 AS InCreditAmount, 0 AS InDebitQuantity, 0 AS InCreditQuantity,
			SUM(BeginQuantity) + SUM(DebitQuantity) - SUM(CreditQuantity) AS EndQuantity,
			SUM(BeginAmount) + SUM(DebitAmount) - SUM(CreditAmount) AS EndAmount, AV3088.DivisionID, AV3088.WarehouseID, AV3088.WarehouseName
			'

		SET @sSQL2 = N' INTO ##AV3098'+LTRIM(@@SPID)+'
			FROM ##AV3088'+LTRIM(@@SPID)+' AV3088
			LEFT JOIN AT1309 WITH(NOLOCK) ON AT1309.InventoryID = AV3088.InventoryID AND AT1309.UnitID = AV3088.UnitID AND AT1309.DivisionID IN (''@@@'',AV3088.DivisionID)
			GROUP BY S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, AV3088.InventoryID, InventoryName, AV3088.UnitID, UnitName, AT1309.UnitID,
			AT1309.ConversionFactor, AT1309.Operator, AV3088.VATPercent, Barcode, AV3088.InventoryTypeID, Specification, AV3088.Notes01,
			AV3088.Notes02, AV3088.Notes03, AV3088.Varchar01,AV3088.Varchar02,AV3088.Varchar03,AV3088.Varchar04,AV3088.Varchar05, AV3088.DivisionID,
			AV3088.WareHouseID, AV3088.WareHouseName'
			
		PRINT @sSQL1
		PRINT @sSQL2
		EXEC(@sSQL1 + @sSQL2)
	END --- theo ngay -------------------------------------------------------	
			    
	SET @GroupField1 = 
	(
		SELECT CASE @GroupID1
			WHEN 'CI1' THEN 'S1'
			WHEN 'CI2' THEN 'S2'
			WHEN 'CI3' THEN 'S3'
			WHEN 'I01' THEN 'I01ID'
			WHEN 'I02' THEN 'I02ID'
			WHEN 'I03' THEN 'I03ID'
			WHEN 'I04' THEN 'I04ID'
			WHEN 'I05' THEN 'I05ID' 
		END
	)
	SET @GroupField2 = @GroupField1

	SET @GroupField2 = 
	(
		SELECT CASE @GroupID2
			WHEN 'CI1' THEN 'S1'
			WHEN 'CI2' THEN 'S2'
			WHEN 'CI3' THEN 'S3'
			WHEN 'I01' THEN 'I01ID'
			WHEN 'I02' THEN 'I02ID'
			WHEN 'I03' THEN 'I03ID'
			WHEN 'I04' THEN 'I04ID'
			WHEN 'I05' THEN 'I05ID'
		END
	)

	SET @GroupField1 = ISNULL(@GroupField1, '')
	SET @GroupField2 = ISNULL(@GroupField2, '')
		        
	IF ((@IsGroupID = 1) AND (@GroupField1 <> '') AND (@GroupField2 <> ''))
	BEGIN
		SET @sSQL1 = N'
			SELECT
			V1.ID AS GroupID1, V2.ID AS GroupID2, V1.SName AS GroupName1, V2.SName AS GroupName2, AV3098.InventoryID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID,
			AV3098.InventoryName, AV3098.UnitID, AV3098.UnitName, VATPercent, Barcode, AV3098.InventoryTypeID, AV3098.Specification,
			AV3098.Notes01, AV3098.Notes02, AV3098.Notes03, AV3098.Varchar01,AV3098.Varchar02,AV3098.Varchar03,AV3098.Varchar04,AV3098.Varchar05,
			AV3098.ConversionUnitID, AV3098.ConversionFactor, AV3098.Operator, SUM(AV3098.BeginQuantity) AS BeginQuantity, SUM(AV3098.EndQuantity) AS EndQuantity,
			CASE WHEN AV3098.ConversionFactor = NULL OR AV3098.ConversionFactor = 0 THEN NULL ELSE ISNULL(SUM(AV3098.EndQuantity), 0) / AV3098.ConversionFactor END AS ConversionQuantity,
			SUM(AV3098.DebitQuantity) AS DebitQuantity, SUM(AV3098.CreditQuantity) AS CreditQuantity, SUM(AV3098.BeginAmount) AS BeginAmount, SUM(AV3098.EndAmount) AS EndAmount,
			SUM(AV3098.DebitAmount) AS DebitAmount, SUM(AV3098.CreditAmount) AS CreditAmount, SUM(AV3098.InDebitAmount) AS InDebitAmount, SUM(AV3098.InCreditAmount) AS InCreditAmount,
			SUM(AV3098.InDebitQuantity) AS InDebitQuantity, SUM(AV3098.InCreditQuantity) AS InCreditQuantity, AV3098.DivisionID, AT1314.MinQuantity, AT1314.MaxQuantity,
			N'''+@GroupID+''' AS GroupID, AT1401.GroupName, AV3098.WarehouseID, AV3098.WarehouseName'

		SET @sSQL2 = N'
			FROM ##AV3098'+LTRIM(@@SPID)+' AV3098
			LEFT JOIN AV1310 V1 ON V1.ID = AV3098.' + @GroupField1 + ' AND V1.TypeID =''' + @GroupID1 + ''' AND V1.DivisionID IN (AV3098.DivisionID, ''@@@'')
			LEFT JOIN AV1310 V2 ON V2.ID = AV3098.' + @GroupField2 + ' AND V2.TypeID =''' + @GroupID2 + ''' AND V2.DivisionID IN (AV3098.DivisionID, ''@@@'')
			LEFT JOIN (	SELECT A.InventoryID, SUM(A.MinQuantity) AS MinQuantity, SUM(A.MaxQuantity) AS MaxQuantity, DivisionID
						FROM AT1314 A WITH(NOLOCK) GROUP BY InventoryID, DivisionID ) AT1314
			ON AT1314.DivisionID IN (''@@@'',AV3098.DivisionID) AND AT1314.InventoryID = AV3098.InventoryID
			LEFT JOIN AT1401 WITH (NOLOCK) ON AT1401.GroupID = N''' +@GroupID+ ''' AND AT1401.DivisionID = N''' +@DivisionID+ '''

			WHERE (BeginQuantity <> 0 OR BeginAmount <> 0 OR DebitQuantity <> 0 OR DebitAmount <> 0 OR
			CreditQuantity <> 0 OR CreditAmount <> 0 OR EndQuantity <> 0 OR EndAmount <>0 )
			AND AV3098.DivisionID = ''' + @DivisionID + '''
			
			GROUP BY V1.ID, V2.ID, V1.SName, V2.SName, AV3098.InventoryID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, 
			AV3098.InventoryName, AV3098.UnitID, AV3098.UnitName, VATPercent, Barcode, AV3098.InventoryTypeID, AV3098.Specification, 
			AV3098.Notes01, AV3098.Notes02, AV3098.Notes03, AV3098.Varchar01,AV3098.Varchar02,AV3098.Varchar03,AV3098.Varchar04,AV3098.Varchar05, 
			AV3098.ConversionUnitID, AV3098.ConversionFactor, AV3098.Operator, AV3098.DivisionID,  AT1314.MinQuantity, AT1314.MaxQuantity, AT1401.GroupName,
			AV3098.WarehouseID, AV3098.WarehouseName
			'
	END
	ELSE IF ((@IsGroupID = 1) AND ((@GroupField1 <> '') OR (@GroupField2 <> '')))
	BEGIN
		IF(@GroupField1 = '')
			SET @GroupField1 = @GroupField2
		IF(ISNULL(@GroupID1, '') = '')
			SET @GroupID1 = @GroupID2
		SET @sSQL1 = N'
			SELECT
			V1.ID AS GroupID1, '''' AS GroupID2, V1.SName AS GroupName1, '''' AS GroupName2, AV3098.InventoryID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, 
			AV3098.InventoryName, AV3098.UnitID, AV3098.UnitName, AV3098.VATPercent, Barcode, AV3098.InventoryTypeID, AV3098.Specification, 
			AV3098.Notes01, AV3098.Notes02, AV3098.Notes03, AV3098.Varchar01,AV3098.Varchar02,AV3098.Varchar03,AV3098.Varchar04,AV3098.Varchar05, 
			AV3098.ConversionUnitID, AV3098.ConversionFactor, AV3098.Operator, AV3098.BeginQuantity, AV3098.EndQuantity, 
			CASE WHEN AV3098.ConversionFactor = NULL OR AV3098.ConversionFactor = 0 THEN NULL ELSE ISNULL(AV3098.EndQuantity, 0) / AV3098.ConversionFactor END AS ConversionQuantity, 
			AV3098.DebitQuantity, AV3098.CreditQuantity, AV3098.BeginAmount, AV3098.EndAmount, AV3098.DebitAmount, AV3098.CreditAmount, AV3098.InDebitAmount, AV3098.InCreditAmount,
			AV3098.InDebitQuantity, AV3098.InCreditQuantity, AV3098.DivisionID, AT1314.MinQuantity, AT1314.MaxQuantity, N'''+@GroupID+''' AS GroupID,
			AV3098.WarehouseID, AV3098.WarehouseName'

		SET @sSQL2 = N'
			FROM ##AV3098'+LTRIM(@@SPID)+' AV3098 
			LEFT JOIN AV1310 V1 ON V1.ID = AV3098.' + @GroupField1 + ' AND V1.TypeID =''' + @GroupID1 + ''' AND V1.DivisionID IN (AV3098.DivisionID, ''@@@'')
			LEFT JOIN (	SELECT A.InventoryID, SUM(A.MinQuantity) AS MinQuantity, SUM(A.MaxQuantity) AS MaxQuantity, DivisionID
			FROM AT1314 A WITH(NOLOCK) GROUP BY InventoryID, DivisionID ) AT1314
			ON AT1314.DivisionID IN (''@@@'', AV3098.DivisionID) AND AT1314.InventoryID = AV3098.InventoryID
			LEFT JOIN AT1401 WITH (NOLOCK) ON AT1401.GroupID = N''' +@GroupID+ ''' AND AT1401.DivisionID = N''' +@DivisionID+ '''
			WHERE (BeginQuantity <> 0 OR BeginAmount <> 0 OR DebitQuantity <> 0 OR DebitAmount <> 0 OR
			CreditQuantity <> 0 OR CreditAmount <> 0 OR EndQuantity <> 0 OR EndAmount <>0 ) AND AV3098.DivisionID = ''' + @DivisionID + '''
			'
	END  
	ELSE
	BEGIN
		SET @sSQL1 = N'
		SELECT
		'''' AS GroupID1, '''' AS GroupID2, '''' AS GroupName1, '''' AS GroupName2, AV3098.InventoryID, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, 
		AV3098.InventoryName, AV3098.UnitID, AV3098.UnitName, AV3098.VATPercent, Barcode, AV3098.InventoryTypeID, Specification, 
		AV3098.Notes01, AV3098.Notes02, AV3098.Notes03, AV3098.Varchar01,AV3098.Varchar02,AV3098.Varchar03,AV3098.Varchar04,AV3098.Varchar05, 
		AV3098.ConversionUnitID, AV3098.ConversionFactor, AV3098.Operator, AV3098.BeginQuantity, AV3098.EndQuantity, 
		CASE WHEN AV3098.ConversionFactor = NULL OR AV3098.ConversionFactor = 0 THEN NULL ELSE ISNULL(AV3098.EndQuantity, 0) / AV3098.ConversionFactor END AS ConversionQuantity, 
		AV3098.DebitQuantity, AV3098.CreditQuantity, AV3098.BeginAmount, AV3098.EndAmount, AV3098.DebitAmount, AV3098.CreditAmount, AV3098.InDebitAmount, AV3098.InCreditAmount,
		AV3098.InDebitQuantity, AV3098.InCreditQuantity, AV3098.DivisionID, AT1314.MinQuantity, AT1314.MaxQuantity, N'''+@GroupID+''' AS GroupID,
		AV3098.WarehouseID, AV3098.WarehouseName'

		SET @sSQL2 = N'
		FROM ##AV3098'+LTRIM(@@SPID)+' AV3098 
		LEFT JOIN (SELECT A.InventoryID, SUM(A.MinQuantity) AS MinQuantity, SUM(A.MaxQuantity) AS MaxQuantity, DivisionID
					FROM AT1314 A WITH(NOLOCK) GROUP BY InventoryID, DivisionID ) AT1314
		ON AT1314.DivisionID IN (''@@@'', AV3098.DivisionID) AND AT1314.InventoryID = AV3098.InventoryID
		LEFT JOIN AT1401 WITH (NOLOCK) ON AT1401.GroupID = N''' +@GroupID+ ''' AND AT1401.DivisionID = N''' +@DivisionID+ '''
		WHERE (BeginQuantity <> 0 OR BeginAmount <> 0 OR DebitQuantity <> 0 OR DebitAmount <> 0 OR
		CreditQuantity <> 0 OR CreditAmount <> 0 OR EndQuantity <> 0 OR EndAmount <> 0 )
		AND AV3098.DivisionID = ''' + @DivisionID + '''
		ORDER BY AV3098.WarehouseID
		'
	END
	PRINT (@sSQL1 + @sSQL2)		
	EXEC (@sSQL1 + @sSQL2)
END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
