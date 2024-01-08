IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP2007]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP2007]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



/********************************************
'* Edited by: [GS] [Minh Lâm] [02/08/2010]
'********************************************/
---- Created by Nguyen Van Nhan, Date 08/12/2003.
---- Purpose: Bao cao ton kho theo kho theo tai khoan
---- Edited by Nguyen Quoc Huy, Date 06/11/2006
---- Edited by: Dang Le Bao Quynh; Date 04/07/2008
---- Purpose: Them truong WareHouseName
---- Modified by Thanh Sơn on 16/07/2014: lấy dữ liệu trực tiếp từ store, không sinh ra view AV2007
---- Modified by Mai Duyen on 16/01/2015: Bo sung AT1302.Barcode
---- Modified by Tiểu Mai on 20/06/2016: Bổ sung in báo cáo theo thông tin quy cách và WITH (NOLOCK)
---- Modify on 24/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified on 18/10/2018 by Kim Thư: Bổ sung lọc báo cáo theo ngày
---- Modified on 18/02/2019 by Kim Thư: Sửa danh mục dùng chung (bỏ kết theo DivisionID) AT1302
---- Modified by Kim Thư on 22/04/2019: Bổ sung thêm trường nhóm người dùng (GroupID), TRUYỀN @UserID 
---- Modified by Kim Thư on 10/05/2019: Sửa lỗi load thiếu dữ liệu in theo ngày
---- Modified by Kim Thư on 17/07/2019: Xử lý lấy WarehouseID trường hợp VCNB (in theo ngày)
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Thông on 27/01/2021: [Phúc Long] 2021/01/IS/0367: Sửa lỗi cú pháp
---- Modified by Thành Sang on 03/06/2022: [VIETSCREW_HT] 2022/04/IS/0307: Sửa accountID lấy theo dữ liệu đầu kỳ
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

-- Ex: exec AP2007 @DivisionID=N'MP',@FromMonth=4,@FromYear=2019,@ToMonth=4,@ToYear=2019,@WareHouseID=N'K04',@FromAccountID=N'152',@ToAccountID=N'158',
--     @FromDate='2019-04-22 10:22:45.317',@ToDate='2019-04-22 10:22:45.303',@IsDate=0, @UserID='ASOFTADMIN'

CREATE PROCEDURE [dbo].[AP2007]
       @DivisionID AS nvarchar(50) ,
       @FromMonth AS int ,
       @FromYear AS int ,
       @ToMonth AS int ,
       @ToYear AS int ,
	   @IsDate AS TINYINT,
	   @FromDate AS DATETIME,
	   @ToDate AS DATETIME,
       @WareHouseID AS nvarchar(50) ,
       @FromAccountID AS nvarchar(50) ,
       @ToAccountID AS nvarchar(50),
	   @UserID nvarchar(50)
AS

DECLARE @GroupID VARCHAR(50)
SET @GroupID = (SELECT TOP 1 AT1402.GroupID FROM AT1402 WHERE AT1402.UserID = @UserID)

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
	EXEC AP2007_QC @DivisionID, @FromMonth, @FromYear, @ToMonth, @ToYear, @WareHouseID, @FromAccountID, @ToAccountID, @UserID
