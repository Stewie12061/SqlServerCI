IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP2007_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP2007_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---- Created by Tiểu Mai on 20/06/2016: Bổ sung in báo cáo theo thông tin quy cách và WITH (NOLOCK)
---- Modify on 24/04/2017 by Bảo Anh: Sửa danh mục dùng chung (bỏ kết theo DivisionID)
---- Modified on 01/11/2018 by Kim Thư: Bổ sung lọc báo cáo theo ngày
------ Modified on 19/02/2019 by Kim Thư: gán hàm Isnull cho các cột mã quy cách
---- Modified by Kim Thư on 22/04/2019: Bổ sung thêm trường nhóm người dùng (GroupID), TRUYỀN @UserID 
---- Modified by Kim Thư on 10/05/2019: Sửa lỗi load thiếu dữ liệu in theo ngày
---- Modified by Kim Thư on 17/07/2019: Xử lý lấy WarehouseID trường hợp VCNB (in theo ngày)
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.


CREATE PROCEDURE [dbo].[AP2007_QC]
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
SET @GroupID = (SELECT TOP 1 AT1402.GroupID FROM AT1402 WITH(NOLOCK) WHERE AT1402.UserID = @UserID)


IF @IsDate=0
BEGIN
	DECLARE
			@sSQLSelect AS nvarchar(4000) ,
			@sSQLSelect1 AS nvarchar(4000) ,
			@sSQLSelect2 AS nvarchar(4000) ,
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
		ISNULL(S01ID,'''') AS S01ID, ISNULL(S02ID,'''') AS S02ID, ISNULL(S03ID,'''') AS S03ID, ISNULL(S04ID,'''') AS S04ID, ISNULL(S05ID,'''') AS S05ID, 
		ISNULL(S06ID,'''') AS S06ID, ISNULL(S07ID,'''') AS S07ID, ISNULL(S08ID,'''') AS S08ID, ISNULL(S09ID,'''') AS S09ID, ISNULL(S10ID,'''') AS S10ID,
		ISNULL(S11ID,'''') AS S11ID, ISNULL(S12ID,'''') AS S12ID, ISNULL(S13ID,'''') AS S13ID, ISNULL(S14ID,'''') AS S14ID, ISNULL(S15ID,'''') AS S15ID, 
		ISNULL(S16ID,'''') AS S16ID, ISNULL(S17ID,'''') AS S17ID, ISNULL(S18ID,'''') AS S18ID, ISNULL(S19ID,'''') AS S19ID, ISNULL(S20ID,'''') AS S20ID,
		'''+@GroupID+''' as GroupID, 
		(SELECT AT1401.GroupName FROM AT1401 WITH(NOLOCK) WHERE AT1401.DivisionID = AT2008.DivisionID AND AT1401.GroupID = '''+@GroupID+''' ) AS GroupName '

			 SET @sSQLFrom = ' From AT2008_QC AT2008 WITH (NOLOCK) 	inner join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AT2008.DivisionID,''@@@'') AND AT1302.InventoryID =AT2008.InventoryID
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
			AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, AT2008.InventoryAccountID, AT1005.AccountName,
			ISNULL(S01ID,''''), ISNULL(S02ID,''''), ISNULL(S03ID,''''), ISNULL(S04ID,''''), ISNULL(S05ID,''''), 
			ISNULL(S06ID,''''), ISNULL(S07ID,''''), ISNULL(S08ID,''''), ISNULL(S09ID,''''), ISNULL(S10ID,''''),
			ISNULL(S11ID,''''), ISNULL(S12ID,''''), ISNULL(S13ID,''''), ISNULL(S14ID,''''), ISNULL(S15ID,''''), 
			ISNULL(S16ID,''''), ISNULL(S17ID,''''), ISNULL(S18ID,''''), ISNULL(S19ID,''''), ISNULL(S20ID,'''') '
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
		BeginQuantity = isnull((Select Sum(isnull(BeginQuantity,0)) From AT2008_QC T08 WITH (NOLOCK) Where 	T08.InventoryID = AT2008.InventoryID
										AND ISNULL(AT2008.S01ID,'''') = Isnull(T08.S01ID,'''')
										AND ISNULL(AT2008.S02ID,'''') = isnull(T08.S02ID,'''') 
										AND ISNULL(AT2008.S03ID,'''') = isnull(T08.S03ID,'''') 	
										AND ISNULL(AT2008.S04ID,'''') = isnull(T08.S04ID,'''') 
										AND ISNULL(AT2008.S05ID,'''') = isnull(T08.S05ID,'''') 
										AND ISNULL(AT2008.S06ID,'''') = isnull(T08.S06ID,'''') 
										AND ISNULL(AT2008.S07ID,'''') = isnull(T08.S07ID,'''') 
										AND ISNULL(AT2008.S08ID,'''') = isnull(T08.S08ID,'''') 
										AND ISNULL(AT2008.S09ID,'''') = isnull(T08.S09ID,'''') 
										AND ISNULL(AT2008.S10ID,'''') = isnull(T08.S10ID,'''') 
										AND ISNULL(AT2008.S11ID,'''') = isnull(T08.S11ID,'''') 
										AND ISNULL(AT2008.S12ID,'''') = isnull(T08.S12ID,'''') 
										AND ISNULL(AT2008.S13ID,'''') = isnull(T08.S13ID,'''') 
										AND ISNULL(AT2008.S14ID,'''') = isnull(T08.S14ID,'''') 
										AND ISNULL(AT2008.S15ID,'''') = isnull(T08.S15ID,'''') 
										AND ISNULL(AT2008.S16ID,'''') = isnull(T08.S16ID,'''') 
										AND ISNULL(AT2008.S17ID,'''') = isnull(T08.S17ID,'''') 
										AND ISNULL(AT2008.S18ID,'''') = isnull(T08.S18ID,'''') 
										AND ISNULL(AT2008.S19ID,'''') = isnull(T08.S19ID,'''')
										AND ISNULL(AT2008.S20ID,'''') = isnull(T08.S20ID,'''') AND 
										T08.InventoryAccountID = AT2008.InventoryAccountID and
										T08.DivisionID = ''' + @DivisionID + ''' and
										T08.TranMonth + T08.TranYear*100 = ' + @FromMonthYearText + ' and
										T08.WareHouseID like ''' + @WareHouseID + '''  ),0) ,
		'
		SET @sSQLSelect1 = '
		EndQuantity = isnull((Select Sum(isnull(EndQuantity,0)) From AT2008_QC T08 WITH (NOLOCK) Where 	T08.InventoryID = AT2008.InventoryID 
										AND ISNULL(AT2008.S01ID,'''') = Isnull(T08.S01ID,'''')
										AND ISNULL(AT2008.S02ID,'''') = isnull(T08.S02ID,'''') 
										AND ISNULL(AT2008.S03ID,'''') = isnull(T08.S03ID,'''') 	
										AND ISNULL(AT2008.S04ID,'''') = isnull(T08.S04ID,'''') 
										AND ISNULL(AT2008.S05ID,'''') = isnull(T08.S05ID,'''') 
										AND ISNULL(AT2008.S06ID,'''') = isnull(T08.S06ID,'''') 
										AND ISNULL(AT2008.S07ID,'''') = isnull(T08.S07ID,'''') 
										AND ISNULL(AT2008.S08ID,'''') = isnull(T08.S08ID,'''') 
										AND ISNULL(AT2008.S09ID,'''') = isnull(T08.S09ID,'''') 
										AND ISNULL(AT2008.S10ID,'''') = isnull(T08.S10ID,'''') 
										AND ISNULL(AT2008.S11ID,'''') = isnull(T08.S11ID,'''') 
										AND ISNULL(AT2008.S12ID,'''') = isnull(T08.S12ID,'''') 
										AND ISNULL(AT2008.S13ID,'''') = isnull(T08.S13ID,'''') 
										AND ISNULL(AT2008.S14ID,'''') = isnull(T08.S14ID,'''') 
										AND ISNULL(AT2008.S15ID,'''') = isnull(T08.S15ID,'''') 
										AND ISNULL(AT2008.S16ID,'''') = isnull(T08.S16ID,'''') 
										AND ISNULL(AT2008.S17ID,'''') = isnull(T08.S17ID,'''') 
										AND ISNULL(AT2008.S18ID,'''') = isnull(T08.S18ID,'''') 
										AND ISNULL(AT2008.S19ID,'''') = isnull(T08.S19ID,'''')
										AND ISNULL(AT2008.S20ID,'''') = isnull(T08.S20ID,'''') AND 
										T08.InventoryAccountID = AT2008.InventoryAccountID and
										T08.DivisionID = ''' + @DivisionID + ''' and
										T08.TranMonth + T08.TranYear*100 = ' + @ToMonthYearText + ' and
										T08.WareHouseID like ''' + @WareHouseID + '''  ) ,0),
		
		sum(isnull(DebitQuantity,0)) as DebitQuantity,
		sum(isnull(CreditQuantity,0)) as CreditQuantity,
		BeginAmount = isnull((Select Sum(isnull(BeginAmount,0)) From AT2008_QC T08 WITH (NOLOCK) Where 	T08.InventoryID = AT2008.InventoryID
										AND ISNULL(AT2008.S01ID,'''') = Isnull(T08.S01ID,'''')
										AND ISNULL(AT2008.S02ID,'''') = isnull(T08.S02ID,'''') 
										AND ISNULL(AT2008.S03ID,'''') = isnull(T08.S03ID,'''') 	
										AND ISNULL(AT2008.S04ID,'''') = isnull(T08.S04ID,'''') 
										AND ISNULL(AT2008.S05ID,'''') = isnull(T08.S05ID,'''') 
										AND ISNULL(AT2008.S06ID,'''') = isnull(T08.S06ID,'''') 
										AND ISNULL(AT2008.S07ID,'''') = isnull(T08.S07ID,'''') 
										AND ISNULL(AT2008.S08ID,'''') = isnull(T08.S08ID,'''') 
										AND ISNULL(AT2008.S09ID,'''') = isnull(T08.S09ID,'''') 
										AND ISNULL(AT2008.S10ID,'''') = isnull(T08.S10ID,'''') 
										AND ISNULL(AT2008.S11ID,'''') = isnull(T08.S11ID,'''') 
										AND ISNULL(AT2008.S12ID,'''') = isnull(T08.S12ID,'''') 
										AND ISNULL(AT2008.S13ID,'''') = isnull(T08.S13ID,'''') 
										AND ISNULL(AT2008.S14ID,'''') = isnull(T08.S14ID,'''') 
										AND ISNULL(AT2008.S15ID,'''') = isnull(T08.S15ID,'''') 
										AND ISNULL(AT2008.S16ID,'''') = isnull(T08.S16ID,'''') 
										AND ISNULL(AT2008.S17ID,'''') = isnull(T08.S17ID,'''') 
										AND ISNULL(AT2008.S18ID,'''') = isnull(T08.S18ID,'''') 
										AND ISNULL(AT2008.S19ID,'''') = isnull(T08.S19ID,'''')
										AND ISNULL(AT2008.S20ID,'''') = isnull(T08.S20ID,'''') AND 
										T08.InventoryAccountID = AT2008.InventoryAccountID and
										T08.DivisionID = ''' + @DivisionID + ''' and
										T08.TranMonth + T08.TranYear*100 = ' + @FromMonthYearText + ' and
										T08.WareHouseID like ''' + @WareHouseID + '''  ),0) ,
		'
		SET @sSQLSelect2 = '
		EndAmount = isnull((Select Sum(isnull(EndAmount,0)) From AT2008_QC T08 WITH (NOLOCK) Where 	T08.InventoryID = AT2008.InventoryID 
										AND ISNULL(AT2008.S01ID,'''') = Isnull(T08.S01ID,'''')
										AND ISNULL(AT2008.S02ID,'''') = isnull(T08.S02ID,'''') 
										AND ISNULL(AT2008.S03ID,'''') = isnull(T08.S03ID,'''') 	
										AND ISNULL(AT2008.S04ID,'''') = isnull(T08.S04ID,'''') 
										AND ISNULL(AT2008.S05ID,'''') = isnull(T08.S05ID,'''') 
										AND ISNULL(AT2008.S06ID,'''') = isnull(T08.S06ID,'''') 
										AND ISNULL(AT2008.S07ID,'''') = isnull(T08.S07ID,'''') 
										AND ISNULL(AT2008.S08ID,'''') = isnull(T08.S08ID,'''') 
										AND ISNULL(AT2008.S09ID,'''') = isnull(T08.S09ID,'''') 
										AND ISNULL(AT2008.S10ID,'''') = isnull(T08.S10ID,'''') 
										AND ISNULL(AT2008.S11ID,'''') = isnull(T08.S11ID,'''') 
										AND ISNULL(AT2008.S12ID,'''') = isnull(T08.S12ID,'''') 
										AND ISNULL(AT2008.S13ID,'''') = isnull(T08.S13ID,'''') 
										AND ISNULL(AT2008.S14ID,'''') = isnull(T08.S14ID,'''') 
										AND ISNULL(AT2008.S15ID,'''') = isnull(T08.S15ID,'''') 
										AND ISNULL(AT2008.S16ID,'''') = isnull(T08.S16ID,'''') 
										AND ISNULL(AT2008.S17ID,'''') = isnull(T08.S17ID,'''') 
										AND ISNULL(AT2008.S18ID,'''') = isnull(T08.S18ID,'''') 
										AND ISNULL(AT2008.S19ID,'''') = isnull(T08.S19ID,'''')
										AND ISNULL(AT2008.S20ID,'''') = isnull(T08.S20ID,'''') AND 
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
		ISNULL(S01ID,'''') AS S01ID, ISNULL(S02ID,'''') AS S02ID, ISNULL(S03ID,'''') AS S03ID, ISNULL(S04ID,'''') AS S04ID, ISNULL(S05ID,'''') AS S05ID, 
		ISNULL(S06ID,'''') AS S06ID, ISNULL(S07ID,'''') AS S07ID, ISNULL(S08ID,'''') AS S08ID, ISNULL(S09ID,'''') AS S09ID, ISNULL(S10ID,'''') AS S10ID,
		ISNULL(S11ID,'''') AS S11ID, ISNULL(S12ID,'''') AS S12ID, ISNULL(S13ID,'''') AS S13ID, ISNULL(S14ID,'''') AS S14ID, ISNULL(S15ID,'''') AS S15ID, 
		ISNULL(S16ID,'''') AS S16ID, ISNULL(S17ID,'''') AS S17ID, ISNULL(S18ID,'''') AS S18ID, ISNULL(S19ID,'''') AS S19ID, ISNULL(S20ID,'''') AS S20ID,
		'''+@GroupID+''' as GroupID,
		(SELECT AT1401.GroupName FROM AT1401 WITH(NOLOCK) WHERE AT1401.DivisionID = AT2008.DivisionID AND AT1401.GroupID = '''+@GroupID+''' ) AS GroupName 
		'

			 SET @sSQLFrom = 'From AT2008_QC AT2008 WITH (NOLOCK) 	inner join AT1302 WITH (NOLOCK) on AT1302.DivisionID IN (AT2008.DivisionID,''@@@'') AND At1302.InventoryID =AT2008.InventoryID
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
		AT1302.S1,	AT1302.S2, 	AT1302.S3 , AT1302.Specification, AT1302.Notes01, AT1302.Notes02, AT1302.Notes03,
		ISNULL(S01ID,''''), ISNULL(S02ID,''''), ISNULL(S03ID,''''), ISNULL(S04ID,''''), ISNULL(S05ID,''''), 
		ISNULL(S06ID,''''), ISNULL(S07ID,''''), ISNULL(S08ID,''''), ISNULL(S09ID,''''), ISNULL(S10ID,''''),
		ISNULL(S11ID,''''), ISNULL(S12ID,''''), ISNULL(S13ID,''''), ISNULL(S14ID,''''), ISNULL(S15ID,''''), 
		ISNULL(S16ID,''''), ISNULL(S17ID,''''), ISNULL(S18ID,''''), ISNULL(S19ID,''''), ISNULL(S20ID,'''')
	 '
	END

	IF EXISTS ( SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV2017' )
	   BEGIN
			 DROP VIEW AV2017
	   END
	EXEC ( ' Create view AV2017 as '+ @sSQLSelect + @sSQLSelect1 + @sSQLSelect2 + @sSQLFrom + @sSQLWhere)

	SET @sSQLSelect = ' Select AV2017.*,
					A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
					A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
					A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
					A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
					A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20,
					a.S01, a.S02, a.S03, a.S04, a.S05, a.S06, a.S07, a.S08, a.S09, a.S10,
					a.S11, a.S12, a.S13, a.S14, a.S15, a.S16, a.S17, a.S18, a.S19, a.S20
			FROM AV2017
			FULL JOIN (SELECT * FROM  (SELECT UserName, TypeID, DivisionID
		                   FROM AT0005 WITH (NOLOCK) WHERE TypeID LIKE ''S__'') b PIVOT (max(Username) for TypeID IN (S01, S02, S03, S04, S05, S06, S07, S08, S09, S10,
																										S11, S12, S13, S14, S15, S16, S17, S18, S19, S20))  AS a) a ON a.DivisionID = AV2017.DivisionID
	'
	SET @sSQLSelect1 = '
			LEFT JOIN AT0128 A01 WITH (NOLOCK) ON AV2017.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
			LEFT JOIN AT0128 A02 WITH (NOLOCK) ON AV2017.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
			LEFT JOIN AT0128 A03 WITH (NOLOCK) ON AV2017.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
			LEFT JOIN AT0128 A04 WITH (NOLOCK) ON AV2017.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
			LEFT JOIN AT0128 A05 WITH (NOLOCK) ON AV2017.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
			LEFT JOIN AT0128 A06 WITH (NOLOCK) ON AV2017.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
			LEFT JOIN AT0128 A07 WITH (NOLOCK) ON AV2017.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
			LEFT JOIN AT0128 A08 WITH (NOLOCK) ON AV2017.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
			LEFT JOIN AT0128 A09 WITH (NOLOCK) ON AV2017.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
			LEFT JOIN AT0128 A10 WITH (NOLOCK) ON AV2017.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
			LEFT JOIN AT0128 A11 WITH (NOLOCK) ON AV2017.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
			LEFT JOIN AT0128 A12 WITH (NOLOCK) ON AV2017.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
			LEFT JOIN AT0128 A13 WITH (NOLOCK) ON AV2017.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
			LEFT JOIN AT0128 A14 WITH (NOLOCK) ON AV2017.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
			LEFT JOIN AT0128 A15 WITH (NOLOCK) ON AV2017.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
			LEFT JOIN AT0128 A16 WITH (NOLOCK) ON AV2017.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
			LEFT JOIN AT0128 A17 WITH (NOLOCK) ON AV2017.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
			LEFT JOIN AT0128 A18 WITH (NOLOCK) ON AV2017.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
			LEFT JOIN AT0128 A19 WITH (NOLOCK) ON AV2017.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
			LEFT JOIN AT0128 A20 WITH (NOLOCK) ON AV2017.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20'' 		
	Where 	(BeginQuantity <> 0 or EndQuantity<>0 or DebitQuantity<>0 or CreditQuantity<>0 or BeginAmount<>0 or EndAmount <>0 or DebitAmount<>0 or
		CreditAmount<>0) '

	IF EXISTS ( SELECT 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV2007' )
	   BEGIN
			 DROP VIEW AV2007
	   END
	EXEC (@sSQLSelect + @sSQLSelect1 )
END
ELSE
BEGIN
			DECLARE @SQL NVARCHAR(MAX),
				@SQL1 NVARCHAR(MAX),
				@SQL1A NVARCHAR(MAX),
				@SQL2 NVARCHAR(MAX),
				@SQL3 NVARCHAR(MAX),
				@SQL4 NVARCHAR(MAX),
				@SQL4A NVARCHAR(MAX),
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
		S01ID VARCHAR(50), S02ID VARCHAR(50), S03ID VARCHAR(50), S04ID VARCHAR(50), S05ID VARCHAR(50), S06ID VARCHAR(50), S07ID VARCHAR(50), S08ID VARCHAR(50), S09ID VARCHAR(50), S10ID VARCHAR(50),
		S11ID VARCHAR(50), S12ID VARCHAR(50), S13ID VARCHAR(50), S14ID VARCHAR(50), S15ID VARCHAR(50), S16ID VARCHAR(50), S17ID VARCHAR(50), S18ID VARCHAR(50), S19ID VARCHAR(50), S20ID VARCHAR(50),
		WareHouseID NVARCHAR(50), WareHouseName NVARCHAR(250), GroupID NVARCHAR(50) )


		-- Tính tồn đầu
		-- Số dư đầu kỳ
		SET @SQL='
			SELECT TEMP1.DivisionID, TEMP1.WareHouseID, TEMP1.WareHouseName, TEMP1.InventoryID, TEMP1.InventoryName, TEMP1.UnitID, TEMP1.UnitName, TEMP1.InventoryTypeID, TEMP1.Specification, TEMP1.Notes01, TEMP1.Notes02, TEMP1.Notes03,
					TEMP1.AccountID, TEMP1.AccountName, SUM(TEMP1.ActualQuantity) AS BeginQuantity, SUM(TEMP1.ConvertedAmount) AS BeginAmount, TEMP1.S1, TEMP1.S2, TEMP1.S3, 
					TEMP1.I01ID, TEMP1.I02ID, TEMP1.I03ID, TEMP1.I04ID, TEMP1.I05ID, TEMP1.I01Name, TEMP1.I02Name, TEMP1.I03Name, TEMP1.I04Name, TEMP1.I05Name, TEMP1.Barcode,
					TEMP1.S01ID, TEMP1.S02ID, TEMP1.S03ID, TEMP1.S04ID, TEMP1.S05ID, TEMP1.S06ID, TEMP1.S07ID, TEMP1.S08ID, TEMP1.S09ID, TEMP1.S10ID,
					TEMP1.S11ID, TEMP1.S12ID, TEMP1.S13ID, TEMP1.S14ID, TEMP1.S15ID, TEMP1.S16ID, TEMP1.S17ID, TEMP1.S18ID, TEMP1.S19ID, TEMP1.S20ID
			INTO #TEMP1
			FROM (
			SELECT A1.DivisionID, A2.WareHouseID, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
									A3.AccountID, A5.AccountName, A1.ActualQuantity, A1.ConvertedAmount, A3.S1, A3.S2, A3.S3,
									A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
									I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode,
									ISNULL(O99.S01ID,'''') AS S01ID, ISNULL(O99.S02ID,'''') AS S02ID, ISNULL(O99.S03ID,'''') AS S03ID, ISNULL(O99.S04ID,'''') AS S04ID, ISNULL(O99.S05ID,'''') AS S05ID, 
									ISNULL(O99.S06ID,'''') AS S06ID, ISNULL(O99.S07ID,'''') AS S07ID, ISNULL(O99.S08ID,'''') AS S08ID, ISNULL(O99.S09ID,'''') AS S09ID, ISNULL(O99.S10ID,'''') AS S10ID,
									ISNULL(O99.S11ID,'''') AS S11ID, ISNULL(O99.S12ID,'''') AS S12ID, ISNULL(O99.S13ID,'''') AS S13ID, ISNULL(O99.S14ID,'''') AS S14ID, ISNULL(O99.S15ID,'''') AS S15ID, 
									ISNULL(O99.S16ID,'''') AS S16ID, ISNULL(O99.S17ID,'''') AS S17ID, ISNULL(O99.S18ID,'''') AS S18ID, ISNULL(O99.S19ID,'''') AS S19ID, ISNULL(O99.S20ID,'''') AS S20ID
			FROM AT2017 A1 WITH (NOLOCK) INNER JOIN AT2016 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.AccountID = A5.AccountID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A2.WarehouseID = A6.WarehouseID
			LEFT JOIN WT8899 O99 WITH (NOLOCK) on O99.DivisionID = A1.DivisionID And O99.VoucherID = A1.VoucherID And O99.TransactionID = A1.TransactionID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.DebitAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+'''
				AND A2.WareHouseID like ''' + @WareHouseID + '''
			'
		
		SET @SQL1='
			UNION ALL
			-- Nhập trước @FromDateText
			SELECT A1.DivisionID, A2.WareHouseID, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
									A1.DebitAccountID, A5.AccountName, A1.ActualQuantity, A1.ConvertedAmount, A3.S1, A3.S2, A3.S3,
									A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
									I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode,
									ISNULL(O99.S01ID,'''') AS S01ID, ISNULL(O99.S02ID,'''') AS S02ID, ISNULL(O99.S03ID,'''') AS S03ID, ISNULL(O99.S04ID,'''') AS S04ID, ISNULL(O99.S05ID,'''') AS S05ID, 
									ISNULL(O99.S06ID,'''') AS S06ID, ISNULL(O99.S07ID,'''') AS S07ID, ISNULL(O99.S08ID,'''') AS S08ID, ISNULL(O99.S09ID,'''') AS S09ID, ISNULL(O99.S10ID,'''') AS S10ID,
									ISNULL(O99.S11ID,'''') AS S11ID, ISNULL(O99.S12ID,'''') AS S12ID, ISNULL(O99.S13ID,'''') AS S13ID, ISNULL(O99.S14ID,'''') AS S14ID, ISNULL(O99.S15ID,'''') AS S15ID, 
									ISNULL(O99.S16ID,'''') AS S16ID, ISNULL(O99.S17ID,'''') AS S17ID, ISNULL(O99.S18ID,'''') AS S18ID, ISNULL(O99.S19ID,'''') AS S19ID, ISNULL(O99.S20ID,'''') AS S20ID
			FROM AT2007 A1 WITH (NOLOCK) INNER JOIN AT2006 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.AccountID = A5.AccountID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A2.WarehouseID = A6.WarehouseID
			LEFT JOIN WT8899 O99 WITH (NOLOCK) on O99.DivisionID = A1.DivisionID And O99.VoucherID = A1.VoucherID And O99.TransactionID = A1.TransactionID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.DebitAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+'''
					AND A2.KindVoucherID in (1,3,5,7,9,15,17)
					AND A2.VoucherDate < '''+@FromDateText+''' 
					AND A2.WareHouseID like ''' + @WareHouseID + '''
		'
		
		SET @SQL1A='
			UNION ALL
			--Xuất trước @FromDateText
			SELECT A1.DivisionID, CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END AS WareHouseID, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
									A1.CreditAccountID, A5.AccountName, -A1.ActualQuantity AS ActualQuantity, -A1.ConvertedAmount AS OriginalAmount, A3.S1, A3.S2, A3.S3,
									A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
									I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode,
									ISNULL(O99.S01ID,'''') AS S01ID, ISNULL(O99.S02ID,'''') AS S02ID, ISNULL(O99.S03ID,'''') AS S03ID, ISNULL(O99.S04ID,'''') AS S04ID, ISNULL(O99.S05ID,'''') AS S05ID, 
									ISNULL(O99.S06ID,'''') AS S06ID, ISNULL(O99.S07ID,'''') AS S07ID, ISNULL(O99.S08ID,'''') AS S08ID, ISNULL(O99.S09ID,'''') AS S09ID, ISNULL(O99.S10ID,'''') AS S10ID,
									ISNULL(O99.S11ID,'''') AS S11ID, ISNULL(O99.S12ID,'''') AS S12ID, ISNULL(O99.S13ID,'''') AS S13ID, ISNULL(O99.S14ID,'''') AS S14ID, ISNULL(O99.S15ID,'''') AS S15ID, 
									ISNULL(O99.S16ID,'''') AS S16ID, ISNULL(O99.S17ID,'''') AS S17ID, ISNULL(O99.S18ID,'''') AS S18ID, ISNULL(O99.S19ID,'''') AS S19ID, ISNULL(O99.S20ID,'''') AS S20ID
			FROM AT2007 A1 WITH (NOLOCK) INNER JOIN AT2006 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.AccountID = A5.AccountID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND (CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END = A6.WarehouseID)
			LEFT JOIN WT8899 O99 WITH (NOLOCK) on O99.DivisionID = A1.DivisionID And O99.VoucherID = A1.VoucherID And O99.TransactionID = A1.TransactionID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.CreditAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+'''
				AND A2.KindVoucherID in (2,3,4,6,8,10,14,20)
				AND A2.VoucherDate < '''+@FromDateText+'''
				AND CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END like ''' + @WareHouseID + '''
			) TEMP1
			GROUP BY TEMP1.DivisionID, TEMP1.WareHouseID, TEMP1.WareHouseName, TEMP1.InventoryID, TEMP1.InventoryName, TEMP1.UnitID, TEMP1.UnitName, TEMP1.InventoryTypeID, TEMP1.Specification, TEMP1.Notes01, TEMP1.Notes02, TEMP1.Notes03,
									TEMP1.AccountID, TEMP1.AccountName, TEMP1.S1, TEMP1.S2, TEMP1.S3, TEMP1.I01ID, TEMP1.I02ID, TEMP1.I03ID, TEMP1.I04ID, TEMP1.I05ID, TEMP1.I01Name, TEMP1.I02Name, TEMP1.I03Name, TEMP1.I04Name, TEMP1.I05Name, TEMP1.Barcode,
									TEMP1.S01ID, TEMP1.S02ID, TEMP1.S03ID, TEMP1.S04ID, TEMP1.S05ID, TEMP1.S06ID, TEMP1.S07ID, TEMP1.S08ID, TEMP1.S09ID, TEMP1.S10ID,
									TEMP1.S11ID, TEMP1.S12ID, TEMP1.S13ID, TEMP1.S14ID, TEMP1.S15ID, TEMP1.S16ID, TEMP1.S17ID, TEMP1.S18ID, TEMP1.S19ID, TEMP1.S20ID
			'
		
		SET @SQL2='
			--Tính nhập từ @FromDateText -> @ToDateText
			SELECT A1.DivisionID, A2.WareHouseID, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
									A1.DebitAccountID, A5.AccountName, SUM(A1.ActualQuantity) AS DebitQuantity, SUM(A1.ConvertedAmount) AS DebitAmount,
									A3.S1, A3.S2, A3.S3, A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
									I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode,
									ISNULL(O99.S01ID,'''') AS S01ID, ISNULL(O99.S02ID,'''') AS S02ID, ISNULL(O99.S03ID,'''') AS S03ID, ISNULL(O99.S04ID,'''') AS S04ID, ISNULL(O99.S05ID,'''') AS S05ID, 
									ISNULL(O99.S06ID,'''') AS S06ID, ISNULL(O99.S07ID,'''') AS S07ID, ISNULL(O99.S08ID,'''') AS S08ID, ISNULL(O99.S09ID,'''') AS S09ID, ISNULL(O99.S10ID,'''') AS S10ID,
									ISNULL(O99.S11ID,'''') AS S11ID, ISNULL(O99.S12ID,'''') AS S12ID, ISNULL(O99.S13ID,'''') AS S13ID, ISNULL(O99.S14ID,'''') AS S14ID, ISNULL(O99.S15ID,'''') AS S15ID, 
									ISNULL(O99.S16ID,'''') AS S16ID, ISNULL(O99.S17ID,'''') AS S17ID, ISNULL(O99.S18ID,'''') AS S18ID, ISNULL(O99.S19ID,'''') AS S19ID, ISNULL(O99.S20ID,'''') AS S20ID
			INTO #TEMP2_IM
			FROM AT2007 A1 WITH (NOLOCK) INNER JOIN AT2006 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.AccountID = A5.AccountID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A2.WarehouseID = A6.WarehouseID
			LEFT JOIN WT8899 O99 WITH (NOLOCK) on O99.DivisionID = A1.DivisionID And O99.VoucherID = A1.VoucherID And O99.TransactionID = A1.TransactionID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.DebitAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+'''
					AND A2.KindVoucherID in (1,3,5,7,9,15,17)
					AND A2.VoucherDate BETWEEN '''+@FromDateText+''' AND '''+@ToDateText+'''
					AND A2.WareHouseID like ''' + @WareHouseID + '''
			GROUP BY  A1.DivisionID, A2.WareHouseID, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
									A1.DebitAccountID, A5.AccountName,A3.S1, A3.S2, A3.S3,A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName,I02.AnaName,
									I03.AnaName,I04.AnaName,I05.AnaName,A3.Barcode,
									ISNULL(O99.S01ID,''''), ISNULL(O99.S02ID,''''), ISNULL(O99.S03ID,''''), ISNULL(O99.S04ID,''''), ISNULL(O99.S05ID,''''), 
									ISNULL(O99.S06ID,''''), ISNULL(O99.S07ID,''''), ISNULL(O99.S08ID,''''), ISNULL(O99.S09ID,''''), ISNULL(O99.S10ID,''''),
									ISNULL(O99.S11ID,''''), ISNULL(O99.S12ID,''''), ISNULL(O99.S13ID,''''), ISNULL(O99.S14ID,''''), ISNULL(O99.S15ID,''''), 
									ISNULL(O99.S16ID,''''), ISNULL(O99.S17ID,''''), ISNULL(O99.S18ID,''''), ISNULL(O99.S19ID,''''), ISNULL(O99.S20ID,'''')
			'
		SET @SQL3='
			--Tính xuất từ @FromDateText -> @ToDateText
			SELECT A1.DivisionID, CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END AS WareHouseID, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
									A1.CreditAccountID, A5.AccountName, SUM(A1.ActualQuantity) AS CreditQuantity, SUM(A1.ConvertedAmount) AS CreditAmount,
									A3.S1, A3.S2, A3.S3, A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
									I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode,
									ISNULL(O99.S01ID,'''') AS S01ID, ISNULL(O99.S02ID,'''') AS S02ID, ISNULL(O99.S03ID,'''') AS S03ID, ISNULL(O99.S04ID,'''') AS S04ID, ISNULL(O99.S05ID,'''') AS S05ID, 
									ISNULL(O99.S06ID,'''') AS S06ID, ISNULL(O99.S07ID,'''') AS S07ID, ISNULL(O99.S08ID,'''') AS S08ID, ISNULL(O99.S09ID,'''') AS S09ID, ISNULL(O99.S10ID,'''') AS S10ID,
									ISNULL(O99.S11ID,'''') AS S11ID, ISNULL(O99.S12ID,'''') AS S12ID, ISNULL(O99.S13ID,'''') AS S13ID, ISNULL(O99.S14ID,'''') AS S14ID, ISNULL(O99.S15ID,'''') AS S15ID, 
									ISNULL(O99.S16ID,'''') AS S16ID, ISNULL(O99.S17ID,'''') AS S17ID, ISNULL(O99.S18ID,'''') AS S18ID, ISNULL(O99.S19ID,'''') AS S19ID, ISNULL(O99.S20ID,'''') AS S20ID
			INTO #TEMP2_EX
			FROM AT2007 A1 WITH (NOLOCK) INNER JOIN AT2006 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.AccountID = A5.AccountID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND (CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END AS WareHouseID = A6.WarehouseID)
			LEFT JOIN WT8899 O99 WITH (NOLOCK) on O99.DivisionID = A1.DivisionID And O99.VoucherID = A1.VoucherID And O99.TransactionID = A1.TransactionID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.CreditAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+'''
					AND A2.KindVoucherID in (2,3,4,6,8,10,14,20)
					AND A2.VoucherDate BETWEEN '''+@FromDateText+''' AND '''+@ToDateText+'''
					AND CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END AS WareHouseID like ''' + @WareHouseID + '''
			GROUP BY A1.DivisionID, CASE WHEN A2.KindVoucherID = 3 THEN A2.WarehouseID2 ELSE A2.WareHouseID END AS WareHouseID, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
									A1.CreditAccountID, A5.AccountName,A3.S1, A3.S2, A3.S3,A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName,I02.AnaName,
									I03.AnaName,I04.AnaName,I05.AnaName,A3.Barcode,
									ISNULL(O99.S01ID,''''), ISNULL(O99.S02ID,''''), ISNULL(O99.S03ID,''''), ISNULL(O99.S04ID,''''), ISNULL(O99.S05ID,''''), 
									ISNULL(O99.S06ID,''''), ISNULL(O99.S07ID,''''), ISNULL(O99.S08ID,''''), ISNULL(O99.S09ID,''''), ISNULL(O99.S10ID,''''),
									ISNULL(O99.S11ID,''''), ISNULL(O99.S12ID,''''), ISNULL(O99.S13ID,''''), ISNULL(O99.S14ID,''''), ISNULL(O99.S15ID,''''), 
									ISNULL(O99.S16ID,''''), ISNULL(O99.S17ID,''''), ISNULL(O99.S18ID,''''), ISNULL(O99.S19ID,''''), ISNULL(O99.S20ID,'''')
			'
		
		SET @SQL4='
			-- Tính số lượng nhập VCNB
			SELECT A1.DivisionID, A2.WareHouseID, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
						A1.DebitAccountID, A5.AccountName, SUM(A1.ActualQuantity) AS InDebitQuantity, SUM(A1.ConvertedAmount) AS InDebitAmount,
						A3.S1, A3.S2, A3.S3, A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
						I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode,
						ISNULL(O99.S01ID,'''') AS S01ID, ISNULL(O99.S02ID,'''') AS S02ID, ISNULL(O99.S03ID,'''') AS S03ID, ISNULL(O99.S04ID,'''') AS S04ID, ISNULL(O99.S05ID,'''') AS S05ID, 
						ISNULL(O99.S06ID,'''') AS S06ID, ISNULL(O99.S07ID,'''') AS S07ID, ISNULL(O99.S08ID,'''') AS S08ID, ISNULL(O99.S09ID,'''') AS S09ID, ISNULL(O99.S10ID,'''') AS S10ID,
						ISNULL(O99.S11ID,'''') AS S11ID, ISNULL(O99.S12ID,'''') AS S12ID, ISNULL(O99.S13ID,'''') AS S13ID, ISNULL(O99.S14ID,'''') AS S14ID, ISNULL(O99.S15ID,'''') AS S15ID, 
						ISNULL(O99.S16ID,'''') AS S16ID, ISNULL(O99.S17ID,'''') AS S17ID, ISNULL(O99.S18ID,'''') AS S18ID, ISNULL(O99.S19ID,'''') AS S19ID, ISNULL(O99.S20ID,'''') AS S20ID
			INTO #TEMP3_IM
			FROM AT2007 A1 WITH (NOLOCK) INNER JOIN AT2006 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.AccountID = A5.AccountID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A2.WarehouseID = A6.WarehouseID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			LEFT JOIN WT8899 O99 WITH (NOLOCK) on O99.DivisionID = A1.DivisionID And O99.VoucherID = A1.VoucherID And O99.TransactionID = A1.TransactionID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.DebitAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND A2.KindVoucherID = 3
					AND A2.WareHouseID like ''' + @WareHouseID + '''
			GROUP BY A1.DivisionID, A2.WareHouseID, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
						A1.DebitAccountID, A5.AccountName, A3.S1, A3.S2, A3.S3,A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName,I02.AnaName,
						I03.AnaName,I04.AnaName,I05.AnaName,A3.Barcode,
						ISNULL(O99.S01ID,''''), ISNULL(O99.S02ID,''''), ISNULL(O99.S03ID,''''), ISNULL(O99.S04ID,''''), ISNULL(O99.S05ID,''''), 
						ISNULL(O99.S06ID,''''), ISNULL(O99.S07ID,''''), ISNULL(O99.S08ID,''''), ISNULL(O99.S09ID,''''), ISNULL(O99.S10ID,''''),
						ISNULL(O99.S11ID,''''), ISNULL(O99.S12ID,''''), ISNULL(O99.S13ID,''''), ISNULL(O99.S14ID,''''), ISNULL(O99.S15ID,''''), 
						ISNULL(O99.S16ID,''''), ISNULL(O99.S17ID,''''), ISNULL(O99.S18ID,''''), ISNULL(O99.S19ID,''''), ISNULL(O99.S20ID,'''') '
			
			SET @SQL4A='
			-- Tính số lượng xuất VCNB
			SELECT A1.DivisionID, A2.WareHouseID2 AS WareHouseID, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
						A1.CreditAccountID, A5.AccountName, SUM(A1.ActualQuantity) AS InCreditQuantity, SUM(A1.ConvertedAmount) AS InCreditAmount,
						A3.S1, A3.S2, A3.S3, A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName AS I01Name,I02.AnaName AS I02Name,
						I03.AnaName AS I03Name,I04.AnaName AS I04Name,I05.AnaName AS I05Name,A3.Barcode,
						ISNULL(O99.S01ID,'''') AS S01ID, ISNULL(O99.S02ID,'''') AS S02ID, ISNULL(O99.S03ID,'''') AS S03ID, ISNULL(O99.S04ID,'''') AS S04ID, ISNULL(O99.S05ID,'''') AS S05ID, 
						ISNULL(O99.S06ID,'''') AS S06ID, ISNULL(O99.S07ID,'''') AS S07ID, ISNULL(O99.S08ID,'''') AS S08ID, ISNULL(O99.S09ID,'''') AS S09ID, ISNULL(O99.S10ID,'''') AS S10ID,
						ISNULL(O99.S11ID,'''') AS S11ID, ISNULL(O99.S12ID,'''') AS S12ID, ISNULL(O99.S13ID,'''') AS S13ID, ISNULL(O99.S14ID,'''') AS S14ID, ISNULL(O99.S15ID,'''') AS S15ID, 
						ISNULL(O99.S16ID,'''') AS S16ID, ISNULL(O99.S17ID,'''') AS S17ID, ISNULL(O99.S18ID,'''') AS S18ID, ISNULL(O99.S19ID,'''') AS S19ID, ISNULL(O99.S20ID,'''') AS S20ID
			INTO #TEMP3_EX
			FROM AT2007 A1 WITH (NOLOCK) INNER JOIN AT2006 A2 WITH (NOLOCK) ON A1.VoucherID = A2.VoucherID
			LEFT JOIN AT1302 A3 WITH (NOLOCK) ON A1.InventoryID = A3.InventoryID
			LEFT JOIN AT1304 A4 WITH (NOLOCK) ON A3.UnitID = A4.UnitID
			LEFT JOIN AT1005 A5 WITH (NOLOCK) ON A3.AccountID = A5.AccountID
			LEFT JOIN AT1303 A6 WITH (NOLOCK) ON A6.DivisionID IN ('''+@DivisionID+''',''@@@'') AND A2.WarehouseID2 = A6.WarehouseID
			LEFT JOIN AT1015 I01 WITH (NOLOCK) ON I01.AnaTypeID = ''I01'' AND I01.AnaID = A3.I01ID
			LEFT JOIN AT1015 I02 WITH (NOLOCK) ON I02.AnaTypeID = ''I02'' AND I02.AnaID = A3.I02ID
			LEFT JOIN AT1015 I03 WITH (NOLOCK) ON I03.AnaTypeID = ''I03'' AND I03.AnaID = A3.I03ID
			LEFT JOIN AT1015 I04 WITH (NOLOCK) ON I04.AnaTypeID = ''I04'' AND I04.AnaID = A3.I04ID
			LEFT JOIN AT1015 I05 WITH (NOLOCK) ON I05.AnaTypeID = ''I05'' AND I05.AnaID = A3.I05ID
			LEFT JOIN WT8899 O99 WITH (NOLOCK) on O99.DivisionID = A1.DivisionID And O99.VoucherID = A1.VoucherID And O99.TransactionID = A1.TransactionID
			WHERE A1.DivisionID = '''+@DivisionID+''' AND A1.CreditAccountID BETWEEN '''+@FromAccountID+''' AND '''+@ToAccountID+''' AND A2.KindVoucherID = 3
					AND A2.WareHouseID like ''' + @WareHouseID + '''
			GROUP BY A1.DivisionID, A2.WareHouseID2, A6.WareHouseName, A1.InventoryID, A3.InventoryName, A3.UnitID, A4.UnitName, A3.InventoryTypeID, A3.Specification, A3.Notes01, A3.Notes02, A3.Notes03,
						A1.CreditAccountID, A5.AccountName, A3.S1, A3.S2, A3.S3,A3.I01ID,A3.I02ID,A3.I03ID,A3.I04ID,A3.I05ID, I01.AnaName,I02.AnaName,
						I03.AnaName,I04.AnaName,I05.AnaName,A3.Barcode,
						ISNULL(O99.S01ID,''''), ISNULL(O99.S02ID,''''), ISNULL(O99.S03ID,''''), ISNULL(O99.S04ID,''''), ISNULL(O99.S05ID,''''), 
						ISNULL(O99.S06ID,''''), ISNULL(O99.S07ID,''''), ISNULL(O99.S08ID,''''), ISNULL(O99.S09ID,''''), ISNULL(O99.S10ID,''''),
						ISNULL(O99.S11ID,''''), ISNULL(O99.S12ID,''''), ISNULL(O99.S13ID,''''), ISNULL(O99.S14ID,''''), ISNULL(O99.S15ID,''''), 
						ISNULL(O99.S16ID,''''), ISNULL(O99.S17ID,''''), ISNULL(O99.S18ID,''''), ISNULL(O99.S19ID,''''), ISNULL(O99.S20ID,'''')
			'
		
		
		SET @SQL5='
			INSERT INTO #TEMP (DivisionID, WareHouseID, WareHouseName, InventoryID, InventoryName, UnitID, UnitName, InventoryTypeID, Specification, Notes01, Notes02, Notes03,
								AccountID, AccountName, BeginQuantity, BeginAmount, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, I01Name, I02Name, I03Name, I04Name, I05Name, 
								Barcode, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID)
			SELECT #TEMP1.DivisionID,  #TEMP1.WareHouseID, #TEMP1.WareHouseName, #TEMP1.InventoryID, #TEMP1.InventoryName, #TEMP1.UnitID, #TEMP1.UnitName, #TEMP1.InventoryTypeID, 
					#TEMP1.Specification, #TEMP1.Notes01, #TEMP1.Notes02, #TEMP1.Notes03, #TEMP1.AccountID, #TEMP1.AccountName, #TEMP1.BeginQuantity, #TEMP1.BeginAmount, 
					#TEMP1.S1, #TEMP1.S2, #TEMP1.S3, #TEMP1.I01ID, #TEMP1.I02ID, #TEMP1.I03ID, #TEMP1.I04ID, #TEMP1.I05ID, #TEMP1.I01Name, #TEMP1.I02Name, #TEMP1.I03Name, 
					#TEMP1.I04Name, #TEMP1.I05Name, #TEMP1.Barcode, #TEMP1.S01ID, #TEMP1.S02ID, #TEMP1.S03ID, #TEMP1.S04ID, #TEMP1.S05ID, #TEMP1.S06ID, #TEMP1.S07ID, #TEMP1.S08ID, #TEMP1.S09ID, #TEMP1.S10ID, 
					#TEMP1.S11ID, #TEMP1.S12ID, #TEMP1.S13ID, #TEMP1.S14ID, #TEMP1.S15ID, #TEMP1.S16ID, #TEMP1.S17ID, #TEMP1.S18ID, #TEMP1.S19ID, #TEMP1.S20ID
			FROM #TEMP1
			

			INSERT INTO #TEMP (DivisionID, WareHouseID, WareHouseName, InventoryID, InventoryName, UnitID, UnitName, InventoryTypeID, Specification, Notes01, Notes02, Notes03,
								AccountID, AccountName, DebitQuantity, DebitAmount, S1, S2, S3, I01ID, I02ID, I03ID, I04ID, I05ID, I01Name, I02Name, I03Name, I04Name, I05Name, 
								Barcode, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID)
			SELECT #TEMP2_IM.DivisionID, #TEMP2_IM.WareHouseID, #TEMP2_IM.WareHouseName, #TEMP2_IM.InventoryID, #TEMP2_IM.InventoryName, #TEMP2_IM.UnitID, #TEMP2_IM.UnitName, 
					#TEMP2_IM.InventoryTypeID, #TEMP2_IM.Specification, #TEMP2_IM.Notes01, #TEMP2_IM.Notes02, #TEMP2_IM.Notes03, #TEMP2_IM.DebitAccountID, #TEMP2_IM.AccountName, 
					#TEMP2_IM.DebitQuantity, #TEMP2_IM.DebitAmount, #TEMP2_IM.S1, #TEMP2_IM.S2, #TEMP2_IM.S3, #TEMP2_IM.I01ID, #TEMP2_IM.I02ID, #TEMP2_IM.I03ID, 
					#TEMP2_IM.I04ID, #TEMP2_IM.I05ID, #TEMP2_IM.I01Name, #TEMP2_IM.I02Name,
					#TEMP2_IM.I03Name, #TEMP2_IM.I04Name, #TEMP2_IM.I05Name, #TEMP2_IM.Barcode, #TEMP2_IM.S01ID, #TEMP2_IM.S02ID, #TEMP2_IM.S03ID, #TEMP2_IM.S04ID, 
					#TEMP2_IM.S05ID, #TEMP2_IM.S06ID, #TEMP2_IM.S07ID, #TEMP2_IM.S08ID, #TEMP2_IM.S09ID, #TEMP2_IM.S10ID, 
					#TEMP2_IM.S11ID, #TEMP2_IM.S12ID, #TEMP2_IM.S13ID, #TEMP2_IM.S14ID, #TEMP2_IM.S15ID, #TEMP2_IM.S16ID, 
					#TEMP2_IM.S17ID, #TEMP2_IM.S18ID, #TEMP2_IM.S19ID, #TEMP2_IM.S20ID
			FROM #TEMP2_IM


			INSERT INTO #TEMP (DivisionID, WareHouseID, WareHouseName, InventoryID, InventoryName, UnitID, UnitName, InventoryTypeID, Specification, Notes01, Notes02, Notes03,
							AccountID, AccountName, CreditQuantity, CreditAmount, S1, S2, S3, I01ID,I02ID,I03ID,I04ID,I05ID,I01Name,I02Name,
							I03Name,I04Name,I05Name,Barcode, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID)
			SELECT #TEMP2_EX.DivisionID, #TEMP2_EX.WareHouseID, #TEMP2_EX.WareHouseName, #TEMP2_EX.InventoryID, #TEMP2_EX.InventoryName, #TEMP2_EX.UnitID, #TEMP2_EX.UnitName, 
					#TEMP2_EX.InventoryTypeID, #TEMP2_EX.Specification, #TEMP2_EX.Notes01, #TEMP2_EX.Notes02, #TEMP2_EX.Notes03,
					#TEMP2_EX.CreditAccountID, #TEMP2_EX.AccountName, #TEMP2_EX.CreditQuantity, #TEMP2_EX.CreditAmount, #TEMP2_EX.S1, #TEMP2_EX.S2, #TEMP2_EX.S3,
					#TEMP2_EX.I01ID,#TEMP2_EX.I02ID,#TEMP2_EX.I03ID,#TEMP2_EX.I04ID,#TEMP2_EX.I05ID,#TEMP2_EX.I01Name,#TEMP2_EX.I02Name,
					#TEMP2_EX.I03Name,#TEMP2_EX.I04Name,#TEMP2_EX.I05Name,#TEMP2_EX.Barcode, #TEMP2_EX.S01ID, #TEMP2_EX.S02ID, #TEMP2_EX.S03ID, #TEMP2_EX.S04ID, 
					#TEMP2_EX.S05ID, #TEMP2_EX.S06ID, #TEMP2_EX.S07ID, #TEMP2_EX.S08ID, #TEMP2_EX.S09ID, #TEMP2_EX.S10ID, 
					#TEMP2_EX.S11ID, #TEMP2_EX.S12ID, #TEMP2_EX.S13ID, #TEMP2_EX.S14ID, #TEMP2_EX.S15ID, #TEMP2_EX.S16ID, 
					#TEMP2_EX.S17ID, #TEMP2_EX.S18ID, #TEMP2_EX.S19ID, #TEMP2_EX.S20ID
			FROM #TEMP2_EX

			INSERT INTO #TEMP (DivisionID, WareHouseID, WareHouseName, InventoryID, InventoryName, UnitID, UnitName, InventoryTypeID, Specification, Notes01, Notes02, Notes03,
								AccountID, AccountName, InDebitQuantity, InDebitAmount, S1, S2, S3, I01ID,I02ID,I03ID,
								I04ID,I05ID, I01Name, I02Name, I03Name, I04Name, I05Name, Barcode, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, 
								S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID)
			SELECT #TEMP3_IM.DivisionID, #TEMP3_IM.WareHouseID, #TEMP3_IM.WareHouseName, #TEMP3_IM.InventoryID, #TEMP3_IM.InventoryName, #TEMP3_IM.UnitID, #TEMP3_IM.UnitName, 
					#TEMP3_IM.InventoryTypeID, #TEMP3_IM.Specification, #TEMP3_IM.Notes01, #TEMP3_IM.Notes02, #TEMP3_IM.Notes03,
					#TEMP3_IM.DebitAccountID, #TEMP3_IM.AccountName, #TEMP3_IM.InDebitQuantity, #TEMP3_IM.InDebitAmount,#TEMP3_IM.S1,#TEMP3_IM.S2,#TEMP3_IM.S3, #TEMP3_IM.I01ID,#TEMP3_IM.I02ID,#TEMP3_IM.I03ID,
					#TEMP3_IM.I04ID,#TEMP3_IM.I05ID, #TEMP3_IM.I01Name, #TEMP3_IM.I02Name, #TEMP3_IM.I03Name, #TEMP3_IM.I04Name, #TEMP3_IM.I05Name, #TEMP3_IM.Barcode, 
					#TEMP3_IM.S01ID, #TEMP3_IM.S02ID, #TEMP3_IM.S03ID, #TEMP3_IM.S04ID, 
					#TEMP3_IM.S05ID, #TEMP3_IM.S06ID, #TEMP3_IM.S07ID, #TEMP3_IM.S08ID, #TEMP3_IM.S09ID, #TEMP3_IM.S10ID, 
					#TEMP3_IM.S11ID, #TEMP3_IM.S12ID, #TEMP3_IM.S13ID, #TEMP3_IM.S14ID, #TEMP3_IM.S15ID, #TEMP3_IM.S16ID, 
					#TEMP3_IM.S17ID, #TEMP3_IM.S18ID, #TEMP3_IM.S19ID, #TEMP3_IM.S20ID
			FROM #TEMP3_IM

			INSERT INTO #TEMP (DivisionID, WareHouseID, WareHouseName, InventoryID, InventoryName, UnitID, UnitName, InventoryTypeID, Specification, Notes01, Notes02, Notes03,
								AccountID, AccountName, InCreditQuantity, InCreditAmount, S1, S2, S3,
								I01ID, I02ID, I03ID, I04ID, I05ID, I01Name, I02Name, I03Name, I04Name, I05Name,Barcode, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, 
								S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
								)
			SELECT #TEMP3_EX.DivisionID, #TEMP3_EX.WareHouseID, #TEMP3_EX.WareHouseName, #TEMP3_EX.InventoryID, #TEMP3_EX.InventoryName, #TEMP3_EX.UnitID, #TEMP3_EX.UnitName, 
					#TEMP3_EX.InventoryTypeID, #TEMP3_EX.Specification, #TEMP3_EX.Notes01, #TEMP3_EX.Notes02, #TEMP3_EX.Notes03,
					#TEMP3_EX.CreditAccountID, #TEMP3_EX.AccountName, #TEMP3_EX.InCreditQuantity, #TEMP3_EX.InCreditAmount, #TEMP3_EX.S1, #TEMP3_EX.S2, #TEMP3_EX.S3,
					#TEMP3_EX.I01ID, #TEMP3_EX.I02ID, #TEMP3_EX.I03ID, #TEMP3_EX.I04ID, #TEMP3_EX.I05ID, #TEMP3_EX.I01Name, #TEMP3_EX.I02Name, #TEMP3_EX.I03Name, #TEMP3_EX.I04Name, #TEMP3_EX.I05Name,#TEMP3_EX.Barcode,
					#TEMP3_EX.S01ID, #TEMP3_EX.S02ID, #TEMP3_EX.S03ID, #TEMP3_EX.S04ID, 
					#TEMP3_EX.S05ID, #TEMP3_EX.S06ID, #TEMP3_EX.S07ID, #TEMP3_EX.S08ID, #TEMP3_EX.S09ID, #TEMP3_EX.S10ID, 
					#TEMP3_EX.S11ID, #TEMP3_EX.S12ID, #TEMP3_EX.S13ID, #TEMP3_EX.S14ID, #TEMP3_EX.S15ID, #TEMP3_EX.S16ID, 
					#TEMP3_EX.S17ID, #TEMP3_EX.S18ID, #TEMP3_EX.S19ID, #TEMP3_EX.S20ID
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
					#TEMP.I04Name, #TEMP.I05Name, #TEMP.Barcode, #TEMP.WareHouseID, #TEMP.WareHouseName,
					#TEMP.S01ID, #TEMP.S02ID, #TEMP.S03ID, #TEMP.S04ID, 
					#TEMP.S05ID, #TEMP.S06ID, #TEMP.S07ID, #TEMP.S08ID, #TEMP.S09ID, #TEMP.S10ID, 
					#TEMP.S11ID, #TEMP.S12ID, #TEMP.S13ID, #TEMP.S14ID, #TEMP.S15ID, #TEMP.S16ID, 
					#TEMP.S17ID, #TEMP.S18ID, #TEMP.S19ID, #TEMP.S20ID,
					 '''+@GroupID+''' as GroupID, 
					(SELECT TOP 1 AT1401.GroupName FROM AT1401 WITH(NOLOCK) WHERE AT1401.GroupID = '''+@GroupID+''' ) AS GroupName

			FROM #TEMP
			WHERE  #TEMP.BeginQuantity<>0 OR #TEMP.BeginAmount<>0 
					OR #TEMP.DebitQuantity<>0 OR #TEMP.DebitAmount<>0
					OR #TEMP.CreditQuantity<>0 OR #TEMP.CreditAmount<>0
			GROUP BY #TEMP.DivisionID, #TEMP.InventoryID, #TEMP.InventoryName, #TEMP.UnitID, #TEMP.UnitName, #TEMP.InventoryTypeID,
					#TEMP.Specification,#TEMP.Notes01, #TEMP.Notes02, #TEMP.Notes03, #TEMP.AccountID, #TEMP.AccountName,
					#TEMP.S1, #TEMP.S2, #TEMP.S3, #TEMP.I01ID, #TEMP.I02ID, #TEMP.I03ID, #TEMP.I04ID, #TEMP.I05ID, 
					#TEMP.I01Name, #TEMP.I02Name, #TEMP.I03Name, #TEMP.I04Name, #TEMP.I05Name, #TEMP.Barcode, #TEMP.WareHouseID, #TEMP.WareHouseName,
					#TEMP.S01ID, #TEMP.S02ID, #TEMP.S03ID, #TEMP.S04ID, 
					#TEMP.S05ID, #TEMP.S06ID, #TEMP.S07ID, #TEMP.S08ID, #TEMP.S09ID, #TEMP.S10ID, 
					#TEMP.S11ID, #TEMP.S12ID, #TEMP.S13ID, #TEMP.S14ID, #TEMP.S15ID, #TEMP.S16ID, 
					#TEMP.S17ID, #TEMP.S18ID, #TEMP.S19ID, #TEMP.S20ID
			'
		--select @sql
		--select @sql1
		--select @sql1A
		--select @sql2
		--select @sql3
		--select @sql4
		--select @sql4A
		--select @sql5
		--select @sql6
		EXEC (@SQL+@SQL1+@SQL1A+@SQL2+@SQL3+@SQL4+@SQL4A+@SQL5+@SQL6)

END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
