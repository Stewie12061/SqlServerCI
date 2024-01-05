IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2028]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2028]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Load truy vấn danh sách kế hoạch mua hàng dự trữ (ATTOM)
 -- <Return>
 ---- 
 -- <Reference>
 ---- PO ERP9.0 \ Nghiệp vụ \ Kế hoạch mua hàng dự trữ (POF2021)
 -- <History>
 ----Created by Tiểu Mai on 17/07/2018
 ----Modified by on 
 /*-- <Example>
 	POP2028 @DivisionID='AT',@DivisionList = 'AT'',''AT1',@UserID='ASOFTADMIN', @PageNumber=11,@PageSize=25, @VoucherNo='afas',@InventoryTypeID='HH',@EmployeeID='ASOFTADMIN',
 	@FromDate='2018-02-01', @ToDate='2019-02-28',@SearchWhere=NULL, @Mode=0, @APKList = 'D54AAB34-9C6E-41E4-BEA2-25637A017F22'
	
 ----*/
 
CREATE PROCEDURE POP2028
( 
  @DivisionID VARCHAR(50),
  @DivisionList VARCHAR(MAX),
  @UserID VARCHAR(50),
  @PageNumber INT,
  @PageSize INT,
  @VoucherNo VARCHAR(50),
  @VoucherTypeID VARCHAR(50),
  @InventoryTypeID VARCHAR(50),
  @VoucherFromDate DATETIME,
  @VoucherToDate DATETIME,
  @OrderFromDate DATETIME,
  @OrderToDate DATETIME,
  @SearchWhere NVARCHAR(Max) = NULL,
  @Mode TINYINT, --0: load form, 1: in phiếu
  @APKList VARCHAR(MAX)
) 
AS
DECLARE @sSQL NVARCHAR (MAX) = N'',
		@sSQL1 NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N'',
		@LanguageID VARCHAR(50)

SET @OrderBy = 'Temp.VoucherNo'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@DivisionList, '') <> ''
BEGIN
	IF @DivisionList <> '%' SET @sWhere = @sWhere + ' T1.DivisionID IN ('''+@DivisionList+''')'
END
ELSE SET @sWhere = @sWhere + ' T1.DivisionID = '''+@DivisionList+''' ' 

SELECT TOP 1 @LanguageID = ISNULL(LanguageID,'') FROM AT14051 WITH (NOLOCK) WHERE UserID = @UserID

IF ISNULL(@SearchWhere,'') = ''
BEGIN
	IF ISNULL(@VoucherNo,'') <> '' SET @sWhere = @sWhere + ' AND T1.VoucherNo LIKE ''%'+@VoucherNo+'%'' '
	IF ISNULL(@VoucherFromDate,'') <> '' SET @sWhere = @sWhere + ' AND T1.CreateDate BETWEEN '''+CONVERT(VARCHAR(10),@VoucherFromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@VoucherToDate,120)+''' '
	IF ISNULL(@OrderFromDate,'') <> '' SET @sWhere = @sWhere + ' AND T1.OrderDate BETWEEN '''+CONVERT(VARCHAR(10),@OrderFromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@OrderToDate,120)+''' '
	IF ISNULL(@VoucherTypeID,'') <> '' SET @sWhere = @sWhere + ' AND T1.VoucherTypeID LIKE '''+@VoucherTypeID+''' '
	IF ISNULL(@InventoryTypeID,'') <> '' SET @sWhere = @sWhere + ' AND T1.InventoryTypeID LIKE '''+@InventoryTypeID+''' '
END

IF @Mode = 0 ---Load form
BEGIN
	SET @sSQL = '
SELECT DISTINCT T1.*, T3.InventoryTypeName, A05.UserName as EmployeeName
INTO #POP2017
FROM POT2017 T1 WITH (NOLOCK)
LEFT JOIN AT1301 T3 WITH (NOLOCK) ON T1.InventoryTypeID = T3.InventoryTypeID AND T3.DivisionID IN (T1.DivisionID,''@@@'')
LEFT JOIN POT2013 P13 WITH (NOLOCK) ON T1.LeadTimeID = P13.LeadTimeID AND P13.DivisionID = T1.DivisionID
LEFT JOIN AT1405 A05 WITH (NOLOCK) ON T1.CreateUserID = A05.UserID  
WHERE '+@sWhere+'

SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM #POP2017 AS Temp
'+CASE WHEN ISNULL(@SearchWhere,'') <> '' THEN @SearchWhere ELSE '' END+'
ORDER BY '+@OrderBy+' 
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

	--PRINT(@sSQL)
	EXEC(@sSQL)

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
