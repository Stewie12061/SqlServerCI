IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP2009_QC]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP2009_QC]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


---- Created by Bảo Thy on 15/01/2018
---- Purpose: Bao cao ton kho theo mat hang theo quy cách
---- Modified by on
---- Modified by Bảo Thy on 19/01/2018: Bổ sung lọc báo cáo theo quy cách
---- Modified by Bảo Thy on 04/04/2018: bổ sung InventoryID_QC
---- Modified by Nhựt Trường on 02/10/2020: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified by Văn Tài	 on 24/02/2022: Điều chỉnh điều kiện Division dùng chung.
---- Modified by Đức Duy on 13/02/2023: [2023/02/IS/0052] - Bổ sung thêm điều kiện DivisionID dùng chung cho bảng danh mục kho hàng - AT1303.

CREATE PROCEDURE [dbo].[AP2009_QC]
       @DivisionID AS nvarchar(50) ,
       @FromMonth AS int ,
       @ToMonth AS int ,
       @FromYear AS int ,
       @ToYear AS int ,
       @FromDate AS datetime ,
       @ToDate AS datetime ,
       @FromWareHouseID AS nvarchar(50) ,
       @ToWareHouseID AS nvarchar(50) ,
       @FromInventoryID AS nvarchar(50) ,
       @ToInventoryID AS nvarchar(50) ,
       @IsDate AS tinyint,
	   @IsSearchStandard TINYINT,
	   @StandardList XML
AS

DECLARE @CustomerName INT
--Tao bang tam de kiem tra day co phai la khach hang 2T khong (CustomerName = 15)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

DECLARE	@sSQLSelect AS nvarchar(4000) ,
		@sSQLFrom AS nvarchar(4000) ,
		@sSQLWhere AS nvarchar(4000) ,
		@sSQLUnion AS nvarchar(4000), 
		@sSQL AS nvarchar(4000) = '', 
		@FromMonthYearText NVARCHAR(20), 
		@ToMonthYearText NVARCHAR(20), 
		@FromDateText NVARCHAR(20), 
		@ToDateText NVARCHAR(20)
				    
SET @FromMonthYearText = STR(@FromMonth + @FromYear * 100)
SET @ToMonthYearText = STR(@ToMonth + @ToYear * 100)
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

IF ISNULL(@IsSearchStandard,0) = 1
BEGIN
	CREATE TABLE #StandardList_AP2009_QC (InventoryID VARCHAR(50), StandardTypeID VARCHAR(50), StandardID VARCHAR(50))
	
	INSERT INTO #StandardList_AP2009_QC (InventoryID, StandardTypeID, StandardID)
	SELECT	X.Data.query('InventoryID').value('.','VARCHAR(50)') AS InventoryID,
			X.Data.query('StandardTypeID').value('.','VARCHAR(50)') AS StandardTypeID,
			X.Data.query('StandardID').value('.','VARCHAR(50)') AS StandardID
	FROM @StandardList.nodes('//Data') AS X (Data)
END

