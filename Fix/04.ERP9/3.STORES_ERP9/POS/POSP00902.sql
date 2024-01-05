IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00902]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POSP00902]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load danh sách duyệt hàng khuyến mãi
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Create on 28/07/2017 by Cao Thị Phượng
--- Modify by 
-- <Example> EXEC POSP00902 'MSA', '', 1, '2017-01-01', '2017-11-30', '04/2017'',''05/2017', '', '', '', '', '', 'PHUONG', 1, '3D98EA5C-8CE0-4FF0-887A-641753F311DD'',''676D753A-CFC1-42FA-8FFF-1C98A30C239C'

CREATE PROCEDURE POSP00902 (
   @DivisionID		NVARCHAR(50), --Biến môi trường
   @DivisionIDList	NVARCHAR(MAX), --Giá trị truyền Dropdown đơn vị
   @IsDate			TINYINT,  --1: Theo ngày; 0: Theo kỳ
   @FromDate		DATETIME, 
   @ToDate			DATETIME, 
   @Period			NVARCHAR(2000),
   @ShopID			NVARCHAR(MAX),
   @VoucherNo		NVARCHAR(MAX),
   @MemberID		NVARCHAR(MAX),
   @MemberName		NVARCHAR(MAX),
   @Status			NVARCHAR(MAX),
   @UserID			NVARCHAR(50) ,
   @IsCheckAll		TINYINT, --Không check mà xuất luôn
   @APKList			NVARCHAR(MAX) ---APK của từng phiếu check
   )
 AS

DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)
IF @CustomerName = 79 ------ MINH SANG
Begin 
DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX),
		@OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50)
        
SET @sWhere=''
SET @OrderBy = 'M.Status, M.VoucherNo'
	IF @IsDate = 1 
	SET @sWhere = @sWhere + '  CONVERT(VARCHAR(10),POST00901.VoucherDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
	IF @IsDate = 0 
	SET @sWhere = @sWhere + '  (CASE WHEN POST00901.TranMonth <10 THEN ''0''+rtrim(ltrim(str(POST00901.TranMonth)))+''/''+ltrim(Rtrim(str(POST00901.TranYear))) 
				ELSE rtrim(ltrim(str(POST00901.TranMonth)))+''/''+ltrim(Rtrim(str(POST00901.TranYear))) END) in ('''+@Period +''')'
	--Check Para DivisionIDList null then get DivisionID 
	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + 'and POST00901.DivisionID = '''+ @DivisionID+''''
	Else 
		SET @sWhere = @sWhere + 'and POST00901.DivisionID IN ('''+@DivisionIDList+''')'
	IF Isnull(@ShopID, '')!=''
		SET @sWhere = @sWhere + ' AND ISNULL(POST00901.ShopID,'''') LIKE N''%'+@ShopID+'%'' '
	IF Isnull(@VoucherNo, '') != '' 
		SET @sWhere = @sWhere + ' AND ISNULL(POST00901.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' '
	IF Isnull(@MemberID, '')!=''
		SET @sWhere = @sWhere + ' AND ISNULL(POST00901.MemberID,'''') LIKE N''%'+@MemberID+'%'' '
	IF Isnull(@MemberName, '')!=''
		SET @sWhere = @sWhere + ' AND ISNULL(POST00901.MemberName,'''') LIKE N''%'+@MemberName+'%'' '
	IF Isnull(@Status, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(POST00901.Status, 0) = N'''+@Status+''' '
	IF Isnull(@IsCheckAll, 0) = 0 
		SET  @sWhere = @sWhere +'and cast (POST00901.APK as Varchar(50)) IN ('''+@APKList+''')'
SET @sSQL = '
SELECT POST00901.APK, POST00901.DivisionID, POST00901.VoucherTypeID, POST00901.VoucherNo, POST00901.ShopID, Z.ShopName
, convert(varchar(20), POST00901.VoucherDate, 103) as VoucherDate
, POST00901.ObjectID, POST00901.ObjectName , POST00901.MemberID, POST00901.MemberName
, POST00901.Description, isnull(POST00901.Status, 0) as Status , POST0099.Description as StatusName
, POST00901.CreateDate, POST00901.CreateUserID, POST00901.LastModifyUserID, POST00901.LastModifyDate, POST00901.TranMonth, POST00901.TranYear 
, POST00901.IsConfirm, POST00901.ConfirmDate, POST00901.ConfirmUserID, A03.FullName  as ConfirmUserName
, A.InventoryID, A.InventoryName, A.ActualQuantity, A.UnitID, A.UnitPrice, A.CA, A.PromoteInventoryID, A.PromoteUnitPrice
, A.SuggestInventoryID, A.SuggestUnitPrice, A.SuggestCA, A.NotesConfirm, B.Description IsConfirmDetail, A.Orders
Into #TemPOST00901
FROM POST00901 With (NOLOCK) 
		Inner join POST00902 A With (NOLOCK) ON A.APKMaster = cast (POST00901.APK as Varchar(50))
		LEFT JOIN POST0010 Z WITH (NOLOCK) ON Z.ShopID = POST00901.ShopID
		Left join POST0099 B With (NOLOCK) on isnull(A.IsConfirmDetail,0) = B.ID and B.CodeMaster = ''POS000011''
		Left join AT1103 A03 With (NOLOCK) on POST00901.ConfirmUserID = A03.EmployeeID
		Left join POST0099 With (NOLOCK) on isnull(POST00901.Status,0) = POST0099.ID and POST0099.CodeMaster = ''POS000011''
	WHERE '+@sWhere+' and isnull(A.DeleteFlg,0) =0
	Declare @Count int
	Select @Count = Count(Status) From  #TemPOST00901

	SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow,
	M.APK, M.DivisionID, M.VoucherTypeID,  M.VoucherNo, M.ShopID, M.ShopName
	, M.VoucherDate, M.ObjectID, M.ObjectName, M.MemberID, M.MemberName, M.Description, M.Status, M.StatusName
	, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear, M.IsConfirm
	, M.ConfirmDate, M.ConfirmUserID, M.ConfirmUserName
	, M.InventoryID, M.InventoryName, M.ActualQuantity, M.UnitID, M.UnitPrice, M.CA, M.PromoteInventoryID, M.PromoteUnitPrice
	, M.SuggestInventoryID, M.SuggestUnitPrice, M.SuggestCA, M.NotesConfirm, M.IsConfirmDetail, M.Orders
	From  #TemPOST00901 M
	ORDER BY '+@OrderBy+''

EXEC (@sSQL)
--Print (@sSQL)
end
GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
