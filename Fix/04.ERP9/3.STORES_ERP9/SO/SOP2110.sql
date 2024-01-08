IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2110]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[SOP2110]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load Grid danh sách bảng tính giá
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Đình Hòa on: 13/05/2021
---- Modify by : ĐÌnh hoà o : 20/07/2021 : Bổ sung biến lọc
-- <Example>
/*
	SOP2110 'HD','', 1, 2015, 6, 2015
*/
CREATE PROCEDURE SOP2110
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@DivisionIDList NVARCHAR(2000),
	@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
	@FromDate Datetime,
	@ToDate Datetime,
	@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ  
	@InventoryName NVARCHAR(250) ='',
	@VoucherNo NVARCHAR(50) ='',
	@StatusSS NVARCHAR(250) ='',
	@AccountName NVARCHAR(MAX) ='',
	@Address NVARCHAR(MAX) ='',
	@SearchWhere NVARCHAR(MAX) = null,
	@PageNumber INT,
	@PageSize INT
)
AS

DECLARE @sSQL NVARCHAR (MAX)='',
        @sSQL1 NVARCHAR (MAX)='',
        @sWhere NVARCHAR(MAX)='',
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
        
SET @sWhere = '1 = 1 '
SET @TotalRow = ''
SET @OrderBy = 'S1.CreateDate DESC'

IF ISNULL(@SearchWhere,'') =''
BEGIN
	IF @IsDate = 1 
		SET @sWhere = @sWhere + '  AND CONVERT(VARCHAR(10),S1.CreateDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''

	ELSE IF @IsDate = 0 
		SET @sWhere = @sWhere + ' AND CONCAT(FORMAT(S1.TranMonth,''00''),''/'',S1.TranYear) in ('''+@Period +''')'

	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + ' and S1.DivisionID = '''+ @DivisionID+''''
	ELSE 
		SET @sWhere = @sWhere + ' and S1.DivisionID IN ('''+@DivisionIDList+''')'

	IF ISNULL(@InventoryName,'') !=''
		SET @sWhere = @sWhere + ' AND (ISNULL(S1.InventoryID, '''') LIKE N''%'+@InventoryName+'%'' OR ISNULL(S2.InventoryName, '''') LIKE N''%'+@InventoryName+'%'')'

	IF ISNULL(@VoucherNo,'') !=''
		SET @sWhere = @sWhere + ' AND (ISNULL(S1.VoucherNo, '''')) =  '''+@VoucherNo+''''

	IF ISNULL(@StatusSS,'') !=''
		SET @sWhere = @sWhere + ' AND (ISNULL(S1.StatusSS, '''')) = '''+@StatusSS+''''

	IF ISNULL(@AccountName,'') !=''
		SET @sWhere = @sWhere + ' AND (ISNULL(S1.AccountID, '''') = ''' + @AccountName +''' OR ISNULL(A02.ObjectName, '''') LIKE N''%' + @AccountName + '%'')'

	IF ISNULL(@Address,'') !=''
		SET @sWhere = @sWhere + ' AND (ISNULL(S1.Address, '''')) LIKE N''%'+ @Address + '%'''

END

IF ISNULL(@SearchWhere,'') !=''
BEGIN
	SET  @sWhere=' AND 1 = 1'
END

SET @sSQL = N'SELECT S1.APK, S1.DivisionID, S2.InventoryName, S1.PriceOriginal, S1.ProfitRate, S1.ProfitDesired, S1.PriceSetFactory
			  ,S1.PriceAcreageFactory, S1.PriceSetInstall, S1.PriceAcreageInstall, S1.PriceRival, S1.InventoryID, S1.SetNumber, S1.CreateDate
			  , S1.VoucherNo, S3.Description As StatusSS, A15.AnaName AS ColorName, S1.AccountID, A02.ObjectName AS AccountName, S1.Address
			  INTO #TemSOF2110
			FROM SOT2110 S1 WITH(NOLOCK)
			LEFT JOIN AT1302 S2 WITH(NOLOCK) ON S1.InventoryID = S2.InventoryID AND S2.DivisionID IN (S1.DivisionID,''@@@'')
			LEFT JOIN OOT0099 S3 WITH(NOLOCK) ON S1.StatusSS = S3.ID AND S3.CodeMaster = ''Status''
			LEFT JOIN AT1015 A15 WITH(NOLOCK) ON S1.ColorID = A15.AnaID AND A15.AnaTypeID = ''I02'' AND A15.DivisionID IN (''@@@'',S1.DivisionID)
			LEFT JOIN AT1202 A02 WITH(NOLOCK) ON S1.AccountID = A02.ObjectID AND A02.DivisionID IN (''@@@'',S1.DivisionID)
			WHERE ' + @sWhere + '' + ISNULL(@SearchWhere,'') + ''

SET @sSQL1 =N'SELECT ROW_NUMBER() OVER (Order BY '+@OrderBy+') AS RowNum
				   , COUNT(*) OVER () AS TotalRow, S1.*
			  FROM #TemSOF2110 S1
			  '+ISNULL(@SearchWhere,'')+'
			  Order BY '+@OrderBy+'
			  OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL + @sSQL1)

PRINT (@sSQL)
PRINT (@sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