IF @IsDate = 0  -- theo kỳ
   BEGIN
		 SET @sSQLSelect = '
	Select 	AT2008.DivisionID, AT2008.InventoryID, InventoryName,
	AT2008.WareHouseID,	WareHouseName,
	AT1302.UnitID, 	AT1304.UnitName,
	AT1302.Specification,AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, 
	sum(	Case when TranMonth + TranYear*100 = ' + @FromMonthYearText + '
			then isnull(BeginQuantity, 0) else 0 end) as BeginQuantity,
	sum(	Case when TranMonth + TranYear*100 = ' + @ToMonthYearText + '
			then isnull(EndQuantity, 0) else 0 end) as EndQuantity,
	sum(isnull(DebitQuantity, 0)) as DebitQuantity,
	sum(isnull(CreditQuantity, 0)) as CreditQuantity,
	sum(	Case when TranMonth + TranYear*100 = ' + @FromMonthYearText + '
			then isnull(BeginAmount, 0) else 0 end) as BeginAmount,
	sum(	Case when TranMonth + TranYear*100 = ' + @ToMonthYearText + '
			then isnull(EndAmount, 0) else 0 end) as EndAmount,
	sum(isnull(DebitAmount, 0)) as DebitAmount,
	sum(isnull(CreditAmount, 0)) as CreditAmount,
	sum(isnull(InDebitAmount, 0)) as InDebitAmount,
	sum(isnull(InCreditAmount, 0)) as InCreditAmount,
	sum(isnull(InDebitQuantity, 0)) as InDebitQuantity,
	sum(isnull(InCreditQuantity, 0)) as InCreditQuantity,
	CASE WHEN A.ConvertedQuantity <> 0 THEN Sum(BeginQuantity + DebitQuantity - CreditQuantity) / (A.ConvertedQuantity/3) ELSE 0 END TimeOfUse,
	AT2008.S01ID, AT2008.S02ID, AT2008.S03ID, AT2008.S04ID, AT2008.S05ID, AT2008.S06ID, AT2008.S07ID, AT2008.S08ID, AT2008.S09ID, AT2008.S10ID,
	AT2008.S11ID, AT2008.S12ID, AT2008.S13ID, AT2008.S14ID, AT2008.S15ID, AT2008.S16ID, AT2008.S17ID, AT2008.S18ID, AT2008.S19ID, AT2008.S20ID,
	AT2008.InventoryID + CASE WHEN ISNULL(AT2008.S01ID,'''')<>'''' THEN ''.''+AT2008.S01ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S02ID,'''')<>'''' THEN ''.''+AT2008.S02ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S03ID,'''')<>'''' THEN ''.''+AT2008.S03ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S04ID,'''')<>'''' THEN ''.''+AT2008.S04ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S05ID,'''')<>'''' THEN ''.''+AT2008.S05ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S06ID,'''')<>'''' THEN ''.''+AT2008.S06ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S07ID,'''')<>'''' THEN ''.''+AT2008.S07ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S08ID,'''')<>'''' THEN ''.''+AT2008.S08ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S09ID,'''')<>'''' THEN ''.''+AT2008.S09ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S10ID,'''')<>'''' THEN ''.''+AT2008.S10ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S11ID,'''')<>'''' THEN ''.''+AT2008.S11ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S12ID,'''')<>'''' THEN ''.''+AT2008.S12ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S13ID,'''')<>'''' THEN ''.''+AT2008.S13ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S14ID,'''')<>'''' THEN ''.''+AT2008.S14ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S15ID,'''')<>'''' THEN ''.''+AT2008.S15ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S16ID,'''')<>'''' THEN ''.''+AT2008.S16ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S17ID,'''')<>'''' THEN ''.''+AT2008.S17ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S18ID,'''')<>'''' THEN ''.''+AT2008.S18ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S19ID,'''')<>'''' THEN ''.''+AT2008.S19ID ELSE '''' END+
	CASE WHEN ISNULL(AT2008.S20ID,'''')<>'''' THEN ''.''+AT2008.S20ID ELSE '''' END As InventoryID_QC	'
		 SET @sSQLFrom = '
		 '+CASE WHEN ISNULL(@IsSearchStandard,0) = 1 THEN N'INTO #AP2009_QC_Report' ELSE '' END+'
	From AT2008_QC AT2008
	LEFT JOIN (SELECT WareHouseID, InventoryID, SUM(ISNULL(ConvertedQuantity,0)) ConvertedQuantity, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID,
				S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID FROM AV7001
				WHERE DivisionID = '''+@DivisionID+'''
				AND TranYear*12 + TranMonth BETWEEN '+STR(@FromYear*12+@FromMonth)+' AND '+STR(@ToYear*12+@ToMonth)+'
				AND D_C = ''C''
				GROUP BY WareHouseID, InventoryID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
			)A ON A.WareHouseID = AT2008.WareHouseID AND A.InventoryID = AT2008.InventoryID
			AND ISNULL(AT2008.S01ID,'''') = Isnull(A.S01ID,'''') AND ISNULL(AT2008.S02ID,'''') = isnull(A.S02ID,'''')
			AND ISNULL(AT2008.S03ID,'''') = isnull(A.S03ID,'''') AND ISNULL(AT2008.S04ID,'''') = isnull(A.S04ID,'''')
			AND ISNULL(AT2008.S05ID,'''') = isnull(A.S05ID,'''') AND ISNULL(AT2008.S06ID,'''') = isnull(A.S06ID,'''')
			AND ISNULL(AT2008.S07ID,'''') = isnull(A.S07ID,'''') AND ISNULL(AT2008.S08ID,'''') = isnull(A.S08ID,'''') 
			AND ISNULL(AT2008.S09ID,'''') = isnull(A.S09ID,'''') AND ISNULL(AT2008.S10ID,'''') = isnull(A.S10ID,'''') 
			AND ISNULL(AT2008.S11ID,'''') = isnull(A.S11ID,'''') AND ISNULL(AT2008.S12ID,'''') = isnull(A.S12ID,'''') 
			AND ISNULL(AT2008.S13ID,'''') = isnull(A.S13ID,'''') AND ISNULL(AT2008.S14ID,'''') = isnull(A.S14ID,'''') 
			AND ISNULL(AT2008.S15ID,'''') = isnull(A.S15ID,'''') AND ISNULL(AT2008.S16ID,'''') = isnull(A.S16ID,'''') 
			AND ISNULL(AT2008.S17ID,'''') = isnull(A.S17ID,'''') AND ISNULL(AT2008.S18ID,'''') = isnull(A.S18ID,'''') 
			AND ISNULL(AT2008.S19ID,'''') = isnull(A.S19ID,'''') AND ISNULL(AT2008.S20ID,'''') = isnull(A.S20ID,'''')
	inner join AT1303 on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AT2008.WareHouseID
	inner join AT1302 on AT1302.DivisionID IN (AT2008.DivisionID,''@@@'') AND AT1302.InventoryID = AT2008.InventoryID
	inner join AT1304 on AT1304.DivisionID IN (AT1302.DivisionID, ''' + @DivisionID + ''' , ''@@@'') AND AT1302.UnitID = AT1304.UnitID'

		 SET @sSQLWhere = '
	Where AT2008.DivisionID =''' + @DivisionID + ''' and
	(AT2008.InventoryID between N''' + @FromInventoryID + ''' and N''' + @ToInventoryID + ''') and
	(TranMonth + TranYear*100 between ''' + @FromMonthYearText + ''' and ''' + @ToMonthYearText + ''') and
	(AT2008.WareHouseID between N''' + @FromWareHouseID + ''' and N''' + @ToWareHouseID + ''')
    Group By AT2008.DivisionID, AT2008.InventoryID, InventoryName, AT2008.WareHouseID, WareHouseName,AT1302.UnitID ,AT1304.UnitName,
	AT1302.Specification,AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, A.ConvertedQuantity,
	AT2008.S01ID, AT2008.S02ID, AT2008.S03ID, AT2008.S04ID, AT2008.S05ID, AT2008.S06ID, AT2008.S07ID, AT2008.S08ID, AT2008.S09ID, AT2008.S10ID,
	AT2008.S11ID, AT2008.S12ID, AT2008.S13ID, AT2008.S14ID, AT2008.S15ID, AT2008.S16ID, AT2008.S17ID, AT2008.S18ID, AT2008.S19ID, AT2008.S20ID '
   END
ELSE            -- theo ngày
   BEGIN
		SET @sSQLSelect = ' Select 	DivisionID, WareHouseID,	InventoryID, InventoryName, UnitID, UnitName,
		Specification, Notes01, Notes02, Notes03, 	
		--InventoryID+WareHouseID as Key1, 
		(ltrim(rtrim(InventoryID)) + ltrim(rtrim(WareHouseID))) as Key1, 
		 S1, S2, S3 ,
		S1Name,  S2Name, S3Name,				
		Sum(SignQuantity) as BeginQuantity,
		Sum(SignAmount) as BeginAmount,S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID'

		SET @sSQLFrom = ' From AV7000'
		SET @sSQLWhere = ' Where 	( VoucherDate<''' + @FromDateText + '''  or D_C =''BD'') and
		DivisionID like ''' + @DivisionID + ''' and
		(WareHouseID between N''' + @FromWareHouseID + ''' and N''' + @ToWareHouseID + ''')  And
		(InventoryID between N''' + @FromInventoryID + ''' and N''' + @ToInventoryID + ''') 
		Group by  DivisionID, WareHouseID,InventoryID,InventoryName, UnitID, UnitName, Specification, Notes01, Notes02, Notes03, 
		S1, S2, S3 ,S1Name,  S2Name, S3Name,S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID '
   
	IF NOT EXISTS ( SELECT TOP 1 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV7018' )
	   BEGIN
			 EXEC ( ' Create view AV7018 --AP2009_QC
			 as '+@sSQLSelect+@sSQLFrom+@sSQLWhere )
	   END
	ELSE
	   BEGIN
			 EXEC ( ' Alter view AV7018 as  --AP2009_QC
			 '+@sSQLSelect+@sSQLFrom+@sSQLWhere )
	   END

	SET @sSQLSelect = 'Select 	AV7018.DivisionID, AV7018.InventoryID,
		AT1302.InventoryName,
		AV7018.WareHouseID,
		AT1303.WareHouseName,
		AV7018.UnitID,
		AV7018.UnitName,
		AV7018.Specification, AV7018.Notes01, AV7018.Notes02, AV7018.Notes03, 	
		isnull(AV7018.BeginQuantity,0) as BeginQuantity,
		isnull(AV7018.BeginAmount,0) as BeginAmount,
		0 as DebitQuantity,
		0 as CreditQuantity,
		0 as DebitAmount,
		0 as CreditAmount,
		0 as EndQuantity,
		0 as EndAmount,
		AV7018.S01ID, AV7018.S02ID, AV7018.S03ID, AV7018.S04ID, AV7018.S05ID, AV7018.S06ID, AV7018.S07ID, AV7018.S08ID, AV7018.S09ID, AV7018.S10ID,
		AV7018.S11ID, AV7018.S12ID, AV7018.S13ID, AV7018.S14ID, AV7018.S15ID, AV7018.S16ID, AV7018.S17ID, AV7018.S18ID, AV7018.S19ID, AV7018.S20ID'

	SET @sSQLFrom = ' From AV7018 inner join AT1302 on AT1302.DivisionID IN (AV7018.DivisionID,''@@@'') ANDAT1302.InventoryID =AV7018.InventoryID
			inner join AT1303 on AT1303.DivisionID IN (''' + @DivisionID + ''',''@@@'') AND AT1303.WareHouseID = AV7018.WareHouseID'

	SET @sSQLWhere = ' where 	(AV7018.WareHouseID between ''' + @FromWareHouseID + ''' and ''' + @ToWareHouseID + ''') and
			AV7018.Key1 not in (Select  (ltrim(rtrim(InventoryID)) + ltrim(rtrim(WareHouseID)))  as Key1 From AV7000 
								 Where 	AV7000.DivisionID =''' + @DivisionID + ''' and
								(AV7000.WareHouseID between N''' + @FromWareHouseID + ''' and N''' + @ToWareHouseID + ''') and
								(AV7000.InventoryID between N''' + @FromInventoryID + ''' and N''' + @ToInventoryID + ''') and
								AV7000.D_C in (''D'', ''C'') and AV7000.VoucherDate between ''' + @FromDateText + ''' and ''' + @ToDateText + '''
								AND ISNULL(AV7018.S01ID,'''') = Isnull(AV7000.S01ID,'''') AND ISNULL(AV7018.S02ID,'''') = isnull(AV7000.S02ID,'''')
								AND ISNULL(AV7018.S03ID,'''') = isnull(AV7000.S03ID,'''') AND ISNULL(AV7018.S04ID,'''') = isnull(AV7000.S04ID,'''')
								AND ISNULL(AV7018.S05ID,'''') = isnull(AV7000.S05ID,'''') AND ISNULL(AV7018.S06ID,'''') = isnull(AV7000.S06ID,'''')
								AND ISNULL(AV7018.S07ID,'''') = isnull(AV7000.S07ID,'''') AND ISNULL(AV7018.S08ID,'''') = isnull(AV7000.S08ID,'''') 
								AND ISNULL(AV7018.S09ID,'''') = isnull(AV7000.S09ID,'''') AND ISNULL(AV7018.S10ID,'''') = isnull(AV7000.S10ID,'''') 
								AND ISNULL(AV7018.S11ID,'''') = isnull(AV7000.S11ID,'''') AND ISNULL(AV7018.S12ID,'''') = isnull(AV7000.S12ID,'''') 
								AND ISNULL(AV7018.S13ID,'''') = isnull(AV7000.S13ID,'''') AND ISNULL(AV7018.S14ID,'''') = isnull(AV7000.S14ID,'''') 
								AND ISNULL(AV7018.S15ID,'''') = isnull(AV7000.S15ID,'''') AND ISNULL(AV7018.S16ID,'''') = isnull(AV7000.S16ID,'''') 
								AND ISNULL(AV7018.S17ID,'''') = isnull(AV7000.S17ID,'''') AND ISNULL(AV7018.S18ID,'''') = isnull(AV7000.S18ID,'''') 
								AND ISNULL(AV7018.S19ID,'''') = isnull(AV7000.S19ID,'''') AND ISNULL(AV7018.S20ID,'''') = isnull(AV7000.S20ID,''''))
	Group by  AV7018.DivisionID, AV7018.InventoryID, AT1302.InventoryName, AV7018.WareHouseID, AT1303.WareHouseName, 
			AV7018.UnitID, AV7018.UnitName, 
			AV7018.Specification, AV7018.Notes01, AV7018.Notes02, AV7018.Notes03, 	
			AV7018.BeginQuantity,AV7018.BeginAmount, AV7018.S01ID, AV7018.S02ID, AV7018.S03ID, AV7018.S04ID, AV7018.S05ID, AV7018.S06ID, AV7018.S07ID, AV7018.S08ID, AV7018.S09ID, AV7018.S10ID,
		AV7018.S11ID, AV7018.S12ID, AV7018.S13ID, AV7018.S14ID, AV7018.S15ID, AV7018.S16ID, AV7018.S17ID, AV7018.S18ID, AV7018.S19ID, AV7018.S20ID'
	SET @sSQLUnion = ' Union all
	Select 	AV7000.DivisionID, AV7000.InventoryID,
		AT1302.InventoryName,
		AV7000.WareHouseID,
		AT1303.WareHouseName,
		AV7000.UnitID, 
		AV7000.UnitName,
		AV7000.Specification, AV7000.Notes01, AV7000.Notes02, AV7000.Notes03, 	
		isnull(AV7018.BeginQuantity,0) as BeginQuantity,
		isnull(AV7018.BeginAmount,0) as BeginAmount,
		Sum(Case when D_C = ''D'' then isnull(AV7000.ActualQuantity,0) else 0 end) as DebitQuantity,
		Sum(Case when D_C = ''C'' then isnull(AV7000.ActualQuantity,0) else 0 end) as CreditQuantity,
		Sum(Case when D_C = ''D'' then isnull(AV7000.ConvertedAmount,0) else 0 end) as DebitAmount,
		Sum(Case when D_C = ''C'' then isnull(AV7000.ConvertedAmount,0) else 0 end) as CreditAmount,
		0 as EndQuantity,
		0 as EndAmount, AV7000.S01ID, AV7000.S02ID, AV7000.S03ID, AV7000.S04ID, AV7000.S05ID, AV7000.S06ID, AV7000.S07ID, AV7000.S08ID, AV7000.S09ID, AV7000.S10ID,
		AV7000.S11ID, AV7000.S12ID, AV7000.S13ID, AV7000.S14ID, AV7000.S15ID, AV7000.S16ID, AV7000.S17ID, AV7000.S18ID, AV7000.S19ID, AV7000.S20ID
	From AV7000 left join AV7018 on AV7000.WareHouseID = AV7018.WareHouseID and AV7000.InventoryID = AV7018.InventoryID and AV7000.DivisionID = AV7018.DivisionID
								 AND ISNULL(AV7018.S01ID,'''') = Isnull(AV7000.S01ID,'''') AND ISNULL(AV7018.S02ID,'''') = isnull(AV7000.S02ID,'''')
								 AND ISNULL(AV7018.S03ID,'''') = isnull(AV7000.S03ID,'''') AND ISNULL(AV7018.S04ID,'''') = isnull(AV7000.S04ID,'''')
								 AND ISNULL(AV7018.S05ID,'''') = isnull(AV7000.S05ID,'''') AND ISNULL(AV7018.S06ID,'''') = isnull(AV7000.S06ID,'''')
								 AND ISNULL(AV7018.S07ID,'''') = isnull(AV7000.S07ID,'''') AND ISNULL(AV7018.S08ID,'''') = isnull(AV7000.S08ID,'''') 
								 AND ISNULL(AV7018.S09ID,'''') = isnull(AV7000.S09ID,'''') AND ISNULL(AV7018.S10ID,'''') = isnull(AV7000.S10ID,'''') 
								 AND ISNULL(AV7018.S11ID,'''') = isnull(AV7000.S11ID,'''') AND ISNULL(AV7018.S12ID,'''') = isnull(AV7000.S12ID,'''') 
								 AND ISNULL(AV7018.S13ID,'''') = isnull(AV7000.S13ID,'''') AND ISNULL(AV7018.S14ID,'''') = isnull(AV7000.S14ID,'''') 
								 AND ISNULL(AV7018.S15ID,'''') = isnull(AV7000.S15ID,'''') AND ISNULL(AV7018.S16ID,'''') = isnull(AV7000.S16ID,'''') 
								 AND ISNULL(AV7018.S17ID,'''') = isnull(AV7000.S17ID,'''') AND ISNULL(AV7018.S18ID,'''') = isnull(AV7000.S18ID,'''') 
								 AND ISNULL(AV7018.S19ID,'''') = isnull(AV7000.S19ID,'''') AND ISNULL(AV7018.S20ID,'''') = isnull(AV7000.S20ID,'''')
			inner join AT1302 on AT1302.DivisionID IN (AV7000.DivisionID,''@@@'') AND AT1302.InventoryID = AV7000.InventoryID
			inner join AT1303 on AT1303.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AT1303.WareHouseID = AV7000.WareHouseID
			
	Where 	AV7000.DivisionID =''' + @DivisionID + ''' and
		(AV7000.InventoryID between N''' + @FromInventoryID + ''' and N''' + @ToInventoryID + ''') and
		(AV7000.WareHouseID between N''' + @FromWareHouseID + ''' and N''' + @ToWareHouseID + ''') and
		AV7000.D_C in (''D'', ''C'') and
		AV7000.VoucherDate between ''' + @FromDateText + ''' and ''' + @ToDateText + '''
	Group by  AV7000.DivisionID, AV7000.InventoryID, AT1302.InventoryName, AV7000.WareHouseID, AT1303.WareHouseName,AV7000.UnitName,
			AV7000.Specification, AV7000.Notes01, AV7000.Notes02, AV7000.Notes03, 	
			AV7000.UnitID, 	AV7018.BeginQuantity,AV7018.BeginAmount, AV7000.S01ID, AV7000.S02ID, AV7000.S03ID, AV7000.S04ID, AV7000.S05ID, 
			AV7000.S06ID, AV7000.S07ID, AV7000.S08ID, AV7000.S09ID, AV7000.S10ID, AV7000.S11ID, AV7000.S12ID, AV7000.S13ID, AV7000.S14ID, AV7000.S15ID,
			AV7000.S16ID, AV7000.S17ID, AV7000.S18ID, AV7000.S19ID, AV7000.S20ID'


	--print @sSQL

IF NOT EXISTS ( SELECT TOP 1 1 FROM sysObjects WHERE Xtype = 'V' AND Name = 'AV2089' )
   BEGIN
		 EXEC ( ' Create view AV2089 as --AP2009_QC
		 '+@sSQLSelect+@sSQLFrom+@sSQLWhere+@sSQLUnion )
   END
ELSE
   BEGIN
		 EXEC ( ' Alter view AV2089 as  --AP2009_QC
		 '+@sSQLSelect+@sSQLFrom+@sSQLWhere+@sSQLUnion )
   END

SET @sSQLSelect = 'Select 	DivisionID, AV2089.InventoryID, InventoryName,
	AV2089.WareHouseID,	WareHouseName,
	AV2089.UnitID, 
	AV2089.UnitName,
	AV2089.Specification, AV2089.Notes01, AV2089.Notes02, AV2089.Notes03, 	
	Sum(BeginQuantity) as BeginQuantity,
	Sum(BeginAmount) as BeginAmount, 
	Sum(DebitQuantity) as DebitQuantity,
	Sum(CreditQuantity) as CreditQuantity,
	Sum(DebitAmount) as DebitAmount,
	Sum(CreditAmount) as CreditAmount,
	Sum(BeginQuantity + DebitQuantity - CreditQuantity) as EndQuantity,
	Sum(BeginAmount + DebitAmount - CreditAmount) as EndAmount,
	CASE WHEN A.ConvertedQuantity <> 0 THEN Sum(BeginQuantity + DebitQuantity - CreditQuantity) / (A.ConvertedQuantity/3) ELSE 0 END TimeOfUse,
	AV2089.S01ID, AV2089.S02ID, AV2089.S03ID, AV2089.S04ID, AV2089.S05ID, AV2089.S06ID, AV2089.S07ID, AV2089.S08ID, AV2089.S09ID, AV2089.S10ID,
	AV2089.S11ID, AV2089.S12ID, AV2089.S13ID, AV2089.S14ID, AV2089.S15ID, AV2089.S16ID, AV2089.S17ID, AV2089.S18ID, AV2089.S19ID, AV2089.S20ID,
	AV2089.InventoryID + CASE WHEN ISNULL(AV2089.S01ID,'''')<>'''' THEN ''.''+AV2089.S01ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S02ID,'''')<>'''' THEN ''.''+AV2089.S02ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S03ID,'''')<>'''' THEN ''.''+AV2089.S03ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S04ID,'''')<>'''' THEN ''.''+AV2089.S04ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S05ID,'''')<>'''' THEN ''.''+AV2089.S05ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S06ID,'''')<>'''' THEN ''.''+AV2089.S06ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S07ID,'''')<>'''' THEN ''.''+AV2089.S07ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S08ID,'''')<>'''' THEN ''.''+AV2089.S08ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S09ID,'''')<>'''' THEN ''.''+AV2089.S09ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S10ID,'''')<>'''' THEN ''.''+AV2089.S10ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S11ID,'''')<>'''' THEN ''.''+AV2089.S11ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S12ID,'''')<>'''' THEN ''.''+AV2089.S12ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S13ID,'''')<>'''' THEN ''.''+AV2089.S13ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S14ID,'''')<>'''' THEN ''.''+AV2089.S14ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S15ID,'''')<>'''' THEN ''.''+AV2089.S15ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S16ID,'''')<>'''' THEN ''.''+AV2089.S16ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S17ID,'''')<>'''' THEN ''.''+AV2089.S17ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S18ID,'''')<>'''' THEN ''.''+AV2089.S18ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S19ID,'''')<>'''' THEN ''.''+AV2089.S19ID ELSE '''' END+
	CASE WHEN ISNULL(AV2089.S20ID,'''')<>'''' THEN ''.''+AV2089.S20ID ELSE '''' END As InventoryID_QC '		

SET @sSQLFrom= '
'+CASE WHEN ISNULL(@IsSearchStandard,0) = 1 THEN N'INTO #AP2009_QC_Report' ELSE '' END+'
FROM AV2089
LEFT JOIN (SELECT WareHouseID, InventoryID, SUM(ISNULL(ConvertedQuantity,0)) ConvertedQuantity,S01ID, S02ID, S03ID, S04ID, S05ID, 
			S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID 
			FROM AV7001
			WHERE DivisionID = '''+@DivisionID+'''
			AND TranYear*12 + TranMonth BETWEEN '+STR(@FromYear*12+@FromMonth)+' AND '+STR(@ToYear*12+@ToMonth)+'
			AND D_C = ''C''
			GROUP BY WareHouseID, InventoryID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID)A
ON A.WareHouseID = AV2089.WareHouseID AND A.InventoryID = AV2089.InventoryID
AND ISNULL(AV2089.S01ID,'''') = Isnull(A.S01ID,'''') AND ISNULL(AV2089.S02ID,'''') = isnull(A.S02ID,'''')
AND ISNULL(AV2089.S03ID,'''') = isnull(A.S03ID,'''') AND ISNULL(AV2089.S04ID,'''') = isnull(A.S04ID,'''')
AND ISNULL(AV2089.S05ID,'''') = isnull(A.S05ID,'''') AND ISNULL(AV2089.S06ID,'''') = isnull(A.S06ID,'''')
AND ISNULL(AV2089.S07ID,'''') = isnull(A.S07ID,'''') AND ISNULL(AV2089.S08ID,'''') = isnull(A.S08ID,'''') 
AND ISNULL(AV2089.S09ID,'''') = isnull(A.S09ID,'''') AND ISNULL(AV2089.S10ID,'''') = isnull(A.S10ID,'''') 
AND ISNULL(AV2089.S11ID,'''') = isnull(A.S11ID,'''') AND ISNULL(AV2089.S12ID,'''') = isnull(A.S12ID,'''') 
AND ISNULL(AV2089.S13ID,'''') = isnull(A.S13ID,'''') AND ISNULL(AV2089.S14ID,'''') = isnull(A.S14ID,'''') 
AND ISNULL(AV2089.S15ID,'''') = isnull(A.S15ID,'''') AND ISNULL(AV2089.S16ID,'''') = isnull(A.S16ID,'''') 
AND ISNULL(AV2089.S17ID,'''') = isnull(A.S17ID,'''') AND ISNULL(AV2089.S18ID,'''') = isnull(A.S18ID,'''') 
AND ISNULL(AV2089.S19ID,'''') = isnull(A.S19ID,'''') AND ISNULL(AV2089.S20ID,'''') = isnull(A.S20ID,'''')'
			
							
set @sSQLWhere= ' Where (BeginQuantity <> 0 or BeginAmount <> 0 or DebitQuantity <> 0 or DebitAmount <> 0 or
	CreditQuantity <> 0 or CreditAmount <> 0 or EndQuantity <> 0 or EndAmount <> 0) and DivisionID = ''' + @DivisionID + '''
Group by  DivisionID, AV2089.InventoryID, InventoryName, AV2089.WareHouseID, WareHouseName, UnitID, UnitName,
	AV2089.Specification, AV2089.Notes01, AV2089.Notes02, AV2089.Notes03, A.ConvertedQuantity,
	AV2089.S01ID, AV2089.S02ID, AV2089.S03ID, AV2089.S04ID, AV2089.S05ID, AV2089.S06ID, AV2089.S07ID, AV2089.S08ID, AV2089.S09ID, AV2089.S10ID,
	AV2089.S11ID, AV2089.S12ID, AV2089.S13ID, AV2089.S14ID, AV2089.S15ID, AV2089.S16ID, AV2089.S17ID, AV2089.S18ID, AV2089.S19ID, AV2089.S20ID'

	END

	IF ISNULL(@IsSearchStandard,0) = 1
	BEGIN
		SET @sSQL = '
	SELECT * 
	FROM
	(
		SELECT T1.*
		FROM #AP2009_QC_Report AS T1
		INNER JOIN #StandardList_AP2009_QC T2 ON T1.InventoryID = T2.InventoryID
		WHERE 
		(	T2.StandardTypeID = ''S01'' AND ISNULL(T1.S01ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S02'' AND ISNULL(T1.S02ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S03'' AND ISNULL(T1.S03ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S04'' AND ISNULL(T1.S04ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S05'' AND ISNULL(T1.S05ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S06'' AND ISNULL(T1.S06ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S07'' AND ISNULL(T1.S07ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S08'' AND ISNULL(T1.S08ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S09'' AND ISNULL(T1.S09ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S10'' AND ISNULL(T1.S10ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S11'' AND ISNULL(T1.S11ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S12'' AND ISNULL(T1.S12ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S13'' AND ISNULL(T1.S13ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S14'' AND ISNULL(T1.S14ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S15'' AND ISNULL(T1.S15ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S16'' AND ISNULL(T1.S16ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S17'' AND ISNULL(T1.S17ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S18'' AND ISNULL(T1.S18ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S19'' AND ISNULL(T1.S19ID,'''') = T2.StandardID)
		OR (T2.StandardTypeID = ''S20'' AND ISNULL(T1.S20ID,'''') = T2.StandardID)
		UNION ALL
		SELECT  T1.*
		FROM #AP2009_QC_Report AS T1
		WHERE NOT EXISTS (SELECT TOP 1 1 FROM #StandardList_AP2009_QC T2 WHERE T1.InventoryID = T2.InventoryID)
		AND ISNULL(T1.S01ID,'''') = '''' AND ISNULL(T1.S02ID,'''') = '''' AND ISNULL(T1.S03ID,'''') = ''''
		AND ISNULL(T1.S04ID,'''') = '''' AND ISNULL(T1.S05ID,'''') = '''' AND ISNULL(T1.S06ID,'''') = '''' 
		AND ISNULL(T1.S07ID,'''') = '''' AND ISNULL(T1.S08ID,'''') = '''' AND ISNULL(T1.S09ID,'''') = '''' 
		AND ISNULL(T1.S10ID,'''') = '''' AND ISNULL(T1.S11ID,'''') = '''' AND ISNULL(T1.S12ID,'''') = '''' 
		AND ISNULL(T1.S13ID,'''') = '''' AND ISNULL(T1.S14ID,'''') = '''' AND ISNULL(T1.S15ID,'''') = '''' 
		AND ISNULL(T1.S16ID,'''') = '''' AND ISNULL(T1.S17ID,'''') = '''' AND ISNULL(T1.S18ID,'''') = '''' 
		AND ISNULL(T1.S19ID,'''') = '''' AND ISNULL(T1.S20ID,'''') = '''' 
	)Temp'

	END

	--print @sSQLSelect
	--print @sSQLFrom
	--print @sSQLWhere
	--print @sSQL

	EXEC (@sSQLSelect + @sSQLFrom + @sSQLWhere + @sSQL)
	
	--IF NOT EXISTS ( SELECT
	--					1
	--				FROM
	--					sysObjects
	--				WHERE
	--					Xtype = 'V' AND Name = 'AV2009' )
	--   BEGIN
	--		 EXEC ( ' Create view AV2009 as  --AP2009_QC
	--		 '+@sSQLSelect+@sSQLFrom+@sSQLWhere  )
	--   END
	--ELSE
	--   BEGIN
	--		 EXEC ( ' Alter view AV2009 as  --AP2009_QC
	--		 '+@sSQLSelect+@sSQLFrom+@sSQLWhere  )
	--/*
	--Set @sSQL = 
	--'SELECT AV2099.*,  AT1304.UnitName  F
	--	ROM AV2099  inner join AT1304 on AT1304.UnitID = AV2099.UnitID
	--Where BeginQuantity <> 0 or BeginAmount <> 0 or DebitQuantity <> 0 or DebitAmount <> 0 or
	--	CreditQuantity <> 0 or CreditAmount <> 0 or EndQuantity <> 0 or EndAmount <>0 
	-- '

	--If not Exists (Select 1 From  sysObjects Where Xtype ='V' and Name ='AV2009')
	--	Exec(' Create view AV2009 as '+@sSQL)
	--Else
	--	Exec(' Alter view AV2009 as '+@sSQL)
	--*/
	--   END
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
