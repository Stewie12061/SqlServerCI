IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[WMP2020]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[WMP2020]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO











 
 -- <Summary>
 ---- 
 ---- 
 -- <Param>
 ---- Load truy vấn phiếu nhập kho WMF2020 ERP9.0
 -- <Return>
 ---- 
 -- <Reference>
 ---- 
 -- <History>
 ----Created by Bảo Thy on 02/03/2018
 ----Modified by Kim Thư on 25/07/2018 - Thêm điều kiện lọc theo kỳ 
 ----Modified by Hoài Bảo on 13/12/2022 - Bổ sung load dữ liệu theo biến phân quyền Condition
 ----Modified by Hoài Thanh, Date 10/01/2023: Bổ sung luồng load dữ liệu từ dashboard
 ----Modified by Hoài Bảo, Date 15/02/2023: Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
 ----Modified by Tiến Thành, Date 29/03/2023: Sửa lỗi Không thể tìm kiếm theo loại chứng từ
 ----Modified by Hồng Thắm, Date 22/11/2023: Bổ sung luồng load dữ liệu khi in phiếu xuất kho kiêm phiếu giao hàng 
 /*-- <Example>
 	EXEC WMP2020 @DivisionID='VF',@DivisionList = '',@UserID='ASOFTADMIN', @PageNumber=1,@PageSize=25, @VoucherNo='', 
 	@FromDate='2018-07-01', @ToDate='2018-07-31', @IsDate = 0, @Period=N'07/2018'',''06/2018', @ObjectID=null, 
	@ImWarehouseID =null, @ExWarehouseID=null, @KindVoucherID=1, @Mode=0, @APKList=null, @SearchWhere=NULL
	EXEC WMP2020 @DivisionID, @DivisionList, @UserID, @PageNumber, @PageSize, @VoucherNo, @FromDate, @ToDate, @IsDate, @Period, @ObjectID, 
	@ImWarehouseID, @ExWarehouseID, @KindVoucherID, @Mode, @APKList, @SearchWhere
 ----*/
 
CREATE PROCEDURE WMP2020
( 
  @DivisionID VARCHAR(50) = '',
  @DivisionList VARCHAR(MAX) = '',
  @UserID VARCHAR(50) = '',
  @PageNumber INT = 1,
  @PageSize INT = 25,
  @VoucherTypeID VARCHAR(50) = '',
  @VoucherNo VARCHAR(50) = '',
  @FromDate DATETIME = NULL,
  @ToDate DATETIME = NULL,
  @IsPeriod TINYINT = 0, -- 0: theo ngày, 1: theo kỳ
  @PeriodList VARCHAR (100) = '', --Chọn trong DropdownChecklist Chọn kỳ
  @ObjectID NVARCHAR(50) = '',
  @ImWarehouseID VARCHAR(50) = '',
  @ExWarehouseID VARCHAR(50) = NULL,
  @SearchWhere NVARCHAR(Max) = NULL,
  @Mode TINYINT = 0, --0: load form, 1: in phiếu
  @KindvoucherID TINYINT = 1, --1: nhập, 2: xuất, 3: VCNB
  @APKList VARCHAR(MAX) = '',
  @Condition NVARCHAR(MAX) = '',
  @Type INT = 2, -- Type = 6: từ dashboard -> danh mục
  @InventoryTypeIDList NVARCHAR(MAX) = NULL, --nhóm hàng
  --@IsSearch TINYINT,
  --@IsSerialized TINYINT,
  @RelAPK NVARCHAR(250) = '',
  @RelTable NVARCHAR(250) = ''
) 
AS
DECLARE @sSQL NVARCHAR (MAX) = N'',
		@sSQL1 NVARCHAR (MAX) = N'',
        @sWhere NVARCHAR(MAX) = N'',
        @sWhere1 NVARCHAR(MAX) = N'',
        @sWhereDashboard NVARCHAR(MAX) = '',
        @TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N'',
		@LanguageID VARCHAR(50),
		@FromDateText NVARCHAR(20),
		@ToDateText NVARCHAR(20)

SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 111)
SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 111) + ' 23:59:59'
SET @OrderBy = 'Temp.VoucherNo DESC'
--IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@DivisionList, '') <> ''
	BEGIN
		IF @DivisionList <> '%' SET @sWhere = @sWhere + ' T1.DivisionID IN ('''+@DivisionList+''')'
		SET @sWhereDashboard = @sWhereDashboard + ' T1.DivisionID IN ('''+@DivisionList+''')'
	END
ELSE 
	SET @sWhere = @sWhere + ' T1.DivisionID = '''+@DivisionID+''' ' 

SELECT TOP 1 @LanguageID = ISNULL(LanguageID,'') FROM AT14051 WITH (NOLOCK) WHERE UserID = @UserID

-- Check Para FromDate và ToDate
IF @IsPeriod = 0
	BEGIN
		IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
			BEGIN
				SET @sWhere = @sWhere + ' AND (T1.VoucherDate >= ''' + @FromDateText + '''
												OR T1.VoucherDate >= ''' + @FromDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (T1.VoucherDate <= ''' + @ToDateText + ''' 
												OR T1.VoucherDate <= ''' + @ToDateText + ''')'
			END
		ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
			BEGIN
				SET @sWhere = @sWhere + ' AND (T1.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + '''
										OR T1.VoucherDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
			END
	END
