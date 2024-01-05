IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP30221]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP30221]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load dữ liệu in report chương trình khuyến mãi
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 27/10/2023 by Nhật Thanh
-- <Example>

CREATE PROCEDURE SOP30221
( 
	@DivisionID NVARCHAR(50),
	@DivisionIDList NVARCHAR(50),
	@FromDate NVARCHAR(250),
	@ToDate NVARCHAR(250),
	@IsDate NVARCHAR(250),
	@FromPeriod NVARCHAR(250),
	@ToPeriod NVARCHAR(250),
	@ObjectID NVARCHAR(250),
	@Code NVARCHAR(250),
	@Promote NVARCHAR(250)
)
AS
DECLARE @sSQL NVARCHAR(MAX) = '',
		@sWhere	 NVARCHAR(MAX) = '',
		@sWhere2 NVARCHAR(MAX) = '',
		@sWhere3 NVARCHAR(MAX) = '',
		@OID nvarchar(50) = (SELECT TypeID FROM AT0005 WITH (NOLOCK)
      		WHERE DivisionID in ('@@@',@DivisionID) and TypeID like 'O%' and status = 1)

IF @IsDate = 0
BEGIN
	SET @sWhere = @sWhere + ' AND (Case When  Month(C30.CreateDate) <10 then ''0''+rtrim(ltrim(str(Month(C30.CreateDate))))+''/''
										+ltrim(Rtrim(str(Year(C30.CreateDate)))) Else rtrim(ltrim(str(Month(C30.CreateDate))))+''/''
										+ltrim(Rtrim(str(Year(C30.CreateDate)))) End) BETWEEN '''+Convert(nvarchar(10),@FromPeriod,7)+''' AND '''+convert(nvarchar(10), @ToPeriod,7)+''''
END	
ELSE
BEGIN
	SET @sWhere = @sWhere + ' And (C30.CreateDate  BETWEEN '''+Convert(nvarchar(10),@FromDate,21)+''' AND '''+convert(nvarchar(10), @ToDate,21)+''')'							
END	

IF ISNULL(@ObjectID,'%')!='%'
BEGIN
	SET @sWhere = @sWhere + ' And C30.ObjectID IN (''' + @ObjectID + ''')'			
END
IF ISNULL(@Code,'%')!='%'
BEGIN
	SET @sWhere = @sWhere + ' And (SELECT TOP 1 CASE WHEN ''' + @OID +''' = ''O01''  THEN CASE WHEN O01ID IS NULL OR O01ID = '''' THEN ''%'' ELSE O01ID  END
				WHEN ''' + @OID +''' = ''O02'' THEN CASE WHEN O02ID IS NULL OR O02ID = '''' THEN ''%'' ELSE O02ID END
				WHEN ''' + @OID +''' = ''O03'' THEN CASE WHEN O03ID IS NULL OR O03ID = '''' THEN ''%'' ELSE O03ID END 
				WHEN ''' + @OID +''' = ''O04'' THEN CASE WHEN O04ID IS NULL OR O04ID = '''' THEN ''%'' ELSE O04ID END
				ELSE CASE WHEN O05ID IS NULL OR O05ID = '''' THEN ''%'' ELSE O05ID  END							 
				END 
				FROM AT1202 WITH (NOLOCK) WHERE ObjectID = C30.ObjectID) IN (''' + @Code + ''')'			
END
IF ISNULL(@Promote,'')!=''
BEGIN
	SET @sWhere = @sWhere + ' And C30.PromoteID = ''' + @Promote + ''''			
END

SET @sSQL = N'SELECT ROW_NUMBER() OVER (ORDER BY C20.PromoteID, C30.ObjectID) AS RowNum, C30.ObjectID, C30.ObjectName, C20.PromoteID, C20.PromoteName, C30.Notes, C30.DiscountValue, C30.DiscountScores, 
			C30.InventoryGiftID,A02.InventoryName InventoryGiftName, CONCAT(ISNULL(C10.ToolName,N''Số lượng''),'' '',
			CASE ISNULL(C22.Target,'''') WHEN '''' then N''sản phẩm trong đơn hàng'' when ''Diem'' then N''điểm'' else C22.Target end) as Target, 
			C22.TargetQuantity, ISNULL(A02.InventoryName,N''Tiền'') as Promotion, C22.Value , CASE WHEN C30.IsAvailable = 1 then N''Khả dụng'' else N''Không khả dụng'' end as IsAvailable,
			(SELECT AnaName From AT1015 WHERE AnaID = (SELECT	DISTINCT CASE WHEN ''' + @OID +''' = ''O01''  THEN CASE WHEN O01ID IS NULL OR O01ID = '''' THEN ''%'' ELSE O01ID  END
				WHEN ''' + @OID +''' = ''O02'' THEN CASE WHEN O02ID IS NULL OR O02ID = '''' THEN ''%'' ELSE O02ID END
				WHEN ''' + @OID +''' = ''O03'' THEN CASE WHEN O03ID IS NULL OR O03ID = '''' THEN ''%'' ELSE O03ID END 
				WHEN ''' + @OID +''' = ''O04'' THEN CASE WHEN O04ID IS NULL OR O04ID = '''' THEN ''%'' ELSE O04ID END
				ELSE CASE WHEN O05ID IS NULL OR O05ID = '''' THEN ''%'' ELSE O05ID  END							 
				END 
				FROM AT1202 WITH (NOLOCK) WHERE ObjectID = C30.ObjectID)) as OIDObject, 
				(SELECT ISNULL(SUM(ISNULL(CASE WHEN ISNULL(TVoucherID,'''')!='''' THEN OriginalAmount ELSE -OriginalAmount END,0)),0) From  AT9000 WITH (NOLOCK) 
				    Where (TransactionTypeID in (''T01'',''T02'',''T11'')    
					or ( TransactionTypeID =''T21'' and CreditAccountID like ''111%'') )  ---- Chi qua ngan hang      
					and AT9000.DivisionID = C30.DivisionID and ObjectID = C30.ObjectID and Ana01ID = C20.PromoteID) as DepositSpending
			FROM CIT1530 C30
			LEFT JOIN CIT1220 C20 on C20.PromoteID = C30.PromoteID
			LEFT JOIN CIT1222 C22 on C30.APKCIT1222 = C22.APK
			LEFT JOIN CIT1510 C10 on C22.UnitID = C10.ToolID
			LEFT JOIN AT1302 A02 on A02.DivisionID in (''@@@'',C30.DivisionID) and A02.InventoryID = C30.InventoryGiftID
			WHERE ISNULL(C30.DiscountScores,0)=0
			'
			+@sWhere
			+'ORDER BY C20.PromoteID, C30.ObjectID, C22.ConditionID'
print(@sSQL)
Exec(@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
