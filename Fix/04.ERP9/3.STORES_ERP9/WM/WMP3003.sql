IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP3003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP3003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Lọc theo mã phân tích theo nghiệp vụ
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 22/02/2022 by Anh Tuấn theo store AP0720 ERP8
---- Modified on 23/06/2022 by Hoài Bảo - Bổ sung Exec store tạo View AV7008 [WMP30031], clone từ store AP7000 ERP8
---- Modified on 07/06/2023 by Anh Đô - Select thêm cột DivisionName, VoucherTypeName
---- Modified on 19/12/2023 by Thanh Lượng: [2023/11/TA/0219] - Bổ sung chỉnh sửa điều kiện nếu không nhập "Mặt hàng".
---- Modified on 22/12/2023 by Nhật Thanh: Bổ sung xử lý dữ liệu theo voucherid
---- Modified on 28/12/2023 by Thanh Lượng: [2023/12/TA/0242] - Fix lỗi Invalid objectName ISNULL.
-- <Example>
---- 
/*
	EXEC WMP3003  @DivisionID, @DivisionIDList, @WareHouseID, @ObjectID, @InventoryID, @IsDate, @UserID, @FromDate, @ToDate, @PeriodList
*/
CREATE PROCEDURE [dbo].[WMP3003] 		
(
	@DivisionID			AS NVARCHAR(50),
	@DivisionIDList		AS NVARCHAR(MAX),					
	@WareHouseID		AS NVARCHAR(50),
	@ObjectID			AS NVARCHAR(MAX),
	@InventoryID		AS NVARCHAR(MAX),
	@FromDate			AS DATETIME,
	@ToDate				AS DATETIME,
	@IsDate				AS TINYINT,
	@PeriodList			AS NVARCHAR(2000),
	@FromAna01ID	NVARCHAR(50) = '',	@ToAna01ID	NVARCHAR(50) = NULL,
	@FromAna02ID	NVARCHAR(50) = NULL,	@ToAna02ID	NVARCHAR(50) = NULL,
	@FromAna03ID	NVARCHAR(50) = NULL,	@ToAna03ID	NVARCHAR(50) = NULL,
	@FromAna04ID	NVARCHAR(50) = NULL,	@ToAna04ID	NVARCHAR(50) = NULL,
	@FromAna05ID	NVARCHAR(50) = NULL,	@ToAna05ID	NVARCHAR(50) = NULL,
	@FromAna06ID	NVARCHAR(50) = NULL,	@ToAna06ID	NVARCHAR(50) = NULL,
	@FromAna07ID	NVARCHAR(50) = NULL,	@ToAna07ID	NVARCHAR(50) = NULL,
	@FromAna08ID	NVARCHAR(50) = NULL,	@ToAna08ID	NVARCHAR(50) = NULL,
	@FromAna09ID	NVARCHAR(50) = NULL,	@ToAna09ID	NVARCHAR(50) = NULL,
	@FromAna10ID	NVARCHAR(50) = NULL,	@ToAna10ID	NVARCHAR(50) = NULL
)
AS
Declare 
--@sSQL AS NVARCHAR(4000),
	@sqlSelect1				AS NVARCHAR(MAX),
    @sqlFrom1				AS VARCHAR(MAX),
    @sqlWhere1				AS VARCHAR(MAX),
    @sqlGroupBy1			AS VARCHAR(MAX),
	@sqlSelect2				AS VARCHAR(MAX),
    @sqlFrom2				AS VARCHAR(MAX),
    @sqlWhere2				AS VARCHAR(MAX),
    @sqlGroupBy2			AS VARCHAR(MAX),
	@sqlSelect3				AS VARCHAR(MAX),
    @sqlFrom3				AS VARCHAR(MAX),
    @sqlWhere3				AS VARCHAR(MAX),
    @sqlGroupBy3			AS VARCHAR(MAX),
	@WareHouseName			AS NVARCHAR(MAX),
	@WareHouseID2			AS NVARCHAR(50),
	@strTimePS				AS NVARCHAR(4000),
	@strTimeSD				AS NVARCHAR(4000),
	@AnaWhere				AS NVARCHAR(MAX), 
    @FromDateText			NVARCHAR(20), 
    @ToDateText				NVARCHAR(20),
    @WareHouseWhere			NVARCHAR(250),
	@sqlSelectUnion			AS NVARCHAR(MAX)='',
	@sqlWhereUnion			AS NVARCHAR(MAX)='',
	@CustomerName			INT,
	@sqlSelect3a			VARCHAR(MAX) = '',
	@sqlGroupBy3a			VARCHAR(MAX) = '',
	@sqlFrom3a				VARCHAR(MAX) = '',
	@sWhere1				VARCHAR(MAX) = '',
	@sWhere2				VARCHAR(MAX) = '',
	@sWhere3				VARCHAR(MAX) = ''
  
--Tao bang tam kiem tra khach hang SaigonPetro (CustomerName = 36)
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName) 

SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

SET @AnaWhere = ''
SET @WareHouseWhere = ''

IF ISNULL(@InventoryID, '') <> ''
BEGIN
	SET @sWhere1 = @sWhere1 + N'and (AV7008.InventoryID IN (SELECT * FROM StringSplit(REPLACE('''+@InventoryID+''', '''''''', ''''), '',''))) '
	SET @sWhere2 = @sWhere2 + N'and (AV7008.InventoryID IN (SELECT * FROM StringSplit(REPLACE('''+@InventoryID+''', '''''''', ''''), '',''))) '
	SET @sWhere3 = @sWhere3 + N'and (AV7008.InventoryID IN (SELECT * FROM StringSplit(REPLACE('''+@InventoryID+''', '''''''', ''''), '',''))) '	
END

--------->>>> Lấy dữ liệu Hàng tồn kho
DECLARE @IsTime AS TINYINT
IF @IsDate = 0 SET @IsTime = 1
IF @IsDate = 1	SET @IsTime = 2

EXEC WMP30031 @DivisionID , 'ASOFTADMIN', @WareHouseID, @InventoryID, @ObjectID, @IsTime, '', '', '', '', '', ''
--select * from AV7008

