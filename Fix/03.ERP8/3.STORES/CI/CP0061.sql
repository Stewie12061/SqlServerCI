IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'CP0061') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE CP0061
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load Grid Master Form CF0186 Kế thừa bảng giá OUT
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Thị Phượng, Date: 27/07/2017
-- <Example>
/*

EXEC CP0061 'MS' , 'B','','','','%','VND','PHUONG'

*/
CREATE PROCEDURE CP0061 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
		@ID nvarchar(50),
		@Description nvarchar(250),
		@FromDate Datetime,
		@ToDate Datetime,
        @InventoryTypeID nvarchar(250),
		@CurrencyID nvarchar(250),
		@UserID  VARCHAR(50)
) 
AS 
BEGIN
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@CustomerName as int

CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

---------INSERT dữ liệu từ file excel vào bảng tạm---------------------------------------
If @CustomerName = 79 --Customize MINH SANG
BEGIN
		
	SET @sWhere = ' '
	SET @TotalRow = ''
	SET @OrderBy = ' M.ID'
	
	IF Isnull(@DivisionID, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID = N'''+ @DivisionID+''''
	
	If Isnull(@FromDate,'')!=''
		SET @sWhere = @sWhere + ' AND (CONVERT(VARCHAR(10),M.FromDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+'''
										OR CONVERT(VARCHAR(10),M.ToDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''')'
		
	IF Isnull(@ID, '') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(M.ID,'''') LIKE N''%'+@ID+'%'' '
	
	IF Isnull(@Description, '') != ''
		SET @sWhere = @sWhere +  'AND ISNULL(M.Description,'''') LIKE N''%'+@Description+'%'' '

	IF Isnull(@InventoryTypeID, '') != ''
		SET @sWhere = @sWhere + ' AND (ISNULL(M.InventoryTypeID, '''') LIKE N''%'+@InventoryTypeID+'%'' Or ISNULL(D1.InventoryTypeName, '''') LIKE N''%'+@InventoryTypeID+'%'' )'
	
	IF Isnull(@CurrencyID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.CurrencyID,'''') LIKE N''%'+@CurrencyID+'%''  '


SET @sSQL = ' SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS OrderNo 
					, M.APK, M.DivisionID, M.ID, M.Description, M.FromDate
					, M.ToDate, M.InventoryTypeID, D1.InventoryTypeName , M.CurrencyID, M.Disabled, M.CreateDate, M.CreateUserID
					from OT1301_MS M With (NOLOCK)   
						left join AT1301 D1 With (NOLOCK) on M.InventoryTypeID = D1.InventoryTypeID
						
				WHERE '+@sWhere+'
				ORDER BY '+@OrderBy+''
EXEC (@sSQL)
END
END