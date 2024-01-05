IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid Form SOF2000 Danh muc đơn hàng bán
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Phan thanh hoàng vũ, Date: 30/12/2015
---- Modified by Tiểu Mai on 22/04/2016: Bổ sung cho ANGEL
---- Modified by Thị Phượng on 14/12/2016 Bổ sung lấy thêm trường customize HT 
---- Modified by Thị Phượng on 22/12/2016 Bổ sung lấy trường isHistory 
--- Modify by Thị Phượng, Date 08/05/2017: Bổ sung phân quyền
--- Modify by Thị Phượng, Date 06/07/2017: Chỉnh sửa cải tiến tốc độ, bỏ các vấn đề của HT
--- Modify by Thị Phượng, Date 30/08/2017: Thay đổi cách sắp xếp order by theo CreateDate
----Editted by: Phan thanh hoàng Vũ, Date: 01/09/2017 Sắp xếp thứ tự giảm dần thao ngày (Record mới nhất sẽ load lên đầu tiên)
--- Modify by Thị Phượng, Date 08/11/2017: Bổ sung thêm xử lý search nâng cao
--- Modify by Tra Giang, Date 28/02/2019:Kiêm tra phân quyền người dùng (Customize ATTOM)
--- Modify by Kiều Nga, Date 14/04/2020: Bổ sung customize CBD
--- Modify by Kiều Nga, Date 18/01/2021: Fix lỗi load tình trạng duyệt
--- Modify by Đình Hòa, Date 29/03/2021: Thêm tham số @IsCollectedMoney(CBD)
--- Modify by Lê Hoàng, Date 07/10/2021: Bổ sung OrderType = 0 để lấy đơn hàng bán
--- Modify by Văn Tài,	Date 19/11/2021: Check box kiểm tra đã xuất hóa đơn từ T.
--- Modify by Văn Tài,	Date 25/11/2021: Fix lỗi kiểm tra cờ Xuất hóa đơn từ T.
--- Modify by Văn Tài,	Date 17/01/2022: Bổ sung kiểm tra xuất hóa đơn từ WM.
--- Modify by Minh Hiếu,Date 10/02/2022: Bổ sung trường SalesManID.
--- Modify by Hoài Bảo, Date 15/04/2022: Cập nhật điều kiện search theo ngày, theo kỳ
--- Modify by Nhựt Trường, Date 26/07/2022: ANGEL - Bổ sung trường EmployeeID, SalesManID khi gọi store SOP20001_AG.
--- Modify by Văn Tài,	Date 05/11/2022: Bổ sung kiểm tra xuất hóa đơn từ WM. Nhưng phải tồn tại hóa đơn bán hàng kế thừa xuất kho.
--- Modify by Hoài Thanh, Date 10/01/2023: Bổ sung luồng load dữ liệu từ dashboard
----Modify by Hoài Bảo, Date 13/02/2023: Bổ sung luồng load dữ liệu từ màn hình truy vấn ngược
----Modify by Tiến Thành, Date 20/04/2023: [2023/04/IS/0019] - 5.Đổi tổng giá trị đơn = Tổng tiền - trừ chiết khấu + VAT
----Modify by Tiến Thành, Date 20/04/2023: [2023/04/IS/0019] - 3.Bổ sung lọc đơn hàng sỉ/lẻ bằng IsWholeSale
----Modify by Nhật Thanh, Date 21/06/2023: Nếu là mặt hàng khuyến mãi thì cộng âm vào tổng giá trị đơn hàng
-- <Example>
/* 
EXEC SOP20001 'CAN','','','','','','','','', '','' , '', 1, '2015-01-01', '2017-12-30', '01/2017'',''09/2017' 
,'USER01',N'ASOFTADMIN'',''USER08',1,200, 0, N' where OrderDate between ''2016-11-07'' and ''2017-11-07'' '
*/
----
CREATE PROCEDURE SOP20001 ( 
        @DivisionID VARCHAR(50) = '',  --Biến môi trường
		@DivisionIDList NVARCHAR(2000) = '',  --Chọn trong DropdownChecklist DivisionID
        @VoucherNo  NVARCHAR(250) = '',
		@AccountID  NVARCHAR(250) = '',
		@VATAccountID  NVARCHAR(250) = '',
		@VoucherTypeID  NVARCHAR(250) = '',
		@RouteID  NVARCHAR(250) = '',
		@DeliveryEmployeeID  NVARCHAR(250) = '',
		@EmployeeID  NVARCHAR(250) = '',
		@SalesManID  NVARCHAR(250) = '',
		@IsPrinted  NVARCHAR(250) = '',
		@OrderStatus  NVARCHAR(250) = '',
		@IsConfirmName nvarchar(50) = '',
		@IsDate TINYINT = 0,--0: theo ngày, 1: Theo kỳ
		@FromDate DATETIME = NULL,
		@ToDate DATETIME = NULL,
		@Period NVARCHAR(4000) = '', --Chọn trong DropdownChecklist Chọn kỳ
		@UserID  VARCHAR(50) = '',
		@ConditionSOrderID  NVARCHAR(MAX) = '',
		@PageNumber INT = 1,
		@PageSize INT = 25,
		@IsHistory INT = 0,
		@SearchWhere NVARCHAR(MAX) = NULL,
		@IsWholeSale TINYINT = 0, --0: Đơn hàng sỉ, 1: Lẻ
		@IsCollectedMoney VARCHAR(50) = '',
		@Type INT = 2, -- Type = 6: từ dashboard -> danh mục
		@IsReOrder INT = 0, --1: lấy các đơn lặp lại
		@StatusIDList NVARCHAR(250) = NULL,
		@EmployeeIDList NVARCHAR(MAX) = NULL,
		@CustomerIDList NVARCHAR(MAX) = NULL,
		@InventoryIDList NVARCHAR(MAX) = NULL,
		@RelAPK NVARCHAR(250) = '',
		@RelTable NVARCHAR(250) = ''
) 
AS 
DECLARE @CustomerName INT
CREATE Table #CustomerName (CustomerName INT, ImportExcel int)
INSERT #CustomerName EXEC AP4444
SET @CustomerName = (SELECT TOP 1 CustomerName FROM #CustomerName)

IF @CustomerName IN ( 57) ------ ANGEL
	EXEC SOP20001_AG @DivisionID, @VoucherNo, @AccountID, @VoucherTypeID, @OrderStatus, @IsDate, @FromDate, @ToDate, @Period, @UserID, @EmployeeID, @SalesManID, @PageNumber, @PageSize
ELSE
IF @CustomerName IN (  98) ------  ATTOM
	EXEC SOP20001_AT @DivisionID, @VoucherNo, @AccountID, @VoucherTypeID, @OrderStatus, @IsDate, @FromDate, @ToDate, @Period, @UserID, @PageNumber, @PageSize, @IsWholeSale
ELSE
IF @CustomerName IN (130) ------  CBD
	EXEC SOP20001_CBD @DivisionID,@DivisionIDList,@VoucherNo,@AccountID,@VATAccountID,@VoucherTypeID,@RouteID,@DeliveryEmployeeID,@EmployeeID,@IsPrinted,@OrderStatus,@IsConfirmName,@IsDate,@FromDate,@ToDate,@Period,@UserID,@ConditionSOrderID,@PageNumber,@PageSize,@IsHistory,@SearchWhere,@IsWholeSale,@IsCollectedMoney
ELSE
BEGIN
	DECLARE @sSQL NVARCHAR (MAX),
			@sSQL2 NVARCHAR (MAX),
			@sWhere NVARCHAR(MAX),
			@sWhere1 NVARCHAR(MAX),
			@sWhereDashboard NVARCHAR(MAX) = '1 = 1 AND OT2001.OrderType = 0 ',
			@OrderBy NVARCHAR(500),
			@TotalRow NVARCHAR(50),
			@FromDateText NVARCHAR(20),
			@ToDateText NVARCHAR(20),
			@GroupID NVARCHAR(100) = '',
			@sWhereUser NVARCHAR(500) = 'OT2001.CreateUserID = ''' + @UserID + ''' OR OT2001.EmployeeID = ''' + @UserID + ''' OR OT2001.SalesManID = ''' + @UserID + ''' '

	SELECT @GroupID = GroupID FROM AT1402 where UserID = @UserID
	IF @GroupID = 'SELLIN' OR @GroupID = 'SELLOUT'
		SET @sWhereUser = @sWhereUser + 'OR OT2001.Ana01ID = ''' + @UserID + ''' '
	IF @GroupID = 'NPP' 
		SET @sWhereUser = @sWhereUser + 'OR OT2001.DealerID = ''' + @UserID + ''' '
	IF @GroupID = 'NVSU' OR  @GroupID = 'SUP'
		SET @sWhereUser = @sWhereUser + 'OR OT2001.Ana02ID = ''' + @UserID + ''' '
	IF @GroupID = 'ASM' 
		SET @sWhereUser = @sWhereUser + 'OR OT2001.Ana03ID = ''' + @UserID + ''' '

	SET @sWhere='1 = 1 AND OT2001.OrderType = 0 '     
	SET @OrderBy = ' M.CreateDate DESC, M.OrderDate, M.VoucherNo'   
	SET @FromDateText = CONVERT(NVARCHAR(20), @FromDate, 101)
	SET @ToDateText = CONVERT(NVARCHAR(20), @ToDate, 101) + ' 23:59:59'
	IF isnull(@SearchWhere,'') =''
		Begin
			IF @IsDate = 0
				BEGIN
					--SET @sWhere = @sWhere + '  AND CONVERT(VARCHAR(10),OT2001.OrderDate,21) BETWEEN '''+ CONVERT(VARCHAR(10),@FromDate,21)+''' AND '''+CONVERT(VARCHAR(10),@ToDate,21)+''''
					IF(ISNULL(@FromDate,'') != '' AND ISNULL(@ToDate,'') = '' )
						BEGIN
							SET @sWhere = @sWhere + ' AND (OT2001.OrderDate >= ''' + @FromDateText + ''')'
						END
					ELSE IF(ISNULL(@FromDate,'') = '' AND ISNULL(@ToDate,'') != '')
						BEGIN
							SET @sWhere = @sWhere + ' AND (OT2001.OrderDate <= ''' + @ToDateText + ''')'
						END
					ELSE IF(ISNULL(@FromDate, '') != '' AND ISNULL(@ToDate, '') != '')
						BEGIN
							SET @sWhere = @sWhere + ' AND (OT2001.OrderDate BETWEEN ''' + @FromDateText + ''' AND ''' + @ToDateText + ''') '
						END
				END
			IF @IsDate = 1 AND ISNULL(@Period, '') != ''
				BEGIN
					SET @sWhere = @sWhere + ' AND (CASE WHEN OT2001.TranMonth <10 THEN ''0''+rtrim(ltrim(str(OT2001.TranMonth)))+''/''+ltrim(Rtrim(str(OT2001.TranYear))) 
								ELSE rtrim(ltrim(str(OT2001.TranMonth)))+''/''+ltrim(Rtrim(str(OT2001.TranYear))) END) in ('''+@Period +''')'
					SET @sWhereDashboard = @sWhereDashboard + ' AND (CASE WHEN OT2001.TranMonth <10 THEN ''0''+rtrim(ltrim(str(OT2001.TranMonth)))+''/''+ltrim(Rtrim(str(OT2001.TranYear))) 
								ELSE rtrim(ltrim(str(OT2001.TranMonth)))+''/''+ltrim(Rtrim(str(OT2001.TranYear))) END) in ('''+@Period +''')'
				END
			--Check Para DivisionIDList null then get DivisionID 
			IF @DivisionIDList IS NULL or @DivisionIDList = ''
				SET @sWhere = @sWhere + 'and OT2001.DivisionID = '''+ @DivisionID+''''
			Else 
				BEGIN
					SET @sWhere = @sWhere + 'and OT2001.DivisionID IN ('''+@DivisionIDList+''')'
					SET @sWhereDashboard = @sWhereDashboard + 'and OT2001.DivisionID IN ('''+@DivisionIDList+''')'
				END
				
			IF ISNULL(@IsWholeSale, 0) != 0
				SET @sWhere=  @sWhere + 'AND ISNULL(OT2001.IsWholeSale, 0)=' + CONVERT(NVARCHAR, @IsWholeSale)
			IF Isnull(@VoucherNo, '') != '' 
				SET @sWhere = @sWhere + ' AND ISNULL(OT2001.VoucherNo, '''') LIKE N''%'+@VoucherNo+'%'' '
			IF Isnull(@AccountID, '') != ''
				SET @sWhere = @sWhere + ' AND (ISNULL(OT2001.ObjectID, '''') LIKE N''%'+@AccountID+'%''  or ISNULL(OT2001.ObjectName, '''') LIKE N''%'+@AccountID+'%'')'
			IF Isnull(@VoucherTypeID, '') != '' 
				SET @sWhere = @sWhere + ' AND ISNULL(OT2001.VoucherTypeID, '''') LIKE N''%'+@VoucherTypeID+'%'' '
			IF Isnull(@EmployeeID, '') != '' 
				SET @sWhere = @sWhere + ' AND (ISNULL(OT2001.EmployeeID, '''') LIKE N''%'+@EmployeeID+'%''  or ISNULL(A03.FullName, '''') LIKE N''%'+@EmployeeID+'%'')'
			IF Isnull(@SalesManID, '') != '' 
				SET @sWhere = @sWhere + ' AND (ISNULL(OT2001.SalesManID, '''') LIKE N''%'+@SalesManID+'%''  or ISNULL(A13.FullName, '''') LIKE N''%'+@SalesManID+'%'')'	
			IF Isnull(@OrderStatus, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(OT2001.OrderStatus, '''') LIKE N''%'+@OrderStatus+'%'' '
			IF Isnull(@IsConfirmName, '') != ''
				SET @sWhere = @sWhere + ' AND ISNULL(OT2001.IsConfirm, 0)='+@IsConfirmName
			IF Isnull(@ConditionSOrderID, '') != ''
				BEGIN
					SET @sWhere = @sWhere + ' AND ('+ @sWhereUser +' Or ISNULL(OT2001.EmployeeID, OT2001.CreateUserID) in ('''+@ConditionSOrderID+'''))'
					SET @sWhereDashboard = @sWhereDashboard + ' AND ('+ @sWhereUser +' Or ISNULL(OT2001.EmployeeID, OT2001.CreateUserID) in ('''+@ConditionSOrderID+'''))'
				END
			IF Isnull(@StatusIDList, '') != ''
				SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(OT2001.OrderStatus, '''') in ('''+@StatusIDList+''')'
			IF Isnull(@EmployeeIDList, '') != ''
				SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(OT2001.EmployeeID, '''') in ('''+@EmployeeIDList+''')'
			IF Isnull(@CustomerIDList, '') != ''
				SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(OT2001.ObjectID, '''') in ('''+@CustomerIDList+''')'
			IF Isnull(@InventoryIDList, '') != ''
				SET @sWhereDashboard = @sWhereDashboard + ' AND ISNULL(A.InventoryID, '''') in ('''+@InventoryIDList+''')'

		End
	IF isnull(@SearchWhere,'') !=''
		Begin
			SET  @sWhere='1 = 1'
		End
	IF @Type = 6
		BEGIN
			IF @IsReOrder = 1
				SET @sWhere1 = 'WHERE ObjectID In (Select ObjectID From OT2001 M With (NOLOCK)  where '+@sWhereDashboard+' Group by ObjectID HAVING COUNT(*) > 1)'
			ELSE 
				SET @sWhere1 = 'WHERE '+@sWhereDashboard+' '
		END
	ELSE --IF @Type = 2
	BEGIN
		IF (ISNULL(@RelAPK, '') != '' AND ISNULL(@RelTable, '') != '')
		BEGIN
			SET @sWhere1 = 
			CASE
				WHEN @RelTable = 'POST0011' THEN 'INNER JOIN ' +@RelTable+ ' C1 WITH (NOLOCK) ON C1.MemberID = OT2001.ObjectID 
											WHERE C1.APK = ''' +@RelAPK+ '''
											AND OT2001.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') '
				WHEN @RelTable = 'AT1020' THEN 'INNER JOIN ' +@RelTable+ ' C1 WITH (NOLOCK) ON C1.ContractNo = OT2001.ContractNo 
											WHERE C1.APK = ''' +@RelAPK+ '''
											AND OT2001.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') '
				WHEN @RelTable = 'OT2003' THEN 'INNER JOIN ' +@RelTable+ ' C1 WITH (NOLOCK) ON C1.SOrderID = OT2001.SOrderID 
											WHERE C1.APK = ''' +@RelAPK+ '''
											AND OT2001.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') '
				WHEN @RelTable = 'AT2006' THEN 'LEFT JOIN AT2007 C1 WITH (NOLOCK) ON C1.InheritTransactionID = A.TransactionID AND C1.InheritTableID = ''OT2001''
												INNER JOIN ' +@RelTable+ ' C2 WITH (NOLOCK) ON C2.VoucherID = C1.VoucherID 
											WHERE C2.APK = ''' +@RelAPK+ ''' AND OT2001.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') '
				WHEN @RelTable = 'WMT2006' THEN 'LEFT JOIN AT2007 C1 WITH (NOLOCK) ON C1.SOrderID = A.SOrderID AND C1.InheritTableID = ''OT2001''
												 INNER JOIN AT2006 C2 WITH (NOLOCK) ON C2.VoucherID = C1.VoucherID 
											WHERE C2.APK = ''' +@RelAPK+ ''' AND OT2001.DivisionID IN (''' +@DivisionID+ ''', ''@@@'') '
				ELSE 'WHERE '+@sWhere+' '
			END
		END
		ELSE
			SET @sWhere1 = 'WHERE '+@sWhere+' '
	END

	SET @sSQL = N'
		SELECT OT2001.APK, OT2001.DivisionID
		, OT2001.SOrderID, OT2001.VoucherTypeID, OT2001.VoucherNo
		, OT2001.OrderDate
		, OT2001.ObjectID, OT2001.ObjectName 
		, OT2001.DeliveryAddress, OT2001.Notes, OT2001.Disabled, OT2001.OrderStatus, AT0099.Description as OrderStatusName
		, OT2001.CreateDate, OT2001.CreateUserID, OT2001.LastModifyUserID, OT2001.LastModifyDate, OT2001.TranMonth, OT2001.TranYear, A03.FullName EmployeeID
		, OT2001.SalesManID, OT2001.ShipDate, A13.FullName AS SalesManName,
		Case when OT2001.OrderStatus = 1 then 1 else OT2001.Status end AS IsConfirm, Case when OT2001.OrderStatus = 1 then B1.Description else  B.Description end as IsConfirmName, OT2001.DescriptionConfirm
		, OT2001.ConfirmDate, OT2001.ConfirmUserID
		, OT2001.IsInvoice
		, Sum(CASE WHEN A02.IsDiscount = 1 THEN -ISNULL(A.ConvertedAmount,0) ELSE ISNULL(A.ConvertedAmount,0) END) 
			- SUM(ISNULL(A.DiscountAmount,0)) + SUM(ISNULL(A.VATConvertedAmount,0)) as TotalAmount
		, (
			SELECT TOP 1 1 
			FROM  AT9000 AT90 WITH (NOLOCK)
			LEFT JOIN OT2002 OT02  WITH (NOLOCK) ON OT02.DivisionID = AT90.DivisionID 
														AND OT02.SOrderID = OT2001.SOrderID
														AND OT02.SOrderID = AT90.MOrderID
			LEFT JOIN OT2002 OT03  WITH (NOLOCK) ON OT03.DivisionID = AT90.DivisionID 
														AND OT03.SOrderID = OT2001.SOrderID
			LEFT JOIN AT2007 AT07 WITH (NOLOCK) ON AT07.DivisionID = AT90.DivisionID
														AND AT07.VoucherID = AT90.WOrderID
														AND AT07.MOrderID = OT03.SOrderID
			WHERE AT90.DivisionID = OT2001.DivisionID
					AND 
						(
							(
								AT90.TransactionTypeID = ''T04''
								AND ISNULL(AT90.MOrderID, '''') <> ''''
								AND OT02.SOrderID = AT90.MOrderID
							)
							OR
							(
								AT90.TransactionTypeID = ''T04''
								AND ISNULL(AT90.WOrderID, '''') <> ''''
								AND ISNULL(AT07.MOrderID, '''') <> ''''
							)
						) -- select AnaTypeID From OT1002
			) AS IsExportOrder, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.DealerID, OT1.AnaName
		Into #TemOT2001
		FROM OT2001 With (NOLOCK) 
		Inner join OT2002 A  With (NOLOCK) ON A.DivisionID = OT2001.DivisionID and A.SOrderID = OT2001.SOrderID
					Left join AT1103 A03 With (NOLOCK) on OT2001.EmployeeID = A03.EmployeeID
					Left join AT1103 A13 With (NOLOCK) on OT2001.SalesManID = A13.EmployeeID
					Left join AT0099 With (NOLOCK) on Convert(varchar, OT2001.OrderStatus) = AT0099.ID and AT0099.CodeMaster = ''AT00000003''
					Left join OOT0099  B With (NOLOCK) on isnull(OT2001.Status,0) = B.ID and B.CodeMaster = ''Status'' and B.Disabled = 0
					Left join OOT0099  B1 With (NOLOCK) on 1 = B1.ID and B1.CodeMaster = ''Status'' and B1.Disabled = 0
					LEFT JOIN OT1002 OT1 ON OT1.AnaID = OT2001.Ana01ID AND OT2001.DivisionID = OT1.DivisionID AND AnaTypeID = ''S01''
					LEFT JOIN AT1302 A02 With (NOLOCK) on A02.DivisionID IN (''@@@'',OT2001.DivisionID) AND A02.InventoryID = A.InventoryID
		'+@sWhere1+'
		Group by OT2001.APK, OT2001.DivisionID, OT2001.SOrderID, OT2001.VoucherTypeID, OT2001.VoucherNo, OT2001.OrderDate
		, OT2001.ObjectID, OT2001.ObjectName , OT2001.DeliveryAddress, OT2001.Notes, OT2001.Disabled, OT2001.OrderStatus, AT0099.Description
		, OT2001.CreateDate, OT2001.CreateUserID, OT2001.LastModifyUserID, OT2001.LastModifyDate, OT2001.TranMonth, OT2001.TranYear, A03.FullName 
		, OT2001.SalesManID, OT2001.ShipDate,OT2001.Status, B.Description,B1.Description, OT2001.DescriptionConfirm, A13.FullName
		, OT2001.ConfirmDate, OT2001.ConfirmUserID, OT2001.IsInvoice, OT2001.Ana02ID, OT2001.Ana03ID, OT2001.DealerID, OT1.AnaName

		Declare @Count int
		Select @Count = Count(OrderStatus) From  #TemOT2001
		'+Isnull(@SearchWhere,'')+'
		'
			SET @sSQL2 = N'
		SELECT ROW_NUMBER() OVER (ORDER BY '+@OrderBy+') AS RowNum, @Count AS TotalRow,
		M.APK, M.DivisionID, M.SOrderID, M.VoucherTypeID, M.VoucherNo
		, convert(varchar(20), M.OrderDate, 103) as OrderDate, M.ObjectID, M.ObjectName, M.DeliveryAddress, M.Notes, M.Disabled, M.OrderStatus, M.OrderStatusName
		, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear, M.EmployeeID
		, M.SalesManID, M.SalesManName, M.ShipDate,  M.IsConfirm, M.IsConfirmName
		, M.DescriptionConfirm, M.ConfirmUserID, M.ConfirmDate, M.IsInvoice
		, M.TotalAmount * SUM(100 - ISNULL(A9.DiscountPercent,0)) / 100 AS TotalAmount
		, ISNULL(M.IsExportOrder, 0) AS IsExportOrder, M.Ana02ID, M.Ana03ID, M.DealerID, M.AnaName
		From #TemOT2001 M
		
		LEFT JOIN SOT0088 S88 ON M.APK = S88.APKParent
		LEFT JOIN AT0109 A9 ON S88.BusinessChild = A9.PromoteID
					AND A9.FromValues <= M.TotalAmount 
					AND M.TotalAmount <= A9.ToValues
					AND A9.FromDate <= M.OrderDate
					AND M.OrderDate <= A9.ToDate
		'+Isnull(@SearchWhere,'')+'
		GROUP BY M.APK, M.DivisionID, M.SOrderID, M.VoucherTypeID, M.VoucherNo
		, M.OrderDate, M.ObjectID, M.ObjectName, M.DeliveryAddress, M.Notes, M.Disabled, M.OrderStatus, M.OrderStatusName
		, M.CreateDate, M.CreateUserID, M.LastModifyUserID, M.LastModifyDate, M.TranMonth, M.TranYear, M.EmployeeID
		, M.SalesManID, M.SalesManName, M.ShipDate,  M.IsConfirm, M.IsConfirmName
		, M.DescriptionConfirm, M.ConfirmUserID, M.ConfirmDate, M.IsInvoice
		, M.TotalAmount, A9.DiscountPercent  
		, M.IsExportOrder, M.Ana02ID, M.Ana03ID, M.DealerID, M.AnaName
		ORDER BY '+@OrderBy+'
		OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
		FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '

	--print (@sSQL)
	EXEC (@sSQL + @sSQL2)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