ELSE IF @IsPeriod = 1 AND ISNULL(@PeriodList, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (SELECT FORMAT(T1.VoucherDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
		SET @sWhereDashboard = @sWhereDashboard + ' AND (SELECT FORMAT(T1.VoucherDate, ''MM/yyyy'')) IN ( ''' + @PeriodList + ''') '
	END

IF ISNULL(@SearchWhere,'') = ''
	BEGIN
		IF ISNULL(@VoucherTypeID,'') <> '' 
			SET @sWhere = @sWhere + ' AND T1.VoucherTypeID = '''+@VoucherTypeID+''' '
		IF ISNULL(@VoucherNo,'') <> '' 
			SET @sWhere = @sWhere + ' AND T1.VoucherNo LIKE ''%'+@VoucherNo+'%'' '
		IF ISNULL(@ObjectID,'') <> '' 
			SET @sWhere = @sWhere + ' AND (T1.ObjectID LIKE N''%'+@ObjectID+'%'' OR T4.ObjectName LIKE N''%'+@ObjectID+'%'') '
		IF ISNULL(@ImWarehouseID,'') <> '' 
			SET @sWhere = @sWhere + ' AND T1.WarehouseID = '''+@ImWarehouseID+''' '
		IF ISNULL(@ExWarehouseID,'') <> '' 
			SET @sWhere = @sWhere + ' AND T1.WarehouseID = '''+@ExWarehouseID+''' '
		--IF ISNULL(@FromDate,'') <> '' SET @sWhere = @sWhere + '
		--AND T1.VoucherDate >= '''+CONVERT(VARCHAR(10),@FromDate,120)+''' '
		--IF ISNULL(@ToDate,'') <> '' SET @sWhere = @sWhere + '
		--AND T1.VoucherDate <= '''+CONVERT(VARCHAR(10),@ToDate,120)+''' '
		--AND (T1.ImWarehouseID LIKE ''%'+@ImWarehouseID+'%'' OR T2.WarehouseName LIKE ''%'+@ImWarehouseID+'%'')'
		--IF ISNULL(@KindvoucherID,0) = 3 AND ISNULL(@ExWarehouseID,'') <> '' 
		--SET @sWhere = @sWhere + '
		--AND T1.ExWarehouseID = '''+@ExWarehouseID+''' '
		--AND (T1.ExWarehouseID LIKE ''%'+@ExWarehouseID+'%'' OR T6.WarehouseName LIKE ''%'+@ExWarehouseID+'%'')'
	END

IF ISNULL(@Condition, '') != ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (ISNULL(T1.EmployeeID, '''') IN (''' + @Condition + ''' ) OR ISNULL(T1.CreateUserID, '''') IN (''' + @Condition + ''' ))'
		SET @sWhereDashboard = @sWhereDashboard + ' AND (ISNULL(T1.EmployeeID, '''') IN (''' + @Condition + ''' ) OR ISNULL(T1.CreateUserID, '''') IN (''' + @Condition + ''' ))'
	END

IF @Mode = 0 ---Load form
	BEGIN
		IF @Type = 6
			BEGIN
				IF ISNULL(@InventoryTypeIDList, '') != ''
					SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(A02.InventoryTypeID, '''') IN ('''+ @InventoryTypeIDList +''') '
				IF @KindvoucherID = 1
					SET @sWhereDashboard = @sWhereDashboard + ' AND T1.KindVoucherID IN (1,5,7,9,15,17) '
				ELSE IF @KindvoucherID = 2
					SET @sWhereDashboard = @sWhereDashboard + ' AND T1.KindVoucherID IN (2,4,6,8,10,14,20) '
				SET @sWhere1 = 'WHERE '+@sWhereDashboard+' '
			END
		ELSE
		BEGIN
			IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
			BEGIN
				SET @sWhere1 = 
				CASE
					WHEN @RelTable = 'OT3001' THEN 'LEFT JOIN AT2007 C1 WITH (NOLOCK) ON C1.VoucherID = T1.VoucherID 
													INNER JOIN OT3002 C3 WITH (NOLOCK) ON C1.InheritTransactionID = C3.TransactionID AND C1.InheritTableID = ''OT3001''
													INNER JOIN ' +@RelTable+ ' C2 WITH (NOLOCK) ON C2.DivisionID IN (''@@@'', C3.DivisionID) AND C2.POrderID = C3.POrderID
									  WHERE C2.APK = ''' +@RelAPK+ ''' AND T1.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') '
					ELSE @sWhere1
				END
			END
			ELSE
				IF @KindvoucherID <> 0
					SET @sWhere1 = 'WHERE '+@sWhere+' AND T1.KindVoucherID = '+STR(@KindvoucherID)+' '
		END
		SET @sSQL = '
			SELECT DISTINCT T1.APK, T1.DivisionID, T1.TranMonth, T1.TranYear, T1.VoucherNo,  T1.VoucherID, T1.VoucherDate, T1.VoucherTypeID, T1.Description, T1.KindVoucherID, T1.WarehouseID, 
			T2.WarehouseName AS ImWarehouseName, 
			(CASE WHEN T1.KindVoucherID = 3 THEN T1.WareHouseID2 ELSE T6.WarehouseName END) AS ExWarehouseName, 
			T2.IsLocation, T1.InventoryTypeID, T3.InventoryTypeName, T1.ObjectID, T4.ObjectName, T1.EmployeeID, T5.FullName AS EmployeeName,
			T1.CreateUserID, T1.CreateDate, T1.LastModifyUserID, SUM(A07.ConvertedAmount) AS ConvertedAmount
			INTO #WMP2010
			FROM AT2006 T1 WITH (NOLOCK)
			LEFT JOIN AT1303 T2 WITH (NOLOCK) ON T1.WarehouseID = T2.WareHouseID AND T2.DivisionID IN (T1.DivisionID,''@@@'')
			LEFT JOIN AT1301 T3 WITH (NOLOCK) ON T1.InventoryTypeID = T3.InventoryTypeID AND T3.DivisionID IN (T1.DivisionID,''@@@'')
			LEFT JOIN AT1202 T4 WITH (NOLOCK) ON T1.ObjectID = T4.ObjectID AND T4.DivisionID IN (T1.DivisionID,''@@@'')
			LEFT JOIN AT1103 T5 WITH (NOLOCK) ON T1.EmployeeID = T5.EmployeeID AND T5.DivisionID IN (T1.DivisionID,''@@@'')
			LEFT JOIN AT1303 T6 WITH (NOLOCK) ON T1.WarehouseID = T6.WareHouseID AND T6.DivisionID IN (T1.DivisionID,''@@@'')
			LEFT JOIN AT2007 A07 WITH (NOLOCK) ON T1.VoucherID = A07.VoucherID
			LEFT JOIN AT1302 A02 WITH (NOLOCK) ON A07.InventoryID = A02.InventoryID
			'+@sWhere1+'
			GROUP BY T1.APK, T1.DivisionID, T1.TranMonth, T1.TranYear, T1.VoucherNo,  T1.VoucherID, T1.VoucherDate, T1.VoucherTypeID, T1.Description, T1.KindVoucherID, T1.WarehouseID, T2.WarehouseName, 
			T6.WarehouseName, T2.IsLocation, T1.InventoryTypeID, T3.InventoryTypeName, T1.ObjectID, T4.ObjectName, T1.EmployeeID, T5.FullName,
			T1.CreateUserID, T1.CreateDate, T1.LastModifyUserID, T1.WareHouseID2

			DECLARE @Count INT
			SELECT @Count = COUNT(*) FROM #WMP2010

			SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow, * FROM #WMP2010 AS Temp
			'+CASE WHEN ISNULL(@SearchWhere,'') <> '' THEN @SearchWhere ELSE '' END+'
			ORDER BY '+@OrderBy+' 
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

			PRINT(@sSQL)
			EXEC(@sSQL)
	END

IF @Mode = 1 ---In phiếu
	BEGIN
		SET @sSQL = '
			SELECT W16.APK AS APKMaster, W17.APK AS APKDetail, W16.DivisionID, W16.TranMonth, W16.TranYear, W16.VoucherNo, W16.VoucherID, W16.VoucherDate, W16.VoucherTypeID, W16.Description, W16.KindVoucherID, W16.WarehouseID, T15.WarehouseName As ImWarehouseName, 
			W16.WarehouseID2, AT1303.WarehouseName AS ExWarehouseName, T15.IsLocation, W17.Notes,
			W16.InventoryTypeID, T16.InventoryTypeName, W16.ObjectID, T17.ObjectName, W16.EmployeeID, T18.FullName AS EmployeeName, W16.CreateUserID,
			W16.CreateDate, W16.LastModifyUserID, W16.RefNo01, W16.RefNo02, W17.InventoryID, T2.InventoryName, W17.UnitID, AT1304.UnitName, W17.UnitPrice, W17.ActualQuantity, W17.OriginalAmount, 
			W17.ConvertedQuantity, W17.ConvertedPrice, ISNULL(W17.ConvertedUnitID,W17.UnitID) as ConvertedUnitID, ISNULL(T14.UnitName, AT1304.UnitName) AS ConvertedUnitName, W17.ConvertedAmount, 
			W17.ExchangeRate, W17.CurrencyID, W17.InheritTableID,
			W17.Ana01ID, W17.Ana02ID, W17.Ana03ID, W17.Ana04ID, W17.Ana05ID, W17.Ana06ID, W17.Ana07ID, W17.Ana08ID, W17.Ana09ID, W17.Ana10ID,
			T3.AnaName AS Ana01Name, T4.AnaName AS Ana02Name, T5.AnaName AS Ana03Name, T6.AnaName AS Ana04Name, T7.AnaName AS Ana05Name, T8.AnaName AS Ana06Name, T9.AnaName AS Ana07Name,
			T10.AnaName AS Ana08Name, T11.AnaName AS Ana09Name, T12.AnaName AS Ana10Name, --W18.LocationID, W18.SerialNo, W18.IMEINo, W18.APK,
			W17.OrderID, T17.Address, T17.VATNo, W16.ContactPerson, W16.DeliveryEmployeeID, W16.RDAddress, O19.OrderDate, W16.SParameter01, W16.SParameter02, W16.SParameter03
			FROM AT2006 W16 WITH (NOLOCK)
			LEFT JOIN AT2007 W17 WITH (NOLOCK) ON W16.DivisionID = W17.DivisionID AND W16.VoucherID = W17.VoucherID
			--LEFT JOIN WMT2008 W18 WITH (NOLOCK) ON W16.DivisionID = W17.DivisionID AND W17.APK = W18.APKDetail
			LEFT JOIN AT1302 T2 WITH (NOLOCK) ON W17.InventoryID = T2.InventoryID AND T2.DivisionID IN (W17.DivisionID,''@@@'')'

		SET @sSQL1 = '
			LEFT JOIN AT1011 T3 WITH (NOLOCK) ON W17.Ana01ID = T3.AnaID AND T3.DivisionID IN (W17.DivisionID,''@@@'') AND T3.AnaTypeID = ''A01''
			LEFT JOIN AT1011 T4 WITH (NOLOCK) ON W17.Ana02ID = T4.AnaID AND T4.DivisionID IN (W17.DivisionID,''@@@'') AND T4.AnaTypeID = ''A02''
			LEFT JOIN AT1011 T5 WITH (NOLOCK) ON W17.Ana03ID = T5.AnaID AND T5.DivisionID IN (W17.DivisionID,''@@@'') AND T5.AnaTypeID = ''A03''
			LEFT JOIN AT1011 T6 WITH (NOLOCK) ON W17.Ana04ID = T6.AnaID AND T6.DivisionID IN (W17.DivisionID,''@@@'') AND T6.AnaTypeID = ''A04''
			LEFT JOIN AT1011 T7 WITH (NOLOCK) ON W17.Ana05ID = T7.AnaID AND T7.DivisionID IN (W17.DivisionID,''@@@'') AND T7.AnaTypeID = ''A05''
			LEFT JOIN AT1011 T8 WITH (NOLOCK) ON W17.Ana06ID = T8.AnaID AND T8.DivisionID IN (W17.DivisionID,''@@@'') AND T8.AnaTypeID = ''A06''
			LEFT JOIN AT1011 T9 WITH (NOLOCK) ON W17.Ana07ID = T9.AnaID AND T9.DivisionID IN (W17.DivisionID,''@@@'') AND T9.AnaTypeID = ''A07''
			LEFT JOIN AT1011 T10 WITH (NOLOCK) ON W17.Ana08ID = T10.AnaID AND T10.DivisionID IN (W17.DivisionID,''@@@'') AND T10.AnaTypeID = ''A08''
			LEFT JOIN AT1011 T11 WITH (NOLOCK) ON W17.Ana09ID = T11.AnaID AND T11.DivisionID IN (W17.DivisionID,''@@@'') AND T11.AnaTypeID = ''A09''
			LEFT JOIN AT1011 T12 WITH (NOLOCK) ON W17.Ana10ID = T12.AnaID AND T12.DivisionID IN (W17.DivisionID,''@@@'') AND T12.AnaTypeID = ''A10''
			LEFT JOIN AT1309 T13 WITH (NOLOCK) ON T13.InventoryID = W17.InventoryID and W17.ConvertedUnitID = T13.UnitID and T13.DivisionID IN (W17.DivisionID,''@@@'')
			LEFT JOIN AT1304 T14 WITH (NOLOCK) ON T14.UnitID =  ISNULL(W17.ConvertedUnitID,'''') and T14.DivisionID IN (W17.DivisionID,''@@@'')
			LEFT JOIN AT1304 WITH (NOLOCK) on AT1304.UnitID  = W17.UnitID and AT1304.DivisionID IN (W17.DivisionID, ''@@@'')
			LEFT JOIN AT1303 T15 WITH (NOLOCK) ON W16.WarehouseID = T15.WareHouseID AND T15.DivisionID IN (W16.DivisionID,''@@@'')
			LEFT JOIN AT1303 WITH (NOLOCK) ON W16.WarehouseID2 = AT1303.WareHouseID AND AT1303.DivisionID IN (W16.DivisionID,''@@@'')
			LEFT JOIN AT1301 T16 WITH (NOLOCK) ON W16.InventoryTypeID = T16.InventoryTypeID AND T16.DivisionID IN (W16.DivisionID,''@@@'')
			LEFT JOIN AT1202 T17 WITH (NOLOCK) ON W16.ObjectID = T17.ObjectID AND T17.DivisionID IN (W16.DivisionID,''@@@'')
			LEFT JOIN AT1103 T18 WITH (NOLOCK) ON W16.EmployeeID = T18.EmployeeID AND T18.DivisionID IN (W16.DivisionID,''@@@'')
			LEFT JOIN OT2001 O19 WITH (NOLOCK) ON W17.OrderID = O19.VoucherNo AND O19.DivisionID IN (W16.DivisionID,''@@@'')
			--LEFT JOIN WMT0099 WITH (NOLOCK) ON W16.IsSerialized = WMT0099.ID AND WMT0099.CodeMaster = ''Disabled''
			WHERE W16.DivisionID = '''+@DivisionID+'''
			AND W16.KindVoucherID = '+STR(@KindvoucherID)+'
			AND W16.VoucherID IN ('''+@APKList+''')'

		--PRINT(@sSQL)
		--PRINT(@sSQL1)
		EXEC(@sSQL+@sSQL1)

	END














GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
