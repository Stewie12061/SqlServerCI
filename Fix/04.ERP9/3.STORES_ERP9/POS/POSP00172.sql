IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP00172]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP00172]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- Load Grid danh sách phiếu kiểm kê
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Phan thanh hoang vu; Create date: 11/04/2014
----Modify by: Phan thanh hoang vu; Create date: 14/06/2016: cải thiện tốc độ và tahy đồi control load từ kỳ, đến kỳ
/*
	EXEC POSP00172 'MSA','',1,'2017-02-01','2017-12-01','01/2016'',''02/2016'',''11/2017','MS','','','',1,''
	
*/
 CREATE PROCEDURE POSP00172
(
	 @DivisionID		VARCHAR(50),
     @DivisionIDList	NVARCHAR(2000),
     @IsDate			TINYINT, --0:Datetime; 1:Period
     @FromDate			DATETIME,
     @ToDate			DATETIME,
	 @PeriodList		NVARCHAR(2000),
	 @ShopID			NVARCHAR(50),
     @VoucherNo			NVARCHAR(50),
	 @EmployeeName		NVARCHAR(50),
	 @Description		NVARCHAR(250),
	 @IsCheckAll		TINYINT, --Không check mà xuất luôn
	 @APKList			NVARCHAR(MAX) ---APK của từng phiếu check
)
AS
DECLARE @sSQL01 NVARCHAR (4000),
		@sSQL02 NVARCHAR (4000),
		@sSQL03 NVARCHAR (2000),
        @sWhere NVARCHAR(MAX),
        @OrderBy NVARCHAR(500)

	SET @sWhere = ''
	SET @OrderBy = 'DivisionID, ShopID, VoucherDate, VoucherNo'

	--Check Para DivisionIDList null then get DivisionID 
	IF Isnull(@DivisionIDList, '') != ''
		SET @sWhere = @sWhere + ' M.DivisionID IN ('''+@DivisionIDList+''')'
	Else 
		SET @sWhere = @sWhere + ' M.DivisionID = '''+ @DivisionID+''''
	
	IF @IsDate = 0 
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10),M.VoucherDate,112) BETWEEN '+CONVERT(VARCHAR(10),@FromDate,112)+' AND '+CONVERT(VARCHAR(10),@ToDate,112)+' '
	
	IF @IsDate = 1 
		SET @sWhere = @sWhere + ' AND (Case When  M.TranMonth <10 then ''0''+rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) 
							Else rtrim(ltrim(str(M.TranMonth)))+''/''+ltrim(Rtrim(str(M.TranYear))) End) IN ('''+@PeriodList+''')'

	IF Isnull(@ShopID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.ShopID,'''') LIKE N''%'+@ShopID+'%'' '
	
	IF Isnull(@VoucherNo, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.VoucherNo,'''') LIKE N''%'+@VoucherNo+'%'' '
	
	IF Isnull(@EmployeeName, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.EmployeeName,'''') LIKE N''%'+@EmployeeName+'%'' '
	
	IF Isnull(@Description, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M.Description,'''') LIKE N''%'+@Description+'%'' '
	IF Isnull(@IsCheckAll, 0) = 0 
		SET  @sWhere = @sWhere +'and cast (M.APK as Varchar(50)) IN ('''+@APKList+''')'
	--Lấy Distinct Phiếu kiểm kê
	SET @sSQL01 = '	Select	M.APK, M.DivisionID, M.ShopID, Z.ShopName,  M.VoucherTypeID, M.VoucherNo , M.VoucherDate, M.TranMonth
								, M.TranYear, M.ObjectID, M.ObjectName, M.EmployeeID +'' - ''+ M.EmployeeName EmployeeID, M.Description as MDescription,M.Status
								, D.InventoryID, D.InventoryName, D.UnitID, D.UnitName, D.BooksQuantity
								, D.ActualQuantity, D.AdjustQuantity, D.Description
						INTO #POST00171
						FROM POST0017 M WITH (NOLOCK)
						INNER JOIN POST00171 D WITH (NOLOCK) ON D.APKMaster =  cast (M.APK as Varchar(50))
						LEFT JOIN POST0010 Z WITH (NOLOCK) ON Z.ShopID = M.ShopID
						WHERE ' +@sWhere + 'AND M.DeleteFlg = 0	 AND isnull(D.DeleteFlg,0) = 0'

	--Kiểm tra load mac định thì lấy tổng số trang, ngược lại thì không lấy tổng số trang (Cải tiến tốc độ )
	SET @sSQL02 = '		Declare @CountTotal NVARCHAR(Max)
						Set @CountTotal = (Select Count(APK) From #POST00171)
						'
	SET @sSQL03 = '
		SELECT 	ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @CountTotal AS TotalRow,
				APK, DivisionID, ShopID, ShopName, VoucherTypeID, VoucherNo , VoucherDate, TranMonth
				, TranYear, ObjectID, ObjectName, EmployeeID,Status, MDescription
				, InventoryID, InventoryName, UnitID, UnitName, BooksQuantity
				, ActualQuantity, AdjustQuantity, Description
		FROM #POST00171 
		ORDER BY '+@OrderBy+' '

EXEC (@sSQL01+@sSQL02+@sSQL03)
