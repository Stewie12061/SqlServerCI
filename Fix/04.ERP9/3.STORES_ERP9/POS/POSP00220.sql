IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00220]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP00220]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Load Grid danh sách phiếu nhập kho
-- <Param>
----
-- <Return>
----
-- <Reference>
----KindVoucherID = 3: là Phiếu chuyển kho nội bộ
----IsCheck = 1: Đã duyệt phiếu đề nghị chuyển kho nội bộ
-- <History>
----Created by: Cao Thị Phượng Date 08/09/2017
-- <Example>
/*
   Exec POSP00220 'KC','' ,'','','', 'K001-KC05',0,'2015-01-01', '2017-12-31', '','PHUONG', 1,25
*/

 CREATE PROCEDURE POSP00220
(
		@DivisionID varchar(50),
		@VoucherTypeID varchar(50),
		@VoucherNo  varchar(50),
		@ObjectID  varchar(50),
		@ObjectName  nvarchar(250),
		@WareHouseID varchar(50), --Lấy từ biến môi trường truyền vào (Kho cửa hàng - trong màn hình thiết lập chung)
		@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
		@FromDate Datetime,
		@ToDate Datetime,
		@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ
		@UserID  VARCHAR(50),
		@PageNumber INT,
		@PageSize INT
		
)
AS
Begin
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
		
	SET @sWhere = ' '
	SET @TotalRow = ''
	SET @OrderBy = ' W.VoucherDate, W.VoucherNo '

	IF @PageNumber = 1 
		SET @TotalRow = 'COUNT(*) OVER ()' 
	ELSE 
		SET @TotalRow = 'NULL'
	
	IF Isnull(@DivisionID, '') != ''
		SET @sWhere = @sWhere + ' W.DivisionID = N'''+ @DivisionID+''''
	
	IF @IsDate = 0 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10),W.VoucherDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
	
	IF @IsDate = 1 
		SET @sWhere = @sWhere + ' AND (CASE WHEN W.TranMonth <10 THEN ''0''+rtrim(ltrim(str(W.TranMonth)))+''/''+ltrim(Rtrim(str(W.TranYear))) 
				ELSE rtrim(ltrim(str(W.TranMonth)))+''/''+ltrim(Rtrim(str(W.TranYear))) END) in ('''+@Period +''')'
	
	IF Isnull(@VoucherNo, '') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(W.VoucherNo,'''') LIKE N''%'+@VoucherNo+'%'' '
	
	IF Isnull(@ObjectID, '') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(W.ObjectID,'''') LIKE N''%'+@ObjectID+'%'' '

	IF Isnull(@ObjectName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(A.ObjectName, '''') LIKE N''%'+@ObjectName+'%'' '
	
	--Check @VoucherTypeID is Null
	IF Isnull(@VoucherTypeID, '')!=''
		SET @sWhere = @sWhere + ' AND W.VoucherTypeID ='''+@VoucherTypeID+''''
		
	--Check @WarehouseID2 is Null
	IF Isnull(@WarehouseID, '')!=''
		SET @sWhere = @sWhere + ' AND W.WarehouseID ='''+@WarehouseID+''''
		
		SET @sSQL = '
				Select ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, W.APK, W.TranMonth, W.TranYear
						,W.VoucherID, W.DivisionID, W.VoucherTypeID, W.VoucherNo, W.VoucherDate, W.ObjectID, A.ObjectName, W.Description
				From WT0095 W With (NOLOCK) Left join AT1202 A With (NOLOCK) on W.ObjectID = A.ObjectID
				WHERE '+@sWhere+' and W.KindVoucherID = 3 and W.IsCheck = 1 
				ORDER BY '+@OrderBy+'
				OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
				FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

			EXEC (@sSQL)
			--Print (@sSQL)	
End
