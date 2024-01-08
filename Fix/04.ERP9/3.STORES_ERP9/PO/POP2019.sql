IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2019]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2019]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Load truy vấn đơn đặt hàng (ATTOM)
 -- <Return>
 ---- 
 -- <Reference>
 ---- PO ERP9.0 \ Nghiệp vụ \ Đơn đặt hàng (POF2017)
 -- <History>
 ----Created by Tiểu Mai on 03/07/2018
  ----Modify by Tra Giang on 02/11/2018: Bổ sung search theo VoucherDate

 /*-- <Example>
 	exec POP2019 @DivisionID=N'AT',@DivisionList=N'AT',@UserID=N'KHAVI',@PageNumber=1,@PageSize=25,@VoucherNo=N'',@OrderStatus=N'',@ObjectName=N'',@VoucherFromDate='2018-11-01',
@VoucherToDate='2018-11-30',
@ScheduleFromDate='',@ScheduleToDate=NULL,
@RequireFromDate=NULL,@RequireToDate=NULL,@SearchWhere=NULL,@Mode=0,@APKList=NULL


	
 ----*/
 
CREATE PROCEDURE POP2019
( 
  @DivisionID VARCHAR(50),
  @DivisionList VARCHAR(MAX),
  @UserID VARCHAR(50),
  @PageNumber INT,
  @PageSize INT,
  @VoucherNo VARCHAR(50),
  @OrderStatus NVARCHAR(3),
  @ObjectName NVARCHAR(250),
  @VoucherFromDate DATETIME,
  @VoucherToDate DATETIME,
  @ScheduleFromDate DATETIME,
  @ScheduleToDate DATETIME,
  @RequireFromDate DATETIME,
  @RequireToDate DATETIME,
  @SearchWhere NVARCHAR(Max) = NULL,--#NULL: Lọc nâng cao; =NULL: Lọc thường
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

	
SET @OrderBy = 'Temp.VoucherDate, Temp.VoucherNo'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@DivisionList, '') != ''
BEGIN
	IF @DivisionList != '%' SET @sWhere = @sWhere + ' T1.DivisionID IN ('''+@DivisionList+''')'
END
ELSE SET @sWhere = @sWhere + ' T1.DivisionID = '''+@DivisionList+''' ' 

SELECT TOP 1 @LanguageID = ISNULL(LanguageID,'') FROM AT14051 WITH (NOLOCK) WHERE UserID = @UserID

IF ISNULL(@SearchWhere,'') = ''
BEGIN
	IF ISNULL(@VoucherNo,'') != '' SET @sWhere = @sWhere + ' AND T1.VoucherNo LIKE ''%'+@VoucherNo+'%'' '
	
	IF ISNULL(@VoucherFromDate,'') != '' AND ISNULL(@VoucherToDate,'') != '' 
		SET @sWhere = @sWhere + ' AND T1.VoucherDate  BETWEEN '''+CONVERT(VARCHAR(10),@VoucherFromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@VoucherToDate,120)+''' '

	IF ISNULL(@ScheduleFromDate,'') != '' AND ISNULL(@ScheduleToDate,'') != '' 
		SET @sWhere = @sWhere + ' AND T2.ScheduleDate BETWEEN '''+CONVERT(VARCHAR(10),@ScheduleFromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@ScheduleToDate,120)+''' '
	
	IF ISNULL(@RequireFromDate,'') != '' AND ISNULL(@RequireToDate,'') != '' 
		SET @sWhere = @sWhere + ' AND T2.RequireDate  BETWEEN '''+CONVERT(VARCHAR(10),@RequireFromDate,120)+''' AND '''+CONVERT(VARCHAR(10),@RequireToDate,120)+''' '

	IF ISNULL(@ObjectName,'') != '' 
		SET @sWhere = @sWhere + ' AND A02.ObjectName LIKE N''%'+@ObjectName+'%'' '
	
	
	IF ISNULL(@OrderStatus,'') != '' SET @sWhere = @sWhere + ' AND T1.OrderStatus = '+@OrderStatus

END

IF @Mode = 0 ---Load form
BEGIN
	SET @sSQL = '
SELECT DISTINCT T1.*, A02.ObjectName, A05.UserName as EmployeeName, O01.Description AS OrderStatusName,A08.PaymentTermName,A25.PaymentName,A07.VoucherTypeName,
	CASE WHEN ISNULL(T1.OrderType,0) = 0 THEN N''Đơn đặt hàng cửa hàng'' ELSE N''Đơn đặt hàng khách hàng mua sỉ'' END  AS OrderTypeName
INTO #POP2015
FROM POT2015 T1 WITH (NOLOCK)
LEFT JOIN POT2016 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.APK = T2.APK_Master
LEFT JOIN AT1202 A02 WITH (NOLOCK) ON T1.ObjectID = A02.ObjectID AND A02.DivisionID IN (T1.DivisionID,''@@@'')
LEFT JOIN AT1405 A05 WITH (NOLOCK) ON T1.EmployeeID = A05.UserID
LEFT JOIN OT1101 O01 WITH (NOLOCK) ON T1.DivisionID = O01.DivisionID AND O01.OrderStatus = T1.OrderStatus and TypeID=''PO''
LEFT JOIN AT1208 A08 WITH (NOLOCK) ON  T1.DivisionID = A08.DivisionID AND T1.PaymentTermID= A08.PaymentTermID
LEFT JOIN  AT1205 A25 WITH (NOLOCK) ON T1.DivisionID = A08.DivisionID AND T1.PaymentID= A25.PaymentID
LEFT JOIN  AT1007 A07 WITH (NOLOCK) ON T1.DivisionID = A07.DivisionID AND T1.VoucherTypeID= A07.VoucherTypeID

WHERE '+@sWhere+'

SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM #POP2015 AS Temp
'+CASE WHEN ISNULL(@SearchWhere,'') != '' THEN @SearchWhere ELSE '' END+'
ORDER BY '+@OrderBy+' 
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

	PRINT(@sSQL)
	EXEC(@sSQL)

END

IF @Mode = 1 ---In phiếu
BEGIN
	SET @sSQL = '
	SELECT T1.*, T2.InventoryTypeID, T2.InventoryID, A02.InventoryName, T2.UnitID, T2.OrderQuantity, T2.OrderPrice, T2.OriginalAmount, T2.ConvertedAmount, 
		T2.Notes, T2.DepositAmount, T2.DepositConAmount, T2.DepositNotes, T2.RequireDate, T2.ScheduleDate, 
		T2.Ana01ID, T2.Ana02ID, T2.Ana03ID, T2.Ana04ID, T2.Ana05ID, T2.Ana06ID, T2.Ana07ID, T2.Ana08ID, T2.Ana09ID, T2.Ana10ID 
	FROM POT2015 T1 WITH (NOLOCK)
	LEFT JOIN POT2016 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID AND T1.APK = T2.APK_Master
	LEFT JOIN AT1302 A02 WITH (NOLOCK) ON T2.InventoryID = A02.InventoryID
	WHERE T1.DivisionID = '''+@DivisionID+'''
	AND T1.APK IN ('''+@APKList+''')'
		
	--PRINT(@sSQL)
	EXEC(@sSQL)
END









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
