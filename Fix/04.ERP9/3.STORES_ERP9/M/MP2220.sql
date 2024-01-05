IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2220]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[MP2220]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
--- Load Grid danh sách cấu trúc sản phẩm
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Đình Hòa on: 13/05/2021
---- Modified by: Hoài Bảo on: 15/08/2022 - Cập nhật điều kiện search từ ngày đến ngày
---- Modified by: Hoàng Long on: 10/11/2023 - Cập nhật điều kiện search số PO
---- Modified by: Kiều Nga on: 04/12/2023 Bổ sung phân quyền dữ liệu @ConditionManufacturingPurchaseOrder

-- <Example>
/*
	MP2220 'HD','', 1, 2015, 6, 2015
*/
CREATE PROCEDURE MP2220
(
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@DivisionIDList NVARCHAR(2000),
	@IsDate TINYINT,--0: theo ngày, 1: Theo kỳ
	@FromDate Datetime,
	@ToDate Datetime,
	@Period NVARCHAR(4000), --Chọn trong DropdownChecklist Chọn kỳ  
	@VoucherNo NVARCHAR(250) ='',
	@ObjectName NVARCHAR(250) ='',
	@EmployeeName NVARCHAR(250) ='',
	@ClassifyID NVARCHAR(250) ='',
	@OrderStatus NVARCHAR(250) ='',
	@PONumber NVARCHAR(250) ='',
	@SearchWhere NVARCHAR(MAX) = null,
	@PageNumber INT,
	@PageSize INT,
	@ConditionManufacturingPurchaseOrder NVARCHAR(MAX) =''
)
AS

DECLARE @sSQL0 NVARCHAR (MAX)='',
		@sSQL NVARCHAR (MAX)='',
        @sSQL1 NVARCHAR (MAX)='',
        @sWhere NVARCHAR(MAX)='',
        @OrderBy NVARCHAR(500),
        @TotalRow NVARCHAR(50),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20),
		@SQLPermission NVARCHAR(MAX)=''
        
SET @sWhere = '1 = 1 '
SET @TotalRow = ''
SET @OrderBy = 'M1.CreateDate DESC'
SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'

IF ISNULL(@SearchWhere,'') =''
BEGIN
	IF @IsDate = 1
	BEGIN 
		--SET @sWhere = @sWhere + '  AND CONVERT(VARCHAR(10),M1.OrderDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
		BEGIN
			SET @sWhere = @sWhere + ' AND (M1.OrderDate >= ''' + @FromDateText + ''')'
		END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M1.OrderDate <= ''' + @ToDateText + ''')'
		END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
		BEGIN
			SET @sWhere = @sWhere + ' AND (M1.OrderDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
		END
	END

	ELSE IF @IsDate = 0 
		SET @sWhere = @sWhere + ' AND (CASE WHEN Month(M1.OrderDate) <10 THEN ''0''+rtrim(ltrim(str(Month(M1.OrderDate))))+''/''+ltrim(Rtrim(str(Year(M1.OrderDate)))) 
										ELSE rtrim(ltrim(str(Month(M1.OrderDate))))+''/''+ltrim(Rtrim(str(Year(M1.OrderDate)))) END) in ('''+@Period +''')'

	IF @DivisionIDList IS NULL or @DivisionIDList = ''
		SET @sWhere = @sWhere + ' and M1.DivisionID = '''+ @DivisionID+''''
	ELSE 
		SET @sWhere = @sWhere + ' and M1.DivisionID IN ('''+ REPLACE(@DivisionIDList, ',', ''',''') +''')'

	IF ISNULL(@VoucherNo,'') !=''
		SET @sWhere = @sWhere + ' AND ISNULL(M1.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'''

	IF ISNULL(@ObjectName,'') !=''
		SET @sWhere = @sWhere + ' AND (ISNULL(M1.ObjectName, '''') LIKE N''%'+@ObjectName+'%'' OR ISNULL(M1.ObjectID, '''') LIKE N''%'+@ObjectName+'%'')'

	IF ISNULL(@EmployeeName,'') !=''
		SET @sWhere = @sWhere + ' AND (ISNULL(M1.EmployeeID, '''') LIKE N''%'+@EmployeeName+'%'' OR ISNULL(M3.FullName, '''') LIKE N''%'+@EmployeeName+'%'')'

	IF ISNULL(@ClassifyID,'') !=''
		SET @sWhere = @sWhere + ' AND ISNULL(M1.ClassifyID, '''') = N'''+@ClassifyID+''''

	IF ISNULL(@OrderStatus,'') !=''
		SET @sWhere = @sWhere + ' AND ISNULL(M1.OrderStatus, '''') = N'''+@OrderStatus+''''

	IF ISNULL(@PONumber,'') !=''
		SET @sWhere = @sWhere + ' AND ISNULL(M5.nvarchar01, '''') = N'''+@PONumber+''''

END

IF ISNULL(@SearchWhere,'') !=''
BEGIN
	SET  @sWhere=' AND 1 = 1'
END

IF ISNULL(@ConditionManufacturingPurchaseOrder, '') != '' AND ISNULL(@ConditionManufacturingPurchaseOrder, '') != 'UNASSIGNED'
	SET @SQLPermission = @SQLPermission + ' INNER JOIN #PermissionMF2220 T1 ON M1.CreateUserID = T1.Value  '

SET @sSQL0 ='
		SELECT Value
		INTO #PermissionMF2220
		FROM STRINGSPLIT(''' + ISNULL(@ConditionManufacturingPurchaseOrder, '') + ''', '','')
		'

SET @sSQL = N'SELECT M1.APK, M1.DivisionID, M1.VoucherNo, M1.OrderDate, M2.Description AS OrderStatus, M1.ObjectID, M1.ObjectName, M1.Notes, M1.ShipDate, M3.FullName As EmployeeName
			, M4.ClassifyName AS ClassifyID, M1.CreateDate, M5.nvarchar01 as PONumber
			INTO #TempOT2001_MF2220
			FROM OT2001 M1 WITH(NOLOCK)
			LEFT JOIN SOT0099 M2 WITH(NOLOCK) ON M1.OrderStatus = M2.ID AND M2.CodeMaster = ''SOT2080.StatusID'' AND ISNULL(M2.Disabled, 0)= 0
			LEFT JOIN AT1103 M3 WITH(NOLOCK) ON M1.EmployeeID = M3.EmployeeID
			LEFT JOIN OT1001 M4 WITH(NOLOCK) ON M1.ClassifyID = M4.ClassifyID AND M4.Disabled = 0 AND M4.TypeID = ''SO''
			LEFT JOIN OT2002 M5 WITH(NOLOCK) ON M1.SOrderID = M5.SOrderID
			'+@SQLPermission+'
			WHERE ' + @sWhere + '' + ISNULL(@SearchWhere,'') + ' AND M1.OrderType = 1'

SET @sSQL1 =N'SELECT ROW_NUMBER() OVER (Order BY '+@OrderBy+') AS RowNum
				   , COUNT(*) OVER () AS TotalRow, M1.*
			  FROM #TempOT2001_MF2220 M1
			  '+ISNULL(@SearchWhere,'')+'
			  Order BY '+@OrderBy+'
			  OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			  FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

EXEC (@sSQL0 + @sSQL + @sSQL1)

PRINT (@sSQL)
PRINT (@sSQL1)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