-------- Trả ra AV7008
-------- Thay thế cho AV7000
---------<<<< Lấy dữ liệu Hàng tồn kho

	If Patindex('[%]',@FromAna01ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana01ID Like N''' + @FromAna01ID + ''''
		End
	Else
		If @FromAna01ID is not null  And  @FromAna01ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana01ID,'''') >= N''' + Replace(@FromAna01ID,'[]','') + ''' And Isnull(AV7008.Ana01ID,'''') <= N''' + Replace(@ToAna01ID,'[]','') + ''''
			End	

	If Patindex('[%]',@FromAna02ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana02ID Like N''' + @FromAna02ID + ''''
		End
	Else
		If @FromAna02ID is not null  And @FromAna02ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana02ID,'''') >= N''' + Replace(@FromAna02ID,'[]','') + ''' And Isnull(AV7008.Ana02ID,'''') <= N''' + Replace(@ToAna02ID,'[]','') + ''''
			End	

	If Patindex('[%]',@FromAna03ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana03ID Like N''' + @FromAna03ID + ''''
		End
	Else
		If @FromAna03ID is not null  And @FromAna03ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana03ID,'''') >= N''' + Replace(@FromAna03ID,'[]','') + ''' And Isnull(AV7008.Ana03ID,'''') <= N''' + Replace(@ToAna03ID,'[]','') + ''''
			End	

	If Patindex('[%]',@FromAna04ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana04ID Like N''' + @FromAna04ID + ''''
		End
	Else 
		If @FromAna04ID is not null  And @FromAna04ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana04ID,'''') >= N''' + Replace(@FromAna04ID,'[]','') + ''' And Isnull(AV7008.Ana04ID,'''') <= N''' + Replace(@ToAna04ID,'[]','') + ''''
			End	

	If Patindex('[%]',@FromAna05ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana05ID Like N''' + @FromAna05ID + ''''
		End
	Else
		If @FromAna05ID is not null  And @FromAna05ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana05ID,'''') >= N''' + Replace(@FromAna05ID,'[]','') + ''' And Isnull(AV7008.Ana05ID,'''') <= N''' + Replace(@ToAna05ID,'[]','') + ''''
			End
			
	If Patindex('[%]',@FromAna06ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana06ID Like N''' + @FromAna06ID + ''''
		End
	Else
		If @FromAna06ID is not null  And  @FromAna06ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana06ID,'''') >= N''' + Replace(@FromAna06ID,'[]','') + ''' And Isnull(AV7008.Ana06ID,'''') <= N''' + Replace(@ToAna06ID,'[]','') + ''''
			End	

	If Patindex('[%]',@FromAna07ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana07ID Like N''' + @FromAna07ID + ''''
		End
	Else
		If @FromAna07ID is not null  And @FromAna07ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana07ID,'''') >= N''' + Replace(@FromAna07ID,'[]','') + ''' And Isnull(AV7008.Ana07ID,'''') <= N''' + Replace(@ToAna07ID,'[]','') + ''''
			End	

	If Patindex('[%]',@FromAna08ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana08ID Like N''' + @FromAna08ID + ''''
		End
	Else
		If @FromAna08ID is not null  And @FromAna08ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana08ID,'''') >= N''' + Replace(@FromAna08ID,'[]','') + ''' And Isnull(AV7008.Ana08ID,'''') <= N''' + Replace(@ToAna08ID,'[]','') + ''''
			End	

	If Patindex('[%]',@FromAna09ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana09ID Like N''' + @FromAna09ID + ''''
		End
	Else 
		If @FromAna09ID is not null  And @FromAna09ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana09ID,'''') >= N''' + Replace(@FromAna09ID,'[]','') + ''' And Isnull(AV7008.Ana09ID,'''') <= N''' + Replace(@ToAna09ID,'[]','') + ''''
			End	

	If Patindex('[%]',@FromAna10ID) > 0
		Begin
			Set @AnaWhere = @AnaWhere + N' And AV7008.Ana10ID Like N''' + @FromAna10ID + ''''
		End
	Else
		If @FromAna10ID is not null  And @FromAna10ID <>''
			Begin
				Set @AnaWhere = @AnaWhere + N' And Isnull(AV7008.Ana10ID,'''') >= N''' + Replace(@FromAna10ID,'[]','') + ''' And Isnull(AV7008.Ana10ID,'''') <= N''' + Replace(@ToAna10ID,'[]','') + ''''
			End

	If @WareHouseID ='%'
		begin
			Set @WareHouseName = 'N''Tất cả'''
			Set @WareHouseID2  = 'N''%'''
			SET @WareHouseWhere = N' ISNULL(AV7008.IsTemp,0) = 0 AND '
		End
	Else
		begin
			Set @WareHouseName = 'AV7008.WareHouseName'
			Set @WareHouseID2  = 'AV7008.WareHouseID'
			SET @WareHouseWhere = N' '
		end
IF @IsDate = 1    ---- xac dinh so lieu theo ngay
	  Set @strTimeSD =N' and (  D_C=''BD''   or AV7008.VoucherDate < ''' + @FromDateText +N''') ' 
Else 
	--Set @strTimeSD =N' and ( D_C=''BD'' or CONVERT(varchar(20),AV7008.TranMonth/100*TranYear) IN ('''+ @PeriodList +''') ) ' ---06/01/2014MTuyen edit


	Set @strTimeSD =N' and ( D_C=''BD'' or (Case When  AV7008.TranMonth <10 then ''0''+rtrim(ltrim(str(AV7008.TranMonth)))+''/''
								+ltrim(Rtrim(str(AV7008.TranYear))) Else rtrim(ltrim(str(AV7008.TranMonth)))+''/''
								+ltrim(Rtrim(str(AV7008.TranYear))) End) IN ('''+@PeriodList+''') ) ' ---06/01/2014MTuyen edit

Set @sqlSelect1 = N' 
SELECT 	' + @WareHouseID2 + N' AS WareHouseID,'  + @WareHouseName + N' AS WareHouseName,AV7008.ObjectID, AV7008.InventoryID, AV7008.InventoryName, 
AV7008.UnitID, AV7008.S1, AV7008.S2, AV7008.S3, AV7008.I01ID, AV7008.I02ID, AV7008.I03ID, AV7008.I04ID, AV7008.I05ID, AV7008.UnitName,
AV7008.Specification ,	max(AV7008.Notes01) AS Notes01, max(AV7008.Notes02) AS Notes02, max(AV7008.Notes03) AS Notes03,
sum(isnull(SignQuantity,0))  AS BeginQuantity, sum(isnull(SignAmount,0)) AS BeginAmount, AV7008.DivisionID, AV7008.VoucherID' 
+ CASE WHEN @CustomerName = 84 THEN ', AV7008.Ana04ID' ELSE '' END

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
SET @sqlSelect1 = @sqlSelect1 + ',
ISNULL(AV7008.S01ID,'''') AS S01ID, ISNULL(AV7008.S02ID,'''') AS S02ID, ISNULL(AV7008.S03ID,'''') AS S03ID, ISNULL(AV7008.S04ID,'''') AS S04ID, 
ISNULL(AV7008.S05ID,'''') AS S05ID, ISNULL(AV7008.S06ID,'''') AS S06ID, ISNULL(AV7008.S07ID,'''') AS S07ID, ISNULL(AV7008.S08ID,'''') AS S08ID, 
ISNULL(AV7008.S09ID,'''') AS S09ID, ISNULL(AV7008.S10ID,'''') AS S10ID, ISNULL(AV7008.S11ID,'''') AS S11ID, ISNULL(AV7008.S12ID,'''') AS S12ID, 
ISNULL(AV7008.S13ID,'''') AS S13ID, ISNULL(AV7008.S14ID,'''') AS S14ID, ISNULL(AV7008.S15ID,'''') AS S15ID, ISNULL(AV7008.S16ID,'''') AS S16ID, 
ISNULL(AV7008.S17ID,'''') AS S17ID, ISNULL(AV7008.S18ID,'''') AS S18ID, ISNULL(AV7008.S19ID,'''') AS S19ID, ISNULL(AV7008.S20ID,'''') AS S20ID
'

Set @sqlFrom1 = N'
INTO #AV0728
FROM AV7008  '
Set @sqlWhere1 = N'
WHERE 	'+@WareHouseWhere+'
		AV7008.DivisionID IN ('''+@DivisionID+''') and
		D_C in (''D'',''C'', ''BD'' )
		'+@sWhere1+' and
		(AV7008.WareHouseID like   N'''+@WareHouseID+N''' ) and
		(AV7008.ObjectID  IN (SELECT * FROM StringSplit(REPLACE('''+@ObjectID+''', '''''''', ''''), '','')))' + @AnaWhere + N' ' 
set @sqlWhere1 = @sqlWhere1 + @strTimeSD+' '

IF @WareHouseID <>'%'	
Set @sqlGroupBy1 = N' 
GROUP BY  AV7008.DivisionID,  ' + @WareHouseID2 + '  ,' + @WareHouseName + N',  
		AV7008.ObjectID, AV7008.InventoryID,	 AV7008.InventoryName,	  AV7008.UnitID,
		AV7008.S1, 	 AV7008.S2, 	 AV7008.S3, 	 
		AV7008.I01ID, 	 AV7008.I02ID, 	 AV7008.I03ID, 	 AV7008.I04ID, 	 AV7008.I05ID, 
		AV7008.UnitName , AV7008.Specification, AV7008.VoucherID' + CASE WHEN @CustomerName = 84 THEN', AV7008.Ana04ID' ELSE '' END
Else
Set @sqlGroupBy1 = N' 
GROUP BY  AV7008.DivisionID,  AV7008.ObjectID,   AV7008.InventoryID,	 AV7008.InventoryName,	  AV7008.UnitID,
		AV7008.S1, AV7008.S2, AV7008.S3, AV7008.I01ID, AV7008.I02ID, AV7008.I03ID, AV7008.I04ID, AV7008.I05ID, AV7008.UnitName, AV7008.Specification, AV7008.VoucherID'
		 + CASE WHEN @CustomerName = 84 THEN ', AV7008.Ana04ID' ELSE '' END


IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
SET @sqlGroupBy1 = @sqlGroupBy1 + ',
		ISNULL(AV7008.S01ID,''''), ISNULL(AV7008.S02ID,''''), ISNULL(AV7008.S03ID,''''), ISNULL(AV7008.S04ID,''''), ISNULL(AV7008.S05ID,''''), 
		ISNULL(AV7008.S06ID,''''), ISNULL(AV7008.S07ID,''''), ISNULL(AV7008.S08ID,''''), ISNULL(AV7008.S09ID,''''), ISNULL(AV7008.S10ID,''''),
		ISNULL(AV7008.S11ID,''''), ISNULL(AV7008.S12ID,''''), ISNULL(AV7008.S13ID,''''), ISNULL(AV7008.S14ID,''''), ISNULL(AV7008.S15ID,''''), 
		ISNULL(AV7008.S16ID,''''), ISNULL(AV7008.S17ID,''''), ISNULL(AV7008.S18ID,''''), ISNULL(AV7008.S19ID,''''), ISNULL(AV7008.S20ID,'''')
 '

--print @sSQL
--IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE XTYPE ='V' AND NAME = 'AV0728')
--   	EXEC ('CREATE VIEW AV0728 AS '+@sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy)
--ELSE
--	EXEC('  ALTER VIEW  AV0728 AS '+ @sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy)

-------- Lay tong so du 
Set @sqlSelect2=N'
SELECT 	AV0728.ObjectID, AT1202.ObjectName, AT1202.O01ID,AT1202.O02ID,AT1202.O03ID,AT1202.O04ID,AT1202.O05ID,AT1202.Address, 
WareHouseID ,WareHouseName,InventoryID,	InventoryName, UnitID,		 
AV0728.S1, AV0728.S2, AV0728.S3 ,  I01ID, I02ID, I03ID, I04ID, I05ID, UnitName,
AV0728.Specification ,	AV0728.Notes01 , AV0728.Notes02 , AV0728.Notes03 ,
sum(isnull(BeginQuantity,0))  AS BeginQuantity, sum(isnull( BeginAmount ,0)) AS BeginAmount, AV0728.DivisionID, AV0728.VoucherID'
 + CASE WHEN @CustomerName = 84 THEN ', AV0728.Ana04ID' ELSE '' END

set @sqlFrom2 = N'
INTO	#AV0729
FROM #AV0728 AV0728
LEFT JOIN AT1202 WITH (NOLOCK) on AT1202.ObjectID = AV0728.ObjectID '

set @sqlWhere2 = N''

set @sqlGroupBy2 = N'
GROUP BY AV0728.ObjectID, AT1202.ObjectName, AT1202.O01ID, AT1202.O02ID,AT1202.O03ID,AT1202.O04ID,AT1202.O05ID,AT1202.Address, InventoryID,	InventoryName,	 
UnitID, AV0728.S1, AV0728.S2, AV0728.S3 , I01ID,I02ID,I03ID, I04ID, I05ID, UnitName , AV0728.Specification ,
AV0728.Notes01, AV0728.Notes02, AV0728.Notes03, WareHouseID, WareHouseName, AV0728.DivisionID, AV0728.VoucherID'
 + CASE WHEN @CustomerName = 84 THEN ', AV0728.Ana04ID' ELSE '' END

IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	SET @sqlSelect2 = @sqlSelect2 + ',
ISNULL(AV0728.S01ID,'''') AS S01ID, ISNULL(AV0728.S02ID,'''') AS S02ID, ISNULL(AV0728.S03ID,'''') AS S03ID, ISNULL(AV0728.S04ID,'''') AS S04ID, 
ISNULL(AV0728.S05ID,'''') AS S05ID, ISNULL(AV0728.S06ID,'''') AS S06ID, ISNULL(AV0728.S07ID,'''') AS S07ID, ISNULL(AV0728.S08ID,'''') AS S08ID, 
ISNULL(AV0728.S09ID,'''') AS S09ID, ISNULL(AV0728.S10ID,'''') AS S10ID, ISNULL(AV0728.S11ID,'''') AS S11ID, ISNULL(AV0728.S12ID,'''') AS S12ID, 
ISNULL(AV0728.S13ID,'''') AS S13ID, ISNULL(AV0728.S14ID,'''') AS S14ID, ISNULL(AV0728.S15ID,'''') AS S15ID, ISNULL(AV0728.S16ID,'''') AS S16ID, 
ISNULL(AV0728.S17ID,'''') AS S17ID, ISNULL(AV0728.S18ID,'''') AS S18ID, ISNULL(AV0728.S19ID,'''') AS S19ID, ISNULL(AV0728.S20ID,'''') AS S20ID
'

	SET @sqlGroupBy2 = @sqlGroupBy2 + ',
ISNULL(AV0728.S01ID,''''), ISNULL(AV0728.S02ID,''''), ISNULL(AV0728.S03ID,''''), ISNULL(AV0728.S04ID,''''), ISNULL(AV0728.S05ID,''''), 
ISNULL(AV0728.S06ID,''''), ISNULL(AV0728.S07ID,''''), ISNULL(AV0728.S08ID,''''), ISNULL(AV0728.S09ID,''''), ISNULL(AV0728.S10ID,''''),
ISNULL(AV0728.S11ID,''''), ISNULL(AV0728.S12ID,''''), ISNULL(AV0728.S13ID,''''), ISNULL(AV0728.S14ID,''''), ISNULL(AV0728.S15ID,''''), 
ISNULL(AV0728.S16ID,''''), ISNULL(AV0728.S17ID,''''), ISNULL(AV0728.S18ID,''''), ISNULL(AV0728.S19ID,''''), ISNULL(AV0728.S20ID,'''')'

END

--Print @sSQL

--IF NOT EXISTS (SELECT 1 FROM SYSOBJECTS WITH (NOLOCK) WHERE XTYPE ='V' AND NAME = 'AV0729')
--	EXEC ('CREATE VIEW AV0729 -- Tạo bởi WMP3003
--	        AS '+@sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy)
--ELSE
--	EXEC('  ALTER VIEW  AV0729 -- Tạo bởi WMP3003
--	        AS '+ @sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy)

------------------------------ KET HOP VOI SO  PHAT SINH

--Rem by: Dang Le Bao Quynh; Date 20/08/2008
--Purpose: Bo sung them dieu kien cho cac khong co phat sinh nhung co so du dau 
/*
IF @IsDate = 1    ---- xac dinh so lieu theo ngay
	  Set @strTime =' and (VoucherDate  Between  ''' + @FromDateText +'''  and ''' + Convert(VARCHAR(10),@TODate,101) +'''  ) ' 
Else 
	Set @strTime =' and (AV7008.TranMonth+ 100*AV7008.TranYear Between '+@FromMonthYearText+' and  '+@ToMonthYearText+'  ) ' 
*/

IF @IsDate = 1    ---- xac dinh so lieu theo ngay//06/01/2014
	  Set @strTimePS =N' And (AV7008.VoucherDate  >=  CASE WHEN AV7008.D_C in (''D'', ''C'') Then ''' + @FromDateText +N''' Else AV7008.VoucherDate End)  And (AV7008.VoucherDate  <=  CASE WHEN AV7008.D_C in (''D'', ''C'') Then ''' + Convert(VARCHAR(10),@TODate,101) +N'''  Else AV7008.VoucherDate End) ' --- MTuyen edit
Else 
	--Set @strTimePS =N' And CONVERT(varchar(20),AV7008.TranMonth/100*AV7008.TranYear) IN ( '''+ @PeriodList +''') ' --- My Tuyen edit

	Set @strTimePS =N' And (Case When  AV7008.TranMonth <10 then ''0''+rtrim(ltrim(str(AV7008.TranMonth)))+''/''
								+ltrim(Rtrim(str(AV7008.TranYear))) Else rtrim(ltrim(str(AV7008.TranMonth)))+''/''
								+ltrim(Rtrim(str(AV7008.TranYear))) End) IN ('''+@PeriodList+''') ' --- My Tuyen edit

SET @sqlSelect3 = N'
SELECT
	AV7008.DivisionID, AT1101.DivisionName, AV7008.VoucherID,
	isnull( AV0729.ObjectID,	AV7008.ObjectID) AS ObjectID, 
	AT1202.S1 AS OS1, AT1202.S2 AS OS2, AT1202.S3 AS OS3, 
	O1.SName AS OS1Name, O2.SName AS OS2Name, O3.SName AS OS3Name, 
	isnull(AV0729.ObjectName,AV7008.ObjectName) AS ObjectName, 
	isnull( AV0729.O01ID, AV7008.O01ID) AS O01ID,isnull( AV0729.O02ID, AV7008.O02ID) AS O02ID,
	isnull( AV0729.O03ID, AV7008.O03ID) AS O03ID,isnull( AV0729.O04ID, AV7008.O04ID) AS O04ID,isnull( AV0729.O05ID, AV7008.O05ID) AS O05ID,
	A1.AnaName AS O01Name, A2.AnaName AS O02Name, A3.AnaName AS O03Name, A4.AnaName AS O04Name, A5.AnaName AS O05Name, 
	isnull(AV0729.Address, AV7008.Address) AS Address, 
	AV7008.InventoryID,
	AV7008.InventoryName,
	AT1302.VATGroupID, 
	AT1302.VATPercent, 
	AV7008.UnitID,
	AT1309.UnitID AS ConversionUnitID,
	AT1309.ConversionFactor AS ConversionFactor,
	AT1309.Operator,
	AV7008.DebitAccountID, AV7008.CreditAccountID,
	AV7008.VoucherDate, AV7008.VoucherNo, AV7008.VoucherTypeID, AT1007.VoucherTypeName,
	AV7008.RefNo01, AV7008.RefNo02, AV7008.Notes,
	AV7008.S1, AV7008.S2, AV7008.S3, 
	AV7008.S1Name, AV7008.S2Name, AV7008.S3Name, 
	AV7008.I01ID, AV7008.I02ID, AV7008.I03ID, AV7008.I04ID, AV7008.I05ID, 
	AV7008.InAnaName1, AV7008.InAnaName2, AV7008.InAnaName3, AV7008.InAnaName4, AV7008.InAnaName5, 
	AV7008.UnitName, AV7008.Specification , AV7008.Notes01 , AV7008.Notes02 , AV7008.Notes03 ,
	AV7008.SourceNo,
	isnull(AV0729.BeginQuantity,0) AS BeginQuantity,
	isnull(AV0729.BeginAmount,0) AS BeginAmount,
	Sum(CASE WHEN D_C = ''D'' then isnull(AV7008.ActualQuantity,0) else 0 end) AS DebitQuantity,
	Sum(CASE WHEN D_C = ''C'' then isnull(AV7008.ActualQuantity,0) else 0 end) AS CreditQuantity,
    Sum(CASE WHEN D_C = ''C'' and AV7008.Ana04ID=''CXH'' then isnull(AV7008.ActualQuantity,0) else 0 end) AS CreditQuantityNo, 
	Sum(CASE WHEN D_C = ''D'' then isnull(AV7008.ConvertedAmount,0) else 0 end) AS DebitAmount,
	Sum(CASE WHEN D_C = ''C'' then isnull(AV7008.ConvertedAmount,0) else 0 end) AS CreditAmount,
	(isnull(AV0729.BeginQuantity,0) + Sum(CASE WHEN D_C = ''D'' then isnull(AV7008.ActualQuantity,0) else 0 end) -   Sum(CASE WHEN D_C = ''C'' then isnull(AV7008.ActualQuantity,0) else 0 end)  ) AS  EndQuantity,
	(isnull(AV0729.BeginAmount,0)+Sum(CASE WHEN D_C = ''D'' then isnull(AV7008.ConvertedAmount,0) else 0 end)  -  Sum(CASE WHEN D_C = ''C'' then isnull(AV7008.ConvertedAmount,0) else 0 end)  ) AS EndAmount,
	AV7008.DivisionID, AV7008.ProductID, AV7008.MOrderID, AV7008.ProductName,
	AV7008.VoucherDesc, 
	AV7008.Ana01ID,AV7008.Ana02ID,AV7008.Ana03ID,AV7008.Ana04ID,AV7008.Ana05ID,
	AV7008.Ana06ID,AV7008.Ana07ID,AV7008.Ana08ID,AV7008.Ana09ID,AV7008.Ana10ID,
	AV7008.Ana01Name,AV7008.Ana02Name,AV7008.Ana03Name,AV7008.Ana04Name,AV7008.Ana05Name,
	AV7008.Ana06Name,AV7008.Ana07Name,AV7008.Ana08Name,AV7008.Ana09Name,AV7008.Ana10Name,
	AV7008.LimitDate, AV7008.RevoucherDate, AV7008.WareHouseID, AV7008.WarehouseName, AT9000.VoucherNo  AS BHVoucherNo, AT9000.VoucherDate AS BHVoucherDate, AT9000.TDescription,  ---  06/01/2014MTuyen add new
	AT9000.InvoiceNo, AT1011.AnaName AS Sale, -- 27/06/2014 MTuyen add new
	'  + CASE WHEN @CustomerName = 84 THEN 'ISNULL(AV0729.Ana04ID, AV7008.Ana04ID) AS Ana04ID, A114.AnaName AS Ana04Name,' ELSE '' END +' AV7008.RDAddress
'
IF EXISTS (SELECT TOP 1 1 FROM AT0000 WITH (NOLOCK) WHERE DefDivisionID = @DivisionID AND IsSpecificate = 1)
BEGIN
	SET @sqlSelect3a = '
	,ISNULL(AV7008.S01ID,'''') AS S01ID, ISNULL(AV7008.S02ID,'''') AS S02ID, ISNULL(AV7008.S03ID,'''') AS S03ID, ISNULL(AV7008.S04ID,'''') AS S04ID, 
	ISNULL(AV7008.S05ID,'''') AS S05ID, ISNULL(AV7008.S06ID,'''') AS S06ID, ISNULL(AV7008.S07ID,'''') AS S07ID, ISNULL(AV7008.S08ID,'''') AS S08ID, 
	ISNULL(AV7008.S09ID,'''') AS S09ID, ISNULL(AV7008.S10ID,'''') AS S10ID, ISNULL(AV7008.S11ID,'''') AS S11ID, ISNULL(AV7008.S12ID,'''') AS S12ID, 
	ISNULL(AV7008.S13ID,'''') AS S13ID, ISNULL(AV7008.S14ID,'''') AS S14ID, ISNULL(AV7008.S15ID,'''') AS S15ID, ISNULL(AV7008.S16ID,'''') AS S16ID, 
	ISNULL(AV7008.S17ID,'''') AS S17ID, ISNULL(AV7008.S18ID,'''') AS S18ID, ISNULL(AV7008.S19ID,'''') AS S19ID, ISNULL(AV7008.S20ID,'''') AS S20ID,
	A01.StandardName AS StandardName01, A02.StandardName AS StandardName02, A03.StandardName AS StandardName03, A04.StandardName AS StandardName04, 
	A05.StandardName AS StandardName05, A06.StandardName AS StandardName06, A07.StandardName AS StandardName07, A08.StandardName AS StandardName08, 
	A09.StandardName AS StandardName09, A10.StandardName AS StandardName10, A11.StandardName AS StandardName11, A12.StandardName AS StandardName12,
	A13.StandardName AS StandardName13, A14.StandardName AS StandardName14, A15.StandardName AS StandardName15, A16.StandardName AS StandardName16,
	A17.StandardName AS StandardName17, A18.StandardName AS StandardName18, A19.StandardName AS StandardName19, A20.StandardName AS StandardName20
	'

	SET @sqlFrom3 = '
	FROM AV7008
	LEFT JOIN #AV0729 AV0729 on ( AV0729.InventoryID = AV7008.InventoryID) and (AV0729.ObjectID = AV7008.ObjectID) and (AV0729.DivisionID = AV7008.DivisionID)  and AV7008.VoucherID = AV0729.VoucherID
	AND ISNULL(AV7008.S01ID,'''') = Isnull(AV0729.S01ID,'''') AND ISNULL(AV7008.S02ID,'''') = isnull(AV0729.S02ID,'''')
	AND ISNULL(AV7008.S03ID,'''') = isnull(AV0729.S03ID,'''') AND ISNULL(AV7008.S04ID,'''') = isnull(AV0729.S04ID,'''')
	AND ISNULL(AV7008.S05ID,'''') = isnull(AV0729.S05ID,'''') AND ISNULL(AV7008.S06ID,'''') = isnull(AV0729.S06ID,'''')
	AND ISNULL(AV7008.S07ID,'''') = isnull(AV0729.S07ID,'''') AND ISNULL(AV7008.S08ID,'''') = isnull(AV0729.S08ID,'''') 
	AND ISNULL(AV7008.S09ID,'''') = isnull(AV0729.S09ID,'''') AND ISNULL(AV7008.S10ID,'''') = isnull(AV0729.S10ID,'''') 
	AND ISNULL(AV7008.S11ID,'''') = isnull(AV0729.S11ID,'''') AND ISNULL(AV7008.S12ID,'''') = isnull(AV0729.S12ID,'''') 
	AND ISNULL(AV7008.S13ID,'''') = isnull(AV0729.S13ID,'''') AND ISNULL(AV7008.S14ID,'''') = isnull(AV0729.S14ID,'''') 
	AND ISNULL(AV7008.S15ID,'''') = isnull(AV0729.S15ID,'''') AND ISNULL(AV7008.S16ID,'''') = isnull(AV0729.S16ID,'''') 
	AND ISNULL(AV7008.S17ID,'''') = isnull(AV0729.S17ID,'''') AND ISNULL(AV7008.S18ID,'''') = isnull(AV0729.S18ID,'''') 
	AND ISNULL(AV7008.S19ID,'''') = isnull(AV0729.S19ID,'''') AND ISNULL(AV7008.S20ID,'''') = isnull(AV0729.S20ID,'''')  
	LEFT JOIN (Select InventoryID,Min(UnitID) AS UnitID, Min(ConversionFactor) AS ConversionFactor, Min(Operator) AS Operator, DivisionID,
			  S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID
			  From AT1309 WITH (NOLOCK) Group By InventoryID, DivisionID, S01ID, S02ID, S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID, S11ID, 
			  S12ID, S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID) AT1309
	On AV7008.InventoryID = AT1309.InventoryID
	AND ISNULL(AV7008.S01ID,'''') = Isnull(AT1309.S01ID,'''') AND ISNULL(AV7008.S02ID,'''') = isnull(AT1309.S02ID,'''')
	AND ISNULL(AV7008.S03ID,'''') = isnull(AT1309.S03ID,'''') AND ISNULL(AV7008.S04ID,'''') = isnull(AT1309.S04ID,'''')
	AND ISNULL(AV7008.S05ID,'''') = isnull(AT1309.S05ID,'''') AND ISNULL(AV7008.S06ID,'''') = isnull(AT1309.S06ID,'''')
	AND ISNULL(AV7008.S07ID,'''') = isnull(AT1309.S07ID,'''') AND ISNULL(AV7008.S08ID,'''') = isnull(AT1309.S08ID,'''') 
	AND ISNULL(AV7008.S09ID,'''') = isnull(AT1309.S09ID,'''') AND ISNULL(AV7008.S10ID,'''') = isnull(AT1309.S10ID,'''') 
	AND ISNULL(AV7008.S11ID,'''') = isnull(AT1309.S11ID,'''') AND ISNULL(AV7008.S12ID,'''') = isnull(AT1309.S12ID,'''') 
	AND ISNULL(AV7008.S13ID,'''') = isnull(AT1309.S13ID,'''') AND ISNULL(AV7008.S14ID,'''') = isnull(AT1309.S14ID,'''') 
	AND ISNULL(AV7008.S15ID,'''') = isnull(AT1309.S15ID,'''') AND ISNULL(AV7008.S16ID,'''') = isnull(AT1309.S16ID,'''') 
	AND ISNULL(AV7008.S17ID,'''') = isnull(AT1309.S17ID,'''') AND ISNULL(AV7008.S18ID,'''') = isnull(AT1309.S18ID,'''') 
	AND ISNULL(AV7008.S19ID,'''') = isnull(AT1309.S19ID,'''') AND ISNULL(AV7008.S20ID,'''') = isnull(AT1309.S20ID,'''')  
	LEFT JOIN AT0128 A01 WITH (NOLOCK) ON AV7008.S01ID = A01.StandardID AND A01.StandardTypeID = ''S01''
	LEFT JOIN AT0128 A02 WITH (NOLOCK) ON AV7008.S02ID = A02.StandardID AND A02.StandardTypeID = ''S02''
	LEFT JOIN AT0128 A03 WITH (NOLOCK) ON AV7008.S03ID = A03.StandardID AND A03.StandardTypeID = ''S03''
	LEFT JOIN AT0128 A04 WITH (NOLOCK) ON AV7008.S04ID = A04.StandardID AND A04.StandardTypeID = ''S04''
	LEFT JOIN AT0128 A05 WITH (NOLOCK) ON AV7008.S05ID = A05.StandardID AND A05.StandardTypeID = ''S05''
	LEFT JOIN AT0128 A06 WITH (NOLOCK) ON AV7008.S06ID = A06.StandardID AND A06.StandardTypeID = ''S06''
	LEFT JOIN AT0128 A07 WITH (NOLOCK) ON AV7008.S07ID = A07.StandardID AND A07.StandardTypeID = ''S07''
	LEFT JOIN AT0128 A08 WITH (NOLOCK) ON AV7008.S08ID = A08.StandardID AND A08.StandardTypeID = ''S08''
	LEFT JOIN AT0128 A09 WITH (NOLOCK) ON AV7008.S09ID = A09.StandardID AND A09.StandardTypeID = ''S09''
	LEFT JOIN AT0128 A10 WITH (NOLOCK) ON AV7008.S10ID = A10.StandardID AND A10.StandardTypeID = ''S10''
	LEFT JOIN AT0128 A11 WITH (NOLOCK) ON AV7008.S11ID = A11.StandardID AND A11.StandardTypeID = ''S11''
	LEFT JOIN AT0128 A12 WITH (NOLOCK) ON AV7008.S12ID = A12.StandardID AND A12.StandardTypeID = ''S12''
	LEFT JOIN AT0128 A13 WITH (NOLOCK) ON AV7008.S13ID = A13.StandardID AND A13.StandardTypeID = ''S13''
	LEFT JOIN AT0128 A14 WITH (NOLOCK) ON AV7008.S14ID = A14.StandardID AND A14.StandardTypeID = ''S14''
	LEFT JOIN AT0128 A15 WITH (NOLOCK) ON AV7008.S15ID = A15.StandardID AND A15.StandardTypeID = ''S15''
	LEFT JOIN AT0128 A16 WITH (NOLOCK) ON AV7008.S16ID = A16.StandardID AND A16.StandardTypeID = ''S16''
	LEFT JOIN AT0128 A17 WITH (NOLOCK) ON AV7008.S17ID = A17.StandardID AND A17.StandardTypeID = ''S17''
	LEFT JOIN AT0128 A18 WITH (NOLOCK) ON AV7008.S18ID = A18.StandardID AND A18.StandardTypeID = ''S18''
	LEFT JOIN AT0128 A19 WITH (NOLOCK) ON AV7008.S19ID = A19.StandardID AND A19.StandardTypeID = ''S19''
	LEFT JOIN AT0128 A20 WITH (NOLOCK) ON AV7008.S20ID = A20.StandardID AND A20.StandardTypeID = ''S20''
	'
	SET @sqlGroupBy3a = '
	,ISNULL(AV7008.S01ID,''''), ISNULL(AV7008.S02ID,''''), ISNULL(AV7008.S03ID,''''), ISNULL(AV7008.S04ID,''''), 
	ISNULL(AV7008.S05ID,''''), ISNULL(AV7008.S06ID,''''), ISNULL(AV7008.S07ID,''''), ISNULL(AV7008.S08ID,''''), 
	ISNULL(AV7008.S09ID,''''), ISNULL(AV7008.S10ID,''''), ISNULL(AV7008.S11ID,''''), ISNULL(AV7008.S12ID,''''), 
	ISNULL(AV7008.S13ID,''''), ISNULL(AV7008.S14ID,''''), ISNULL(AV7008.S15ID,''''), ISNULL(AV7008.S16ID,''''), 
	ISNULL(AV7008.S17ID,''''), ISNULL(AV7008.S18ID,''''), ISNULL(AV7008.S19ID,''''), ISNULL(AV7008.S20ID,''''),
	A01.StandardName, A02.StandardName, A03.StandardName, A04.StandardName, 
	A05.StandardName, A06.StandardName, A07.StandardName, A08.StandardName, 
	A09.StandardName, A10.StandardName, A11.StandardName, A12.StandardName,
	A13.StandardName, A14.StandardName, A15.StandardName, A16.StandardName,
	A17.StandardName, A18.StandardName, A19.StandardName, A20.StandardName
	'
END
ELSE 

 SET @sqlFrom3 = '
	FROM AV7008
	LEFT JOIN #AV0729 AV0729 on ( AV0729.InventoryID = AV7008.InventoryID) and (AV0729.ObjectID = AV7008.ObjectID) and (AV0729.DivisionID = AV7008.DivisionID) and AV7008.VoucherID = AV0729.VoucherID
	LEFT JOIN (Select InventoryID,Min(UnitID) AS UnitID, Min(ConversionFactor) AS ConversionFactor, Min(Operator) AS Operator, DivisionID 
			  From AT1309 WITH (NOLOCK) Group By InventoryID, DivisionID) AT1309 On AV7008.InventoryID = AT1309.InventoryID'

set @sqlFrom3a = N'
LEFT JOIN AT1015 A1 WITH (NOLOCK) On isnull( AV0729.O01ID, AV7008.O01ID) =  A1.AnaID And A1.AnaTypeID = ''O01''
LEFT JOIN AT1015 A2 WITH (NOLOCK) On isnull( AV0729.O02ID, AV7008.O02ID) =  A2.AnaID And A2.AnaTypeID = ''O02''
LEFT JOIN AT1015 A3 WITH (NOLOCK) On isnull( AV0729.O03ID, AV7008.O03ID) =  A3.AnaID And A3.AnaTypeID = ''O03''
LEFT JOIN AT1015 A4 WITH (NOLOCK) On isnull( AV0729.O04ID, AV7008.O04ID) =  A4.AnaID And A4.AnaTypeID = ''O04''
LEFT JOIN AT1015 A5 WITH (NOLOCK) On isnull( AV0729.O05ID, AV7008.O05ID) =  A5.AnaID And A5.AnaTypeID = ''O05''
LEFT JOIN AT1202 WITH (NOLOCK) On  isnull( AV0729.ObjectID,	AV7008.ObjectID) = AT1202.ObjectID
LEFT JOIN AT1207 O1 WITH (NOLOCK) On AT1202.S1 = O1.S And O1.STypeID = ''O01''
LEFT JOIN AT1207 O2 WITH (NOLOCK) On AT1202.S2 = O2.S And O2.STypeID = ''O02''
LEFT JOIN AT1207 O3 WITH (NOLOCK) On AT1202.S3 = O3.S And O1.STypeID = ''O03''
LEFT JOIN AT1302 WITH (NOLOCK) On AT1302.DivisionID IN (AV7008.DivisionID,''@@@'') AND AV7008.InventoryID = AT1302.InventoryID
LEFT JOIN AT9000 WITH (NOLOCK) ON AT9000.WOrderID=AV7008.VoucherID and AT9000.TransactionTypeID=''T04'' and AT9000.InventoryID = AV7008.InventoryID --- 27/06/2014 MTuyen edit
									AND AV7008.TransactionID  = AT9000.WTransactionID
LEFT JOIN AT1011 WITH (NOLOCK) ON AT9000.Ana01ID=AT1011.AnaID and AT1011.AnaTypeID=''A01'' -- 27/06/2014 MTuyen add new
LEFT JOIN AT1007 WITH (NOLOCK) ON AT1007.VoucherTypeID = AV7008.VoucherTypeID AND AT1007.DivisionID IN (AV7008.DivisionID, ''@@@'')
LEFT JOIN AT1101 WITH (NOLOCK) ON AT1101.DivisionID = AV7008.DivisionID
'  + CASE WHEN @CustomerName = 84 THEN 'LEFT JOIN AT1011 A114 WITH (NOLOCK) ON ISNULL(AV0729.Ana04ID, AV7008.Ana04ID) =  A114.AnaID And A114.AnaTypeID = ''A04'' ' ELSE '' END

set @sqlWhere3 = N'
WHERE 	'+@WareHouseWhere+'
		AV7008.DivisionID IN ('''+@DivisionID+''')
		'+@sWhere2+' and
		(AV7008.ObjectID  IN (SELECT * FROM StringSplit(REPLACE('''+@ObjectID+''', '''''''', ''''), '',''))) AND 
		AV7008.WareHouseID like N'''+ @WareHouseID+N''' and
		AV7008.D_C in (''D'',''BD'',''C'') ' + @AnaWhere + ' ' 
Set @sqlWhere3 = @sqlWhere3 + @strTimePS +N' 
'
set @sqlGroupBy3 = N'
GROUP BY AV7008.DivisionID, AT1101.DivisionName, AV7008.VoucherID, AV0729.ObjectID,AV7008.ObjectID, AV0729.ObjectName, AV7008.ObjectName, 
	AT1202.S1, AT1202.S2, AT1202.S3, 
	O1.SName, O2.SName, O3.SName, 
	isnull( AV0729.O01ID, AV7008.O01ID), isnull( AV0729.O02ID, AV7008.O02ID), isnull( AV0729.O03ID, AV7008.O03ID), isnull( AV0729.O04ID, AV7008.O04ID), isnull( AV0729.O05ID, AV7008.O05ID),
	A1.AnaName, A2.AnaName, A3.AnaName, A4.AnaName, A5.AnaName, 
	AV0729.Address, AV7008.Address, AV7008.InventoryID, AV7008.InventoryName, AT1302.VATGroupID, AT1302.VATPercent, 
	AV7008.UnitID, AV7008.UnitName, 
	AT1309.UnitID,
	AT1309.ConversionFactor,
	AT1309.Operator,
	AV7008.Specification , AV7008.Notes01 , AV7008.Notes02 , AV7008.Notes03 ,
	AV7008.DebitAccountID, AV7008.CreditAccountID,
	AV7008.VoucherDate, AV7008.VoucherNo,  AV7008.VoucherTypeID, AT1007.VoucherTypeName,
	AV7008.RefNo01, AV7008.RefNo02, AV7008.Notes,
	AV0729.BeginQuantity, AV0729.BeginAmount,
	AV7008.D_C,
	--AV7008.ActualQuantity,AV7008.ConvertedAmount,
	AV7008.S1, AV7008.S2, AV7008.S3, 
	AV7008.S1Name, AV7008.S2Name, AV7008.S3Name, 
	AV7008.I01ID, AV7008.I02ID, AV7008.I03ID, AV7008.I04ID, AV7008.I05ID,
	AV7008.InAnaName1, AV7008.InAnaName2, AV7008.InAnaName3, AV7008.InAnaName4, AV7008.InAnaName5, AV7008.SourceNo, 
	AV7008.ProductID, AV7008.MOrderID, AV7008.ProductName,
	AV7008.VoucherDesc, 
	AV7008.Ana01ID,AV7008.Ana02ID,AV7008.Ana03ID,AV7008.Ana04ID,AV7008.Ana05ID,
	AV7008.Ana06ID,AV7008.Ana07ID,AV7008.Ana08ID,AV7008.Ana09ID,AV7008.Ana10ID,
	AV7008.Ana01Name,AV7008.Ana02Name,AV7008.Ana03Name,AV7008.Ana04Name,AV7008.Ana05Name,
	AV7008.Ana06Name,AV7008.Ana07Name,AV7008.Ana08Name,AV7008.Ana09Name,AV7008.Ana10Name,
	AV7008.LimitDate, AV7008.RevoucherDate,AV7008.WareHouseID,AV7008.WarehouseName,AT9000.VoucherNo, AT9000.VoucherDate,AT9000.TDescription,  ---06/01/2014 MTuyen add new
	AT9000.InvoiceNo, AT1011.AnaName, ---27/06/2014 MTuyen add new
	'  + CASE WHEN @CustomerName = 84 THEN 'ISNULL(AV0729.Ana04ID, AV7008.Ana04ID), A114.AnaName, ' ELSE '' END + ' AV7008.RDAddress
'

IF @CustomerName IN (36, 70) ----Customize SaigonPetro, EIMSKIP
BEGIN 
	SET @sqlSelectUnion = N'
	UNION ALL
	SELECT
		'''' AS VoucherID,
		'''' AS  ObjectID, 
		'''' AS  OS1, '''' AS OS2, '''' AS OS3, 
		'''' AS OS1Name, '''' AS OS2Name, '''' AS OS3Name, 
		ObjectName, 
		O01ID,  O02ID,
		O03ID, O04ID, O05ID,
		'''' AS O01Name, '''' AS O02Name, '''' AS O03Name, '''' AS O04Name, '''' AS O05Name, 
		Address, 
		AV0729.InventoryID,
		InventoryName,
		'''' AS  VATGroupID, 
		0 AS VATPercent, 
		AV0729.UnitID,
		AT1309.UnitID AS ConversionUnitID,
		AT1309.ConversionFactor AS ConversionFactor,
		AT1309.Operator,
		'''' AS DebitAccountID, '''' AS CreditAccountID,
		'''' AS VoucherDate, '''' AS VoucherNo, '''' AS VoucherTypeID,
		'''' AS RefNo01, '''' AS RefNo02, '''' AS Notes,
		'''' AS S1, '''' AS S2, '''' AS S3, 
		'''' AS S1Name, '''' AS S2Name, '''' AS S3Name, 
		'''' AS I01ID, '''' AS I02ID, '''' AS I03ID, '''' AS I04ID, '''' AS I05ID, 
		'''' AS InAnaName1, '''' AS InAnaName2, '''' AS InAnaName3, '''' AS InAnaName4, '''' AS InAnaName5, 
		'''' AS UnitName, '''' AS Specification , '''' AS Notes01 , '''' AS Notes02 , '''' AS Notes03 ,
		'''' AS SourceNo,
		isnull(AV0729.BeginQuantity,0) AS BeginQuantity,
		isnull(AV0729.BeginAmount,0) AS BeginAmount,
		0 AS DebitQuantity,
		0 AS CreditQuantity,
	    0 AS CreditQuantityNo, 
		0 AS DebitAmount,
		0 AS CreditAmount,
		0 AS EndQuantity,
		0 AS EndAmount,
		'''' AS DivisionID, '''' AS ProductID, '''' AS MOrderID, '''' AS ProductName,
		'''' AS VoucherDesc, 
		'''' AS Ana01ID,'''' AS Ana02ID,'''' AS Ana03ID,'''' AS Ana04ID,'''' AS Ana05ID,
		'''' AS Ana06ID,'''' AS Ana07ID,'''' AS Ana08ID,'''' AS Ana09ID,'''' AS Ana10ID,
		'''' AS Ana01Name,'''' AS Ana02Name,'''' AS Ana03Name,'''' AS Ana04Name,'''' AS Ana05Name,
		'''' AS Ana06Name,'''' AS Ana07Name,'''' AS Ana08Name,'''' AS Ana09Name,'''' AS Ana10Name,
		'''' AS LimitDate, '''' AS RevoucherDate, '''' AS WareHouseID, '''' AS WarehouseName, 
		'''' AS BHVoucherNo, '''' AS BHVoucherDate, '''' AS TDescription,  ---  06/01/2014 MTuyen add new
		'''' AS InvoiceNo, '''' AS Sale, -- 27/06/2014 MTuyen add new
		'  + CASE WHEN @CustomerName = 84 THEN ''''' AS Ana04ID, '''' AS Ana04Name,' ELSE '' END + '
		'''' AS RDAddress
	FROM #AV0729 AV0729
	LEFT JOIN (Select InventoryID,Min(UnitID) AS UnitID, Min(ConversionFactor) AS ConversionFactor, Min(Operator) AS Operator, DivisionID 
				From AT1309 WITH (NOLOCK) Group By InventoryID, DivisionID) AT1309 On AV0729.InventoryID = AT1309.InventoryID
	--LEFT JOIN AT1302 WITH (NOLOCK) On AV7008.InventoryID = AT1302.InventoryID and AT1302.DivisionID IN (AV7008.DivisionID,''@@@'')
	'
	set @sqlWhereUnion = N'
	WHERE NOT EXISTS (SELECT TOP 1 1 FROM AV7008 
						WHERE 	'+@WareHouseWhere+'
								AV7008.DivisionID IN ('''+@DivisionID+''') 
								'+@sWhere3+' and
								(AV7008.ObjectID IN (SELECT * FROM StringSplit(REPLACE('''+@ObjectID+''', '''''''', ''''), '',''))) AND 
								AV7008.WareHouseID like N'''+ @WareHouseID+N''' and
								AV7008.D_C in (''D'',''BD'',''C'') ' + @AnaWhere +  @strTimePS +N'  
								AND ( AV0729.InventoryID = AV7008.InventoryID) and (AV0729.ObjectID = AV7008.ObjectID) and (AV0729.DivisionID = AV7008.DivisionID)  	
						)' 				
	--Set @sqlWhereUnion = @sqlWhereUnion + @strTimeSD +N' 
	--'
	--print @sqlSelect
	--print @sqlFrom
	--print @sqlWhere
	--print @sqlGroupBy
	--print @sqlSelectunion
	--print @sqlWhereUnion
END
print @sqlSelect1
print @sqlFrom1
print @sqlWhere1
print @sqlGroupBy1
print @sqlSelect2
print @sqlFrom2
print @sqlWhere2
print @sqlGroupBy2
print @sqlSelect3
print @sqlSelect3a
print @sqlFrom3
print @sqlFrom3a
print @sqlWhere3
print @sqlGroupBy3
print @sqlGroupBy3a
print @sqlSelectunion + @sqlWhereUnion
print @sqlWhereUnion
EXEC (@sqlSelect1 + @sqlFrom1 + @sqlWhere1 + @sqlGroupBy1 + @sqlSelect2 + @sqlFrom2 + @sqlWhere2 + @sqlGroupBy2 + @sqlSelect3 + @sqlSelect3a + @sqlFrom3 + @sqlFrom3a + @sqlWhere3 + @sqlGroupBy3 + @sqlGroupBy3a + @sqlSelectunion + @sqlWhereUnion)

--select(@sqlSelect1)
--select(@sqlFrom1)
--select(@sqlWhere1 )
--select(@sqlGroupBy1) 
--select(@sqlSelect2 )
--select(@sqlFrom2 )
--select(@sqlWhere2 )
--select(@sqlGroupBy2) 
--select(@sqlSelect3 )
--select(@sqlSelect3a )
--select(@sqlFrom3 )
--select(@sqlFrom3a )
--select(@sqlWhere3 )
--select(@sqlGroupBy3) 
--select(@sqlGroupBy3a) 
--select(@sqlSelectunion)
--select(@sqlWhereUnion)
--print @sSQL

--IF NOT EXISTS (SELECT 1 FROM  SYSOBJECTS WHERE Xtype ='V' and Name ='AV0720')
--	EXEC(' CREATE VIEW AV0720 -- Tạo bởi WMP3003
--	        AS '+@sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy)
--ELSE
--	EXEC(' ALTER VIEW AV0720 -- Tạo bởi WMP3003
--	        AS '+@sqlSelect + @sqlFrom + @sqlWhere + @sqlGroupBy)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
