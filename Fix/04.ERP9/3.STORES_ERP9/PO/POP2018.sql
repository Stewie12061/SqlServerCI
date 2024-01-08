IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2018]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2018]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Load truy vấn danh sách leadtime_MOQ (ATTOM)
 -- <Return>
 ---- 
 -- <Reference>
 ---- PO ERP9.0 \ Nghiệp vụ \ LeadTime_MOQ (POF2013)
 -- <History>
 ----Created by Tiểu Mai on 03/07/2018
 ----Modified by Tra Giang on  18/10/2018: Lấy thông tin người lập từ bảng AT1103 thay cho bang AT1405
 ----Modified by Tra Giang on  30/10/2018: Sửa thông tin lọc theo thời gian
 /*-- <Example>
 	POP2018 @DivisionID='AT',@DivisionList = 'AT'',''AT1',@UserID='ASOFTADMIN', @PageNumber=11,@PageSize=25, @VoucherNo='afas',@InventoryTypeID='HH',@EmployeeID='ASOFTADMIN',
 	@FromDate='2018-02-01', @ToDate='2019-02-28',@SearchWhere=NULL, @Mode=0, @APKList = 'D54AAB34-9C6E-41E4-BEA2-25637A017F22'
	
 ----*/
 
CREATE PROCEDURE POP2018
( 
  @DivisionID VARCHAR(50),
  @DivisionList VARCHAR(MAX),
  @UserID VARCHAR(50),
  @PageNumber INT,
  @PageSize INT,
  @VoucherNo VARCHAR(50),
  @InventoryTypeID VARCHAR(50),
  @EmployeeID VARCHAR(50),
  @FromDate DATETIME,
  @ToDate DATETIME,
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

SET @OrderBy = 'Temp.LeadTimeID'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@DivisionList, '') <> ''
BEGIN
	IF @DivisionList <> '%' SET @sWhere = @sWhere + ' T1.DivisionID IN ('''+@DivisionList+''')'
END
ELSE SET @sWhere = @sWhere + ' T1.DivisionID = '''+@DivisionList+''' ' 

SELECT TOP 1 @LanguageID = ISNULL(LanguageID,'') FROM AT14051 WITH (NOLOCK) WHERE UserID = @UserID

IF ISNULL(@SearchWhere,'') = ''
BEGIN
	IF ISNULL(@VoucherNo,'') <> '' SET @sWhere = @sWhere + ' AND T1.LeadTimeID LIKE ''%'+@VoucherNo+'%'' '
	IF ISNULL(@FromDate,'') <> '' SET @sWhere = @sWhere + ' AND T1.FromDate <= '''+CONVERT(VARCHAR(10),@FromDate,120)+''' '
	IF ISNULL(@ToDate,'') <> '' SET @sWhere = @sWhere + ' AND T1.ToDate >= '''+CONVERT(VARCHAR(10),@ToDate,120)+''' '
	IF ISNULL(@InventoryTypeID,'') <> '' SET @sWhere = @sWhere + ' AND T1.InventoryTypeID LIKE '''+@InventoryTypeID+''' '
	IF ISNULL(@EmployeeID,'') <> '' SET @sWhere = @sWhere + ' AND T1.EmployeeID LIKE '''+@EmployeeID+''' '
END

IF @Mode = 0 ---Load form
BEGIN
	SET @sSQL = '
SELECT DISTINCT T1.*, T3.InventoryTypeName, A03.FullName as EmployeeName
INTO #POP2013
FROM POT2013 T1 WITH (NOLOCK)
LEFT JOIN AT1301 T3 WITH (NOLOCK) ON T1.InventoryTypeID = T3.InventoryTypeID AND T3.DivisionID IN (T1.DivisionID,''@@@'')
LEFT JOIN AT1103 A03 WITH (NOLOCK) ON T1.DivisionID = A03.DivisionID AND T1.EmployeeID = A03.EmployeeID
WHERE '+@sWhere+'

SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM #POP2013 AS Temp
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
