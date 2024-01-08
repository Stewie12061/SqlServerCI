IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AP0710_HT]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[AP0710_HT]
GO
SET QUOTED_IDENTIFIER ON
GO

-- <Summary>
---- Lọc theo mã phân tích đối tượng 
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 21/01/2016 by Thị Phượng: Lọc theo mã phân tích đối tượng (Mã phân tích 5 (O05ID)) + theo dõi vỏ(IsBottle)(Customize Hoàng Trần)
-- <Example>
---- 

CREATE PROCEDURE [dbo].[AP0710_HT]
(
    @DivisionID       AS NVARCHAR(50),
    @FromObjectID     AS NVARCHAR(50),
    @ToObjectID       AS NVARCHAR(50),
    @FromInventoryID  AS NVARCHAR(50),
    @ToInventoryID    AS NVARCHAR(50),
    @FromPeriod       AS INT,
    @ToPeriod         AS INT,
    @FromDate         AS DATETIME,
    @ToDate           AS DATETIME,
    @IsDate           AS TINYINT,
    @FromO05ID        AS NVarchar(250),
	@ToO05ID		  AS NVarchar(250)
)
AS
DECLARE @sSQL           AS NVARCHAR(4000),
        @sWhere        AS NVARCHAR(4000),
		@FromDateText NVARCHAR(20), 
		@ToDateText NVARCHAR(20)
    
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
SET @sWhere=''

   
IF PATINDEX('[%]', @FromO05ID) > 0
	BEGIN
		SET @sWhere = @sWhere + ' And x.O05ID Like N''' + @FromO05ID + ''''
	END
ELSE
	IF @FromO05ID IS NOT NULL AND @FromO05ID <> ''
	BEGIN
		SET @sWhere = @sWhere + ' And Isnull(x.O05ID,'''') >= N''' + REPLACE(@FromO05ID, '[]', '') + 
									''' And Isnull(x.O05ID,'''') <= N''' + REPLACE(@ToO05ID, '[]', '') + ''''
	END 
IF Isnull(@FromObjectID, '') != ''
	Set @sWhere = @sWhere+ 'and (x.ObjectID between  N''' + @FromObjectID + ''' and  N''' + @ToObjectID+ ''')'
IF Isnull(@FromInventoryID, '' ) !=''
	Set @sWhere = @sWhere+'and (x.InventoryID between N''' + @FromInventoryID + ''' and N''' + @ToInventoryID+ ''')'
IF @IsDate = 1
    ---- xac dinh so lieu theo ngay
    SET @sWhere = @sWhere+' and (x.VoucherDate  Between  ''' + @FromDateText + '''  and ''' + @ToDateText + '''  ) '
ELSE
    SET @sWhere = @sWhere+' and (x.TranMonth+ 100*x.TranYear Between ' + Convert(Varchar(10),@FromPeriod) + ' and  ' + Convert(Varchar(10),@ToPeriod) + '  ) ' 

SET @sSQL=N'
Select y.DivisionID,y.O05ID, y.ObjectAnaName5,
	isnull(y.BeginQuantity,0) as BeginQuantity,
	isnull(y.BeginConvertedQuantity,0) as BeginConvertedQuantity,
	isnull(y.BeginMarkQuantity,0) as BeginMarkQuantity,
	isnull(y.DebitQuantity,0) as DebitQuantity, 
	isnull(y.CreditQuantity,0) as CreditQuantity,
	isnull(y.DebitConvertedQuantity,0) as DebitConvertedQuantity, 
	isnull(y.CreditConvertedQuantity,0) as CreditConvertedQuantity,
	isnull(y.DebitMarkQuantity,0) as DebitMarkQuantity, 
	isnull(y.CreditMarkQuantity,0) as CreditMarkQuantity,
	isnull(y.BeginQuantity,0) + isnull(y.CreditQuantity,0) - isnull(y.DebitQuantity,0) as EndQuantity,
	isnull(y.BeginConvertedQuantity,0) + isnull(y.CreditConvertedQuantity,0)  - isnull(y.DebitConvertedQuantity,0) as EndConvertedQuantity,
	isnull(y.BeginMarkQuantity,0) + isnull(y.CreditMarkQuantity,0)  - isnull(y.DebitMarkQuantity,0) as EndMarkQuantity
	From
	(
		Select x.DivisionID,x.O05ID, x.ObjectAnaName5,
		sum(isnull(SignQuantity,0))  as BeginQuantity,
		sum(isnull(SignConvertedQuantity,0))  as BeginConvertedQuantity,
		sum(isnull(SignMarkQuantity,0))  as BeginMarkQuantity,
		Sum(Case when D_C = ''D'' then isnull(x.MarkQuantity,0) else 0 end) as DebitMarkQuantity,
		Sum(Case when D_C = ''C'' then isnull(x.MarkQuantity,0) else 0 end) as CreditMarkQuantity,
		Sum(Case when D_C = ''D'' then isnull(x.ActualQuantity,0) else 0 end) as DebitQuantity,
		Sum(Case when D_C = ''C'' then isnull(x.ActualQuantity,0) else 0 end) as CreditQuantity,
		Sum(Case when D_C = ''D'' then isnull(x.ConvertedQuantity,0) else 0 end) as DebitConvertedQuantity,
		Sum(Case when D_C = ''C'' then isnull(x.ConvertedQuantity,0) else 0 end) as CreditConvertedQuantity
		From AV7000_HT x
		Where x.IsBottle =1
		AND  x.DivisionID like N'''+ @DivisionID  + 
		''' and
		x.D_C in (''D'',''C'', ''BD'' )'
		+ @sWhere +'
		Group by x.DivisionID, x.O05ID, x.ObjectAnaName5
)y
'
     
EXEC (@sSQL)
GO