ELSE
BEGIN 
	IF @IsDate=0 -- THEO KỲ
	BEGIN
		DECLARE
			@sSQLSelect AS nvarchar(4000) ,
			@sSQLFrom AS nvarchar(4000) ,
			@sSQLWhere AS nvarchar(4000), 
			@FromMonthYearText NVARCHAR(20), 
			@ToMonthYearText NVARCHAR(20)
    
		SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
		SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)

		--B/c cho 1 ky
		IF @FromMonth + @FromYear * 100 = @ToMonth + 100 * @ToYear
		BEGIN
			SET @sSQLSelect = '
			Select   AT2008.DivisionID, AT2008.WareHouseID, AT1303.WareHouseName,AT2008.InventoryID, InventoryName,
			AT1302.Barcode,
			AT1302.UnitID, AT1302.InventoryTypeID,
			AT1302.S1, AT1302.S2, AT1302.S3,AT1304.UnitName,
			AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03,
			AT2008.InventoryAccountID, AT1005.AccountName,  
			Sum(isnull(BeginQuantity,0)) as BeginQuantity,
			sum(isnull(EndQuantity,0)) as EndQuantity,
			Sum(isnull(DebitQuantity,0)) as DebitQuantity,
			Sum(isnull(CreditQuantity,0)) as CreditQuantity,
			Sum(isnull(BeginAmount,0)) as BeginAmount,
			Sum(isnull(EndAmount,0)) as EndAmount,
			Sum(isnull(DebitAmount,0)) as DebitAmount,
			Sum(isnull(CreditAmount,0)) as CreditAmount,
			Sum(isnull(InDebitAmount,0)) as InDebitAmount,
			Sum(isnull(InCreditAmount,0)) as InCreditAmount,
			Sum(isnull(InDebitQuantity,0)) as InDebitQuantity,
			Sum(isnull(InCreditQuantity,0)) as InCreditQuantity,
			'''+@GroupID+''' as GroupID, 
			(SELECT AT1401.GroupName FROM AT1401 WITH(NOLOCK) WHERE AT1401.DivisionID = AT2008.DivisionID AND AT1401.GroupID = '''+@GroupID+''' ) AS GroupName
			'

			SET @sSQLFrom = ' From AT2008 WITH (NOLOCK) 	inner join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AT2008.DivisionID,''@@@'') AND AT1302.InventoryID =AT2008.InventoryID
			inner join AT1304 WITH (NOLOCK) on AT1302.DivisionID IN (AT1304.DivisionID,''@@@'') AND AT1304.UnitID = AT1302.UnitID
			Left join AT1005 WITH (NOLOCK) on AT1005.AccountID = AT2008.InventoryAccountID
			Left Join AT1303 WITH (NOLOCK) On AT1303.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND AT2008.WareHouseID = AT1303.WareHouseID
			'

			SET @sSQLWhere = ' Where 	--AT1302.Disabled = 0 and
			AT2008.DivisionID =''' + @DivisionID + ''' and
			(AT2008.InventoryAccountID between ''' + @FromAccountID + ''' and ''' + @ToAccountID + ''') and
			AT2008.WareHouseID like ''' + @WareHouseID + ''' and
			( TranMonth  +100*TranYear  between ' + @FromMonthYearText + ' and ' + @ToMonthYearText + ') 
			Group by AT2008.DivisionID, AT2008.WareHouseID, AT1303.WareHouseName, AT2008.InventoryID,	InventoryName,	AT1302.Barcode, AT1302.UnitID,	AT1304.UnitName, 	AT1302.InventoryTypeID, AT1302.S1, AT1302.S2,  AT1302.S3,   
				AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, AT2008.InventoryAccountID, AT1005.AccountName '
		END
		ELSE --B/c cho nhieu ky
		BEGIN
			SET @sSQLSelect = '
				Select   AT2008.DivisionID, AT2008.WareHouseID, AT1303.WareHouseName, AT2008.InventoryID, AT1302.InventoryName,
				AT1302.Barcode,
				AT1302.UnitID,AT1304.UnitName,	
				AT2008.InventoryAccountID, AT1302.InventoryTypeID,
				AT1005.AccountName,
				AT1302.S1, AT1302.S2, AT1302.S3,
				AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03,
				BeginQuantity = isnull((Select Sum(isnull(BeginQuantity,0)) From AT2008 T08 WITH (NOLOCK) Where 	T08.InventoryID = AT2008.InventoryID and 
												T08.InventoryAccountID = AT2008.InventoryAccountID and
												T08.DivisionID = ''' + @DivisionID + ''' and
												T08.TranMonth + T08.TranYear*100 = ' + @FromMonthYearText + ' and
												T08.WareHouseID like ''' + @WareHouseID + '''  ),0) ,
				EndQuantity = isnull((Select Sum(isnull(EndQuantity,0)) From AT2008 T08 WITH (NOLOCK) Where 	T08.InventoryID = AT2008.InventoryID and 
												T08.InventoryAccountID = AT2008.InventoryAccountID and
												T08.DivisionID = ''' + @DivisionID + ''' and
												T08.TranMonth + T08.TranYear*100 = ' + @ToMonthYearText + ' and
												T08.WareHouseID like ''' + @WareHouseID + '''  ) ,0),
				sum(isnull(DebitQuantity,0)) as DebitQuantity,
				sum(isnull(CreditQuantity,0)) as CreditQuantity,
				BeginAmount = isnull((Select Sum(isnull(BeginAmount,0)) From AT2008 T08 WITH (NOLOCK) Where 	T08.InventoryID = AT2008.InventoryID and 
												T08.InventoryAccountID = AT2008.InventoryAccountID and
												T08.DivisionID = ''' + @DivisionID + ''' and
												T08.TranMonth + T08.TranYear*100 = ' + @FromMonthYearText + ' and
												T08.WareHouseID like ''' + @WareHouseID + '''  ),0) ,
				EndAmount = isnull((Select Sum(isnull(EndAmount,0)) From AT2008 T08 WITH (NOLOCK) Where 	T08.InventoryID = AT2008.InventoryID and 
												T08.InventoryAccountID = AT2008.InventoryAccountID and
												T08.DivisionID = ''' + @DivisionID + ''' and
												T08.TranMonth + T08.TranYear*100 = ' + @ToMonthYearText + ' and
												T08.WareHouseID like ''' + @WareHouseID + '''  ) ,0),
	
				Sum(isnull(DebitAmount,0)) as DebitAmount,
				sum(isnull(CreditAmount,0)) as CreditAmount,
				Sum(isnull(InDebitAmount,0)) as InDebitAmount,
				Sum(isnull(InCreditAmount,0)) as InCreditAmount,
				Sum(isnull(InDebitQuantity,0)) as InDebitQuantity,
				Sum(isnull(InCreditQuantity,0)) as InCreditQuantity,
				'''+@GroupID+''' as GroupID,
				(SELECT AT1401.GroupName FROM AT1401 WITH(NOLOCK) WHERE AT1401.DivisionID = AT2008.DivisionID AND AT1401.GroupID = '''+@GroupID+''' ) AS GroupName 
				'

			SET @sSQLFrom = 'From AT2008 WITH (NOLOCK) 	inner join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AT2008.DivisionID,''@@@'') AND At1302.InventoryID =AT2008.InventoryID
				inner join AT1304 WITH (NOLOCK) on AT1302.DivisionID IN (AT1304.DivisionID,''@@@'') AND AT1304.UnitID = AT1302.UnitID
				Left join AT1005 WITH (NOLOCK) on AT1005.AccountID = AT2008.InventoryAccountID
				Left Join AT1303 WITH (NOLOCK) On AT1303.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND AT2008.WareHouseID = AT1303.WareHouseID
				'
			SET @sSQLWhere = 'Where --AT1302.Disabled = 0 and
				AT2008.DivisionID =''' + @DivisionID + ''' and
				(AT2008.InventoryAccountID between ''' + @FromAccountID + ''' and ''' + @ToAccountID + ''') and
				AT2008.WareHouseID like ''' + @WareHouseID + ''' and
				( TranMonth  +100*TranYear  between ' + @FromMonthYearText + ' and ' + @ToMonthYearText + ') 
				Group by AT2008.DivisionID, AT2008.WareHouseID, AT1303.WareHouseName, AT2008.InventoryID,	AT1302.InventoryName, AT1302.Barcode,	AT1302.UnitID,	AT1304.UnitName,
				 AT2008.InventoryAccountID, 	AT1302.InventoryTypeID, 	AT1005.AccountName,
				AT1302.S1,	AT1302.S2, 	AT1302.S3 , AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03
		 '
		END

		IF EXISTS ( SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV2017' )
		BEGIN
				DROP VIEW AV2017
		END
		EXEC ( ' Create view AV2017 as '+ @sSQLSelect + @sSQLFrom + @sSQLWhere)

		SET @sSQLSelect = ' Select * From AV2017 		
		Where 	(BeginQuantity <> 0 or EndQuantity<>0 or DebitQuantity<>0 or CreditQuantity<>0 or BeginAmount<>0 or EndAmount <>0 or DebitAmount<>0 or
			CreditAmount<>0) '

		IF EXISTS ( SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV2007' )
		BEGIN
				DROP VIEW AV2007
		END
		EXEC (@sSQLSelect )
	END
	ELSE --THEO NGÀY
	BEGIN
		DECLARE @SQL NVARCHAR(MAX),
				@SQL1A NVARCHAR(MAX),
				@SQL1B NVARCHAR(MAX),
				@SQL2 NVARCHAR(MAX),
				@SQL3 NVARCHAR(MAX),
				@SQL4A NVARCHAR(MAX),
				@SQL4B NVARCHAR(MAX),
				@SQL5 NVARCHAR(MAX),
				@SQL6 NVARCHAR(MAX),
				@FromDateText VARCHAR(50),
				@ToDateText VARCHAR(50)
			
		SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)  
		SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'  

		CREATE TABLE #TEMP (DivisionID VARCHAR(50),InventoryID VARCHAR(50), InventoryName NVARCHAR(MAX),UnitID VARCHAR(50), UnitName NVARCHAR(250),InventoryTypeID VARCHAR(50),
		Specification NVARCHAR(250),Notes01 NVARCHAR(250),Notes02 NVARCHAR(250),Notes03 NVARCHAR(250),AccountID VARCHAR(50),AccountName NVARCHAR(MAX),
		BeginQuantity DECIMAL(28,8) DEFAULT(0),BeginAmount DECIMAL(28,8) DEFAULT(0),DebitQuantity DECIMAL(28,8) DEFAULT(0), DebitAmount DECIMAL(28,8) DEFAULT(0),
		CreditQuantity DECIMAL(28,8) DEFAULT(0), CreditAmount DECIMAL(28,8) DEFAULT(0), EndQuantity DECIMAL(28,8) DEFAULT(0),EndAmount DECIMAL(28,8) DEFAULT(0),
		InDebitQuantity DECIMAL(28,8) DEFAULT(0), InDebitAmount DECIMAL(28,8) DEFAULT(0),InCreditQuantity DECIMAL(28,8) DEFAULT(0),InCreditAmount DECIMAL(28,8) DEFAULT(0),
		S1 NVARCHAR(50), S2 NVARCHAR(50),S3 NVARCHAR(50), I01ID NVARCHAR(50), I02ID NVARCHAR(50),I03ID NVARCHAR(50),I04ID NVARCHAR(50),I05ID NVARCHAR(50),
		I01Name NVARCHAR(250), I02Name NVARCHAR(250),I03Name NVARCHAR(250), I04Name NVARCHAR(250),I05Name NVARCHAR(250),Barcode NVARCHAR(50),
		WareHouseID NVARCHAR(50), WareHouseName NVARCHAR(250), GroupID NVARCHAR(50) )


		-- Tính tồn đầu
		-- Số dư đầu kỳ
		SET @SQL='
			SELECT TEMP1.DivisionID, TEMP1.WareHouseID, TEMP1.WareHouseName, TEMP1.InventoryID, TEMP1.InventoryName, TEMP1.UnitID, TEMP1.UnitName, TEMP1.InventoryTypeID, TEMP1.Specification, TEMP1.Notes01, TEMP1.Notes02, TEMP1.Notes03,
									TEMP1.AccountID, TEMP1.AccountName, SUM(TEMP1.ActualQuantity) AS BeginQuantity, SUM(TEMP1.ConvertedAmount) AS BeginAmount,
									TEMP1.I01ID, TEMP1.I02ID, TEMP1.I03ID, TEMP1.I04ID, TEMP1.I05ID, TEMP1.I01Name, TEMP1.I02Name, TEMP1.I03Name, TEMP1.I04Name, TEMP1.I05Name, TEMP1.Barcode,
									TEMP1.S1, TEMP1.S2, TEMP1.S3
			INTO #TEMP1
			FROM (
			SELECT A1.DivisionID, A2.WareHouseID, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, 
					A3.Notes01, A3.Notes02, A3.Notes03,
					A1.DebitAccountID AS AccountID, A5.AccountName, A1.ActualQuantity, A1.ConvertedAmount,
					A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
					I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode,
					A3.S1, A3.S2, A3.S3
			FROM AT2017 A1 WITH (NOLOCK) INNER JOIN AT2016 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.DivisionID IN (A1.DivisionID,''@@@'') AND A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.DivisionID IN (A4.DivisionID,''@@@'') AND A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.DivisionID IN (A5.DivisionID,''@@@'') AND A3.AccountID = A5.AccountID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON A3.DivisionID IN (I01.DivisionID,''@@@'') AND I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON A3.DivisionID IN (I02.DivisionID,''@@@'') AND I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON A3.DivisionID IN (I03.DivisionID,''@@@'') AND I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON A3.DivisionID IN (I04.DivisionID,''@@@'') AND I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON A3.DivisionID IN (I05.DivisionID,''@@@'') AND I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A2.WarehouseID = A6.WarehouseID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.DebitAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+'''
				AND A2.WareHouseID like ''' + @WareHouseID + '''
			'
		
		SET @SQL1A='
			UNION ALL
			-- Nhập trước @FromDateText
			SELECT A1.DivisionID, A2.WareHouseID, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, 
					A3.Notes01, A3.Notes02, A3.Notes03,
					A1.DebitAccountID, A5.AccountName, A1.ActualQuantity, A1.ConvertedAmount,
					A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
					I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode,
					A3.S1, A3.S2, A3.S3
			FROM AT2007 A1 WITH (NOLOCK) INNER JOIN AT2006 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.DivisionID IN (A1.DivisionID,''@@@'') AND A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.DivisionID IN (A4.DivisionID,''@@@'') AND A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.DivisionID IN (A5.DivisionID,''@@@'') AND A3.AccountID = A5.AccountID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON A3.DivisionID IN (I01.DivisionID,''@@@'') AND I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON A3.DivisionID IN (I02.DivisionID,''@@@'') AND I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON A3.DivisionID IN (I03.DivisionID,''@@@'') AND I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON A3.DivisionID IN (I04.DivisionID,''@@@'') AND I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON A3.DivisionID IN (I05.DivisionID,''@@@'') AND I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A2.WarehouseID = A6.WarehouseID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.DebitAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+'''
					AND A2.KindVoucherID in (1,3,5,7,9,15,17)
					AND A2.VoucherDate < '''+@FromDateText+'''
					AND A2.WareHouseID like ''' + @WareHouseID + '''
			UNION ALL '
			--Xuất trước @FromDateText
			SET @SQL1B = 'SELECT A1.DivisionID, CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END AS WareHouseID, A6.WareHouseName, A1.InventoryID, 
					A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
					A1.CreditAccountID, A5.AccountName, -A1.ActualQuantity AS ActualQuantity, -A1.ConvertedAmount AS OriginalAmount,
					A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
					I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode,
					A3.S1, A3.S2, A3.S3
			FROM AT2007 A1 WITH (NOLOCK) INNER JOIN AT2006 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.DivisionID IN (A1.DivisionID,''@@@'') AND A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.DivisionID IN (A4.DivisionID,''@@@'') AND A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.DivisionID IN (A5.DivisionID,''@@@'') AND A3.AccountID = A5.AccountID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON A3.DivisionID IN (I01.DivisionID,''@@@'') AND I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON A3.DivisionID IN (I02.DivisionID,''@@@'') AND I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON A3.DivisionID IN (I03.DivisionID,''@@@'') AND I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON A3.DivisionID IN (I04.DivisionID,''@@@'') AND I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON A3.DivisionID IN (I05.DivisionID,''@@@'') AND I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND (CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END = A6.WarehouseID)
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.CreditAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+'''
					AND A2.KindVoucherID in (2,3,4,6,8,10,14,20)
					AND A2.VoucherDate < '''+@FromDateText+'''
					AND CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END like ''' + @WareHouseID + '''
			) TEMP1
			GROUP BY TEMP1.DivisionID, TEMP1.WareHouseID, TEMP1.WareHouseName, TEMP1.InventoryID, TEMP1.InventoryName, TEMP1.UnitID, TEMP1.UnitName, TEMP1.InventoryTypeID, TEMP1.Specification, TEMP1.Notes01, TEMP1.Notes02, TEMP1.Notes03,
					TEMP1.AccountID, TEMP1.AccountName, TEMP1.I01ID, TEMP1.I02ID, TEMP1.I03ID, TEMP1.I04ID, TEMP1.I05ID, TEMP1.I01Name, TEMP1.I02Name, TEMP1.I03Name, TEMP1.I04Name, TEMP1.I05Name, TEMP1.Barcode,
					TEMP1.S1, TEMP1.S2, TEMP1.S3
			'
		
		SET @SQL2='
			--Tính nhập từ @FromDateText -> @ToDateText
			SELECT A1.DivisionID, A2.WareHouseID, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, 
					A3.Notes01, A3.Notes02, A3.Notes03,
					A1.DebitAccountID, A5.AccountName, SUM(A1.ActualQuantity) AS DebitQuantity, SUM(A1.ConvertedAmount) AS DebitAmount,
					A3.S1, A3.S2, A3.S3, A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
					I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode
			INTO #TEMP2_IM
			FROM AT2007 A1 WITH (NOLOCK) INNER JOIN AT2006 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.DivisionID IN (A1.DivisionID,''@@@'') AND A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.DivisionID IN (A4.DivisionID,''@@@'') AND A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.DivisionID IN (A5.DivisionID,''@@@'') AND A3.AccountID = A5.AccountID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON A3.DivisionID IN (I01.DivisionID,''@@@'') AND I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON A3.DivisionID IN (I02.DivisionID,''@@@'') AND I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON A3.DivisionID IN (I03.DivisionID,''@@@'') AND I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON A3.DivisionID IN (I04.DivisionID,''@@@'') AND I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON A3.DivisionID IN (I05.DivisionID,''@@@'') AND I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A2.WarehouseID = A6.WarehouseID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.DebitAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+'''
					AND A2.KindVoucherID in (1,3,5,7,9,15,17)
					AND A2.VoucherDate BETWEEN '''+@FromDateText+''' AND '''+@ToDateText+'''
					AND A2.WareHouseID like ''' + @WareHouseID + '''
			GROUP BY  A1.DivisionID, A2.WareHouseID, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
									A1.DebitAccountID, A5.AccountName, A3.S1, A3.S2, A3.S3, A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName,I02.AnaName,
									I03.AnaName,I04.AnaName,I05.AnaName,A3.Barcode
			'
		SET @SQL3='
			--Tính xuất từ @FromDateText -> @ToDateText
			SELECT A1.DivisionID, CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END AS WareHouseID, A6.WareHouseName, A1.InventoryID, 
					A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
					A1.CreditAccountID, A5.AccountName, SUM(A1.ActualQuantity) AS CreditQuantity, SUM(A1.ConvertedAmount) AS CreditAmount,
					A3.S1, A3.S2, A3.S3, A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
					I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode
			INTO #TEMP2_EX
			FROM AT2007 A1 WITH (NOLOCK) INNER JOIN AT2006 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.DivisionID IN (A1.DivisionID,''@@@'') AND A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.DivisionID IN (A4.DivisionID,''@@@'') AND A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.DivisionID IN (A5.DivisionID,''@@@'') AND A3.AccountID = A5.AccountID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON A3.DivisionID IN (I01.DivisionID,''@@@'') AND I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON A3.DivisionID IN (I02.DivisionID,''@@@'') AND I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON A3.DivisionID IN (I03.DivisionID,''@@@'') AND I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON A3.DivisionID IN (I04.DivisionID,''@@@'') AND I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON A3.DivisionID IN (I05.DivisionID,''@@@'') AND I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND (CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END = A6.WarehouseID)
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.CreditAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+'''
					AND A2.KindVoucherID in (2,3,4,6,8,10,14,20)
					AND A2.VoucherDate BETWEEN '''+@FromDateText+''' AND '''+@ToDateText+'''
					AND CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END like ''' + @WareHouseID + '''
			GROUP BY A1.DivisionID, CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
									A1.CreditAccountID, A5.AccountName, A3.S1, A3.S2, A3.S3,A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName,I02.AnaName,
									I03.AnaName,I04.AnaName,I05.AnaName, A3.Barcode
			'

		SET @SQL4A='
			-- Tính số lượng nhập VCNB
			SELECT A1.DivisionID, A2.WareHouseID, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, 
						A3.Notes01, A3.Notes02, A3.Notes03, A3.S1, A3.S2, A3.S3, A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
						I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode,
						A1.DebitAccountID, A5.AccountName, SUM(A1.ActualQuantity) AS InDebitQuantity, SUM(A1.ConvertedAmount) AS InDebitAmount
			INTO #TEMP3_IM
			FROM AT2007 A1 WITH (NOLOCK) INNER JOIN AT2006 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.DivisionID IN (A1.DivisionID,''@@@'') AND A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.DivisionID IN (A4.DivisionID,''@@@'') AND A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.DivisionID IN (A5.DivisionID,''@@@'') AND A3.AccountID = A5.AccountID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A2.WarehouseID = A6.WarehouseID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON A3.DivisionID IN (I01.DivisionID,''@@@'') AND I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON A3.DivisionID IN (I02.DivisionID,''@@@'') AND I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON A3.DivisionID IN (I03.DivisionID,''@@@'') AND I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON A3.DivisionID IN (I04.DivisionID,''@@@'') AND I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON A3.DivisionID IN (I05.DivisionID,''@@@'') AND I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.DebitAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND A2.KindVoucherID = 3
				AND A2.WareHouseID like ''' + @WareHouseID + ''''

			SET @SQL4B= ' GROUP BY A1.DivisionID, A2.WareHouseID, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
						A1.DebitAccountID, A5.AccountName, A3.S1, A3.S2, A3.S3,A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName,I02.AnaName,
						I03.AnaName,I04.AnaName,I05.AnaName, A3.Barcode

			-- Tính số lượng xuất VCNB
			SELECT A1.DivisionID, A2.WareHouseID2 AS WareHouseID, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
						A3.S1, A3.S2, A3.S3, A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
						I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode,
						A1.CreditAccountID, A5.AccountName, SUM(A1.ActualQuantity) AS InCreditQuantity, SUM(A1.ConvertedAmount) AS InCreditAmount
			INTO #TEMP3_EX
			FROM AT2007 A1 WITH (NOLOCK) INNER JOIN AT2006 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A3.DivisionID IN (A1.DivisionID,''@@@'') AND A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.DivisionID IN (A4.DivisionID,''@@@'') AND A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.DivisionID IN (A5.DivisionID,''@@@'') AND A3.AccountID = A5.AccountID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A2.WarehouseID2 = A6.WarehouseID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON A3.DivisionID IN (I01.DivisionID,''@@@'') AND I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON A3.DivisionID IN (I02.DivisionID,''@@@'') AND I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON A3.DivisionID IN (I03.DivisionID,''@@@'') AND I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON A3.DivisionID IN (I04.DivisionID,''@@@'') AND I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON A3.DivisionID IN (I05.DivisionID,''@@@'') AND I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.CreditAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND A2.KindVoucherID = 3
				AND A2.WareHouseID2 like ''' + @WareHouseID + '''
			GROUP BY A1.DivisionID, A2.WareHouseID2, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
						A1.CreditAccountID, A5.AccountName, A3.S1, A3.S2, A3.S3,A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName,I02.AnaName,
						I03.AnaName,I04.AnaName,I05.AnaName, A3.Barcode
			'
		

		SET @SQL5='
			INSERT INTO #TEMP (DivisionID, WareHouseID, WareHouseName, InventoryID, InventoryName, UnitID, UnitName, InventoryTypeID, Specification, Notes01, Notes02, Notes03,
								AccountID, AccountName, BeginQuantity, BeginAmount, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, I01Name, I02Name, I03Name, I04Name, I05Name, 
								Barcode)
			SELECT #TEMP1.DivisionID,  #TEMP1.WareHouseID, #TEMP1.WareHouseName, #TEMP1.InventoryID, #TEMP1.InventoryName, #TEMP1.UnitID, #TEMP1.UnitName, #TEMP1.InventoryTypeID, 
					#TEMP1.Specification, #TEMP1.Notes01, #TEMP1.Notes02, #TEMP1.Notes03, #TEMP1.AccountID, #TEMP1.AccountName, #TEMP1.BeginQuantity, #TEMP1.BeginAmount, 
					#TEMP1.S1, #TEMP1.S2, #TEMP1.S3, #TEMP1.I01ID, #TEMP1.I02ID, #TEMP1.I03ID, #TEMP1.I04ID, #TEMP1.I05ID, #TEMP1.I01Name, #TEMP1.I02Name, #TEMP1.I03Name, 
					#TEMP1.I04Name, #TEMP1.I05Name, #TEMP1.Barcode 
			FROM #TEMP1
			

			INSERT INTO #TEMP (DivisionID, WareHouseID, WareHouseName, InventoryID, InventoryName, UnitID, UnitName, InventoryTypeID, Specification, Notes01, Notes02, Notes03,
								AccountID, AccountName, DebitQuantity, DebitAmount, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, I01Name, I02Name, I03Name, I04Name, I05Name, 
								Barcode)
			SELECT #TEMP2_IM.DivisionID, #TEMP2_IM.WareHouseID, #TEMP2_IM.WareHouseName, #TEMP2_IM.InventoryID, #TEMP2_IM.InventoryName, #TEMP2_IM.UnitID, #TEMP2_IM.UnitName, 
					#TEMP2_IM.InventoryTypeID, #TEMP2_IM.Specification, #TEMP2_IM.Notes01, #TEMP2_IM.Notes02, #TEMP2_IM.Notes03, #TEMP2_IM.DebitAccountID, #TEMP2_IM.AccountName, 
					#TEMP2_IM.DebitQuantity, #TEMP2_IM.DebitAmount, #TEMP2_IM.S1, #TEMP2_IM.S2, #TEMP2_IM.S3, #TEMP2_IM.I01ID, #TEMP2_IM.I02ID, #TEMP2_IM.I03ID, 
					#TEMP2_IM.I04ID, #TEMP2_IM.I05ID, #TEMP2_IM.I01Name, #TEMP2_IM.I02Name,
					#TEMP2_IM.I03Name, #TEMP2_IM.I04Name, #TEMP2_IM.I05Name, #TEMP2_IM.Barcode 
			FROM #TEMP2_IM


			INSERT INTO #TEMP (DivisionID, WareHouseID, WareHouseName, InventoryID, InventoryName, UnitID, UnitName, InventoryTypeID, Specification, Notes01, Notes02, Notes03,
							AccountID, AccountName, CreditQuantity, CreditAmount, S1, S2, S3, I01ID,I02ID,I03ID,I04ID,I05ID,I01Name,I02Name,
							I03Name,I04Name,I05Name,Barcode)
			SELECT #TEMP2_EX.DivisionID, #TEMP2_EX.WareHouseID, #TEMP2_EX.WareHouseName, #TEMP2_EX.InventoryID, #TEMP2_EX.InventoryName, #TEMP2_EX.UnitID, #TEMP2_EX.UnitName, 
					#TEMP2_EX.InventoryTypeID, #TEMP2_EX.Specification, #TEMP2_EX.Notes01, #TEMP2_EX.Notes02, #TEMP2_EX.Notes03,
					#TEMP2_EX.CreditAccountID, #TEMP2_EX.AccountName, #TEMP2_EX.CreditQuantity, #TEMP2_EX.CreditAmount, #TEMP2_EX.S1, #TEMP2_EX.S2, #TEMP2_EX.S3,
					#TEMP2_EX.I01ID,#TEMP2_EX.I02ID,#TEMP2_EX.I03ID,#TEMP2_EX.I04ID,#TEMP2_EX.I05ID,#TEMP2_EX.I01Name,#TEMP2_EX.I02Name,
					#TEMP2_EX.I03Name,#TEMP2_EX.I04Name,#TEMP2_EX.I05Name,#TEMP2_EX.Barcode
			FROM #TEMP2_EX

			INSERT INTO #TEMP (DivisionID, WareHouseID, WareHouseName, InventoryID, InventoryName, UnitID, UnitName, InventoryTypeID, Specification, Notes01, Notes02, Notes03,
								AccountID, AccountName, InDebitQuantity, InDebitAmount, S1, S2, S3, I01ID,I02ID,I03ID,
								I04ID,I05ID, I01Name, I02Name, I03Name, I04Name, I05Name, Barcode)
			SELECT #TEMP3_IM.DivisionID, #TEMP3_IM.WareHouseID, #TEMP3_IM.WareHouseName, #TEMP3_IM.InventoryID, #TEMP3_IM.InventoryName, #TEMP3_IM.UnitID, #TEMP3_IM.UnitName, 
					#TEMP3_IM.InventoryTypeID, #TEMP3_IM.Specification, #TEMP3_IM.Notes01, #TEMP3_IM.Notes02, #TEMP3_IM.Notes03,
					#TEMP3_IM.DebitAccountID, #TEMP3_IM.AccountName, #TEMP3_IM.InDebitQuantity, #TEMP3_IM.InDebitAmount,#TEMP3_IM.S1,#TEMP3_IM.S2,#TEMP3_IM.S3, #TEMP3_IM.I01ID,#TEMP3_IM.I02ID,#TEMP3_IM.I03ID,
					#TEMP3_IM.I04ID,#TEMP3_IM.I05ID, #TEMP3_IM.I01Name, #TEMP3_IM.I02Name, #TEMP3_IM.I03Name, #TEMP3_IM.I04Name, #TEMP3_IM.I05Name, #TEMP3_IM.Barcode
			FROM #TEMP3_IM

			INSERT INTO #TEMP (DivisionID, WareHouseID, WareHouseName, InventoryID, InventoryName, UnitID, UnitName, InventoryTypeID, Specification, Notes01, Notes02, Notes03,
								AccountID, AccountName, InCreditQuantity, InCreditAmount, S1, S2, S3,
								I01ID, I02ID, I03ID, I04ID, I05ID, I01Name, I02Name, I03Name, I04Name, I05Name,Barcode
								)
			SELECT #TEMP3_EX.DivisionID, #TEMP3_EX.WareHouseID, #TEMP3_EX.WareHouseName, #TEMP3_EX.InventoryID, #TEMP3_EX.InventoryName, #TEMP3_EX.UnitID, #TEMP3_EX.UnitName, 
					#TEMP3_EX.InventoryTypeID, #TEMP3_EX.Specification, #TEMP3_EX.Notes01, #TEMP3_EX.Notes02, #TEMP3_EX.Notes03,
					#TEMP3_EX.CreditAccountID, #TEMP3_EX.AccountName, #TEMP3_EX.InCreditQuantity, #TEMP3_EX.InCreditAmount, #TEMP3_EX.S1, #TEMP3_EX.S2, #TEMP3_EX.S3,
					#TEMP3_EX.I01ID, #TEMP3_EX.I02ID, #TEMP3_EX.I03ID, #TEMP3_EX.I04ID, #TEMP3_EX.I05ID, #TEMP3_EX.I01Name, #TEMP3_EX.I02Name, #TEMP3_EX.I03Name, #TEMP3_EX.I04Name, #TEMP3_EX.I05Name,#TEMP3_EX.Barcode
			FROM #TEMP3_EX
		'
		SET @SQL6='
			SELECT #TEMP.DivisionID, #TEMP.InventoryID, #TEMP.InventoryName, #TEMP.UnitID, #TEMP.UnitName, #TEMP.InventoryTypeID,
					#TEMP.Specification, #TEMP.Notes01, #TEMP.Notes02, #TEMP.Notes03, #TEMP.AccountID, #TEMP.AccountName,
					sum(#TEMP.BeginQuantity) as BeginQuantity, sum(#TEMP.BeginAmount) as BeginAmount,
					sum(#TEMP.DebitQuantity) as DebitQuantity, sum(#TEMP.DebitAmount) as DebitAmount,
					sum(#TEMP.CreditQuantity) as CreditQuantity , sum(#TEMP.CreditAmount) as CreditAmount, 
					sum(#TEMP.BeginQuantity)+SUM(#TEMP.DebitQuantity)-sum(#TEMP.CreditQuantity) AS EndQuantity,
					sum(#TEMP.BeginAmount)+sum(#TEMP.DebitAmount)-sum(#TEMP.CreditAmount) as EndAmount,
					sum(#TEMP.InDebitQuantity) as InDebitQuantity, sum(#TEMP.InDebitAmount) as InDebitAmount, 
					sum(#TEMP.InCreditQuantity) as InCreditQuantity, sum(#TEMP.InCreditAmount) as InCreditAmount,
					#TEMP.S1, #TEMP.S2, #TEMP.S3,
					#TEMP.I01ID, #TEMP.I02ID, #TEMP.I03ID, #TEMP.I04ID, #TEMP.I05ID, #TEMP.I01Name, #TEMP.I02Name, #TEMP.I03Name,
					#TEMP.I04Name, #TEMP.I05Name, #TEMP.Barcode, #TEMP.WareHouseID, #TEMP.WareHouseName, '''+@GroupID+''' as GroupID, 
					(SELECT TOP 1 AT1401.GroupName FROM AT1401 WITH(NOLOCK) WHERE AT1401.DivisionID = #TEMP.DivisionID AND AT1401.GroupID = '''+@GroupID+''' ) AS GroupName

			FROM #TEMP
			WHERE  #TEMP.BeginQuantity<>0 OR #TEMP.BeginAmount<>0 
					OR #TEMP.DebitQuantity<>0 OR #TEMP.DebitAmount<>0
					OR #TEMP.CreditQuantity<>0 OR #TEMP.CreditAmount<>0
			GROUP BY #TEMP.DivisionID, #TEMP.InventoryID, #TEMP.InventoryName, #TEMP.UnitID, #TEMP.UnitName, #TEMP.InventoryTypeID,
					#TEMP.Specification,#TEMP.Notes01, #TEMP.Notes02, #TEMP.Notes03, #TEMP.AccountID, #TEMP.AccountName,
					#TEMP.S1, #TEMP.S2, #TEMP.S3, #TEMP.I01ID, #TEMP.I02ID, #TEMP.I03ID, #TEMP.I04ID, #TEMP.I05ID, 
					#TEMP.I01Name, #TEMP.I02Name, #TEMP.I03Name, #TEMP.I04Name, #TEMP.I05Name, #TEMP.Barcode, #TEMP.WareHouseID, #TEMP.WareHouseName

			'
		--print @sql
		--print '---------------------------------@sql'
		--print @sql1A
		--print '-------------------------------@sql1A'

		--print @sql1B
		--print '-------------------------------------@sql1B'

		--print @sql2
		--print '-------------------------------------@sql2'

		--print @sql3
		--print '-------------------------------------@sql3'

		--print @sql4a
		--print '-------------------------------------@sql4a'

		--print @sql4b
		--print '-------------------------------------@sql4b'

		--print @sql5
		--print '-------------------------------------@sql5'

		--print @sql6
		--print '-------------------------------------@sql6'

		EXEC (@SQL+@SQL1A+@SQL1B+@SQL2+@SQL3+@SQL4A+@SQL4B+@SQL5+@SQL6)
	END
END 
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
