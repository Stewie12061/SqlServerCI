IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2005]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2005]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- <Summary>
---- Load Grid: màn hình kế thừa yêu cầu mua hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
---- Created by Như Hàn on 10/12/2018
---- Modified by Bảo Toàn on 24/06/2020 Bổ sung điều kiện tại bảng CMNT0030 (Dữ liệu phân quyền kế thừa DTI) với RelatedToID = ''
---- Modified by Văn Tài	 on 30/06/2021 Tách biến chuỗi để print được query.
---- Modified by Đức Duy on 26/04/2023: Mở lại dòng điều kiện lấy kế thừa yêu cầu mua hàng
----Modified by Thanh Lượng on 11/07/2023: [2023/07/IS/0035] - Ẩn đi các đơn hàng có tổng mặt hàng đã kế thừa bằng <0 khi kế thừa từ màn hình đơn hàng mua PO (Customize GREE).
----Modified by Thanh Lượng on 28/07/2023: [2023/07/IS/0293] - Bổ sung thêm điều kiện trước khi tính toán lại số lượng(Nếu chưa được kế thừa sẽ giữ số lượng cũ)(Customize GREE).
----Modify	on 06/09/2023 by Hoàng Long - [2023/09/TA/0001] - GREE- Cải tiến chức năng gán người theo dõi YCMH - Bổ sung nghiệp vụ Người theo dõi thấy được yêu cầu mua hàng khi kế thừa tạo Đơn hàng mua.
---- Modified by Hồng Thắm on 26/09/2023: 2023/09/IS/0142 - Bổ sung ẩn các đơn hàng có tổng mặt hàng đã kế thừa bằng <0 khi kế thừa từ màn hình đơn hàng mua PO (Customize ThanhLiem).
-- <Example>
---- 
/*-- <Example>
	POP2005 @DivisionID = 'AIC', @UserID = '' , @PageNumber = 1, @PageSize = 25, @IsDate = 1, @FromDate = '', @ToDate = '', @FromMonth = 1, @FromYear = 2018, @ToMonth = 12, @ToYear = 2018, @PriorityID = ''

----*/

CREATE PROCEDURE POP2005
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,	 
	 @IsDate TINYINT, ---- 0: Radiobutton từ kỳ có check
					  ---- 1: Radiobutton từ ngày có check
	 @FromDate DATETIME, 
	 @ToDate DATETIME, 
	 @FromMonth INT, 
	 @FromYear INT, 
	 @ToMonth INT, 
	 @ToYear INT, 
	 @PriorityID VARCHAR(50),
	 @Ana01ID NVARCHAR(max),
	 @Ana02ID NVARCHAR(max),
	 @Ana03ID NVARCHAR(max),
	 @Ana04ID NVARCHAR(max),
	 @Ana05ID NVARCHAR(max),
	 @Ana06ID NVARCHAR(max),
	 @Ana07ID NVARCHAR(max),
	 @Ana08ID NVARCHAR(max),
	 @Ana09ID NVARCHAR(max),
	 @Ana10ID NVARCHAR(max),
	 @ScreenID NVARCHAR(250) ='',
	 @VoucherNo NVARCHAR(250) ='',
	 @ConditionPurchaseRequestID nvarchar(max)
)
AS 
DECLARE @sSQL VARCHAR(MAX) = N'',	
		@sSQL1 VARCHAR(MAX) = N'',
		@sSQL2 VARCHAR(MAX) = N'',
		@sWhere VARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N'',
		@sJoin VARCHAR(MAX) = N'',
		@Customerindex INT,
		@select NVARCHAR(MAX) = N'',
		@sWhere2 VARCHAR(MAX) = N'',
		@sGroupbyHaving VARCHAR(MAX) = N''

SET @Customerindex = (select CustomerName from customerindex)

SET @OrderBy = 'T1.VoucherNo'
IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@PriorityID,'')<> ''
SET @sWhere = @sWhere + N'
AND T1.PriorityID LIKE ''%' +@PriorityID+'%''
'

IF @IsDate = 0 
BEGIN
	SET @sWhere = @sWhere + N'
	AND T1.TranMonth + T1.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+'
	'
END
ELSE
BEGIN
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') 
		SET @sWhere = @sWhere + N'
		AND T1.OrderDate >= '''+CONVERT(VARCHAR(10), @FromDate, 120)+'''
		'

	IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') 
		SET @sWhere = @sWhere + N'
		AND T1.OrderDate <= '''+CONVERT(VARCHAR(10), @ToDate, 120)+'''
		'

	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') 
		SET @sWhere = @sWhere + N'
		AND T1.OrderDate BETWEEN '''+CONVERT(VARCHAR(10), @FromDate, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToDate, 120)+''' 
		'
END

IF ISNULL(@Ana01ID,'') <> ''
BEGIN
  IF(@Customerindex = 114)
  BEGIN
    	SET @sWhere = @sWhere + ' AND T2.Ana01ID IN (''' + @Ana01ID + ''')
		'
  END
  ELSE
  BEGIN
  	SET @sWhere = @sWhere + ' AND (T2.Ana01ID like ''' + @Ana01ID + '%'' OR A11.AnaName like N''%' + @Ana01ID + '%'')
	'
	--SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A11 WITH (NOLOCK) ON T2.Ana01ID = A11.AnaID AND A11.AnaTypeID = ''A01'''
  END
END

IF ISNULL(@Ana02ID,'') <> ''
BEGIN
	 IF(@Customerindex = 114)
	  BEGIN
    		SET @sWhere = @sWhere + ' AND T2.Ana02ID IN (''' + @Ana02ID + ''')
			'
	  END
	  ELSE
	  BEGIN
  		SET @sWhere = @sWhere + ' AND (T2.Ana02ID like ''' + @Ana02ID + '%'' OR A11.AnaName like N''%' + @Ana02ID + '%'')
		'
	  END

	SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A12 WITH (NOLOCK) ON T2.Ana02ID = A12.AnaID AND A12.AnaTypeID = ''A02''
	' 
END

IF ISNULL(@Ana03ID,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND (T2.Ana03ID like ''%' + @Ana03ID + '%'' OR A13.AnaName like N''%' + @Ana03ID + '%'')
	'
	SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A13 WITH (NOLOCK) ON T2.Ana03ID = A13.AnaID AND A13.AnaTypeID = ''A03''
	' 
END

IF ISNULL(@Ana04ID,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND (T2.Ana04ID like ''%' + @Ana04ID + '%'' OR A14.AnaName like N''%' + @Ana04ID + '%'')
	'
	SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A14 WITH (NOLOCK) ON T2.Ana04ID = A14.AnaID AND A14.AnaTypeID = ''A04''
	'
END

IF ISNULL(@Ana05ID,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND (T2.Ana05ID like ''%' + @Ana05ID + '%'' OR A15.AnaName like N''%' + @Ana05ID + '%'')
	'
	SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A15 WITH (NOLOCK) ON T2.Ana05ID = A15.AnaID AND A15.AnaTypeID = ''A05''
	' 
END

IF ISNULL(@Ana06ID,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND (T2.Ana06ID like ''%' + @Ana06ID + '%'' OR A16.AnaName like N''%' + @Ana06ID + '%'')
	'
	SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A16 WITH (NOLOCK) ON T2.Ana06ID = A16.AnaID AND A16.AnaTypeID = ''A06''
	'
END

IF ISNULL(@Ana07ID,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND (T2.Ana07ID like ''%' + @Ana07ID + '%'' OR A17.AnaName like N''%' + @Ana07ID + '%'')
	'
	SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A17 WITH (NOLOCK) ON T2.Ana07ID = A17.AnaID AND A17.AnaTypeID = ''A07''
	' 
END

IF ISNULL(@Ana08ID,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND (T2.Ana08ID like ''%' + @Ana08ID + '%'' OR A18.AnaName like N''%' + @Ana08ID + '%'')
	'
	SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A18 WITH (NOLOCK) ON T2.Ana08ID = A18.AnaID AND A18.AnaTypeID = ''A08''
	' 
END

IF ISNULL(@Ana09ID,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND (T2.Ana09ID like ''%' + @Ana09ID + '%'' OR A19.AnaName like N''%' + @Ana09ID + '%'')
	'
	SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A19 WITH (NOLOCK) ON T2.Ana09ID = A19.AnaID AND A19.AnaTypeID = ''A09''
	' 
END

IF ISNULL(@Ana10ID,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND (T2.Ana10ID like ''%' + @Ana10ID + '%'' OR A20.AnaName like N''%' + @Ana10ID + '%'')
	'
	SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A20 WITH (NOLOCK) ON T2.Ana10ID = A20.AnaID AND A20.AnaTypeID = ''A10''
	'
END

IF ISNULL(@VoucherNo,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND T1.VoucherNo like ''%' + @VoucherNo + '%''
	'
END

IF(@Customerindex = 114)
BEGIN
	SET @sWhere = @sWhere + ' AND (A11.Disabled = 0 OR A11.Disabled Is null)
	'
END

IF(@ScreenID ='POF2001')
BEGIN
	--[A. TOẠI] Không ràng buộc tồn tại hợp đồng
	--SET @sWhere = @sWhere +' 
	--AND A20.ContractNo IS NOT NULL'

	SET @sJoin = @sJoin +' LEFT JOIN AT1031 A31 WITH (NOLOCK) ON T2.TransactionID = A31.InheritTransactionID
	LEFT JOIN AT1020 A20 WITH (NOLOCK) ON A31.ContractID = A20.ContractID
	'
	SET @sGroupbyHaving = ''
-- Ẩn đi các đơn hàng có tổng mặt hàng đã kế thừa bằng <0 khi kế thừa từ màn hình đơn hàng mua PO.
IF(@Customerindex = 162 or @Customerindex = 163)
 BEGIN
	SET @sGroupbyHaving = @sGroupbyHaving + 'GROUP BY T1.APK, T1.DivisionID,T2.InventoryID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate,T1.OrderStatus,T1.InventoryTypeID,T1.ExchangeRate,T1.PaymentID, T1.ReceivedAddress,T1.Transport, 
	T1.DueDate,T1.RequestID,CR01.RequestSubject,T1.EmployeeID,T13.FullName,T1.PriorityID, T1.Description ,T2.OrderQuantity '+ @select +'
	HAVING SUM(CASE WHEN OT22.InheritTableID = ''OT3101''THEN OT22.OrderQuantity ELSE 0 END) < T2.OrderQuantity
'
 END

	
END
ELSE IF @ScreenID in ('SOF2061A','SOF2061C') -- Đặc thù đức tín - Những người được theo dõi được quyền kế thừa
BEGIN
	SET @sJoin = @sJoin +' LEFT JOIN CMNT0020 CMNT20 WITH (NOLOCK) ON T1.APK = CMNT20.APKMaster AND CMNT20.TableID = ''OT3101'' AND CMNT20.FollowerID = '''+@UserID+''' 
	'
	SET @sJoin = @sJoin +' LEFT JOIN CMNT0030 CMNT30 WITH (NOLOCK) ON (CMNT30.RelatedToID <> '''' AND T1.APK = CMNT30.RelatedToID) AND CMNT30.TableID = ''OT3101'' AND CMNT30.UserID = '''+@UserID+''' 
	'
END

IF(@ScreenID ='POF2031')
BEGIN
	SET @select = @select + ' ,T1.CurrencyID '
END
ELSE
BEGIN
	SET @sWhere = @sWhere + '  AND ISNULL(T1.Status,0) = 1 '
END

IF @Customerindex = 162
BEGIN
	IF Isnull(@ConditionPurchaseRequestID, '') != ''
		BEGIN
			IF  @ScreenID in ('SOF2061A','SOF2061C')
			BEGIN
				SET @sWhere = @sWhere + ' AND (ISNULL(T1.CreateUserID,'''') in (N'''+@ConditionPurchaseRequestID+''' ) OR CMNT20.APKMaster IS NOT NULL OR CMNT30.RelatedToID IS NOT NULL 
				   OR ISNULL(T1.EmployeeID,'''') in (N'''+@ConditionPurchaseRequestID+''' ))
				'
			END
			ELSE
			BEGIN
				SET @sWhere = @sWhere + ' AND (ISNULL(T1.CreateUserID,'''') in (N'''+@ConditionPurchaseRequestID+''' )
				OR ISNULL(T1.EmployeeID,'''') in (N'''+@ConditionPurchaseRequestID+''' ))
				'
			END
		END
END
ELSE
BEGIN
	IF Isnull(@ConditionPurchaseRequestID, '') != ''
	BEGIN
		IF  @ScreenID in ('SOF2061A','SOF2061C')
		BEGIN
			SET @sWhere = @sWhere + ' AND (ISNULL(T1.CreateUserID,'''') in (N'''+@ConditionPurchaseRequestID+''' ) OR CMNT20.APKMaster IS NOT NULL OR CMNT30.RelatedToID IS NOT NULL)
			'
		END
		ELSE
		BEGIN
			SET @sWhere = @sWhere + ' AND ISNULL(T1.CreateUserID,'''') in (N'''+@ConditionPurchaseRequestID+''' )
			'
		END
	END
END

IF @ScreenID <> N'SOF2021'
	SET @sWhere2 = @sWhere2 + ' AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT3002 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'')'

SET @sSQL = @sSQL + N'
SELECT DISTINCT 
T1.APK APKMaster, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate,T1.OrderStatus,T1.InventoryTypeID,T1.ExchangeRate,T1.PaymentID,T1.ReceivedAddress,T1.Transport,
T1.DueDate,T1.RequestID,CR01.RequestSubject As RequestName,T1.EmployeeID,T13.FullName As EmployeeName,T1.PriorityID, T1.Description '+ @select +','''+@ScreenID+''' as ScreenID
INTO #OT3101
FROM OT3101 T1 WITH(NOLOCK)
INNER JOIN OT3102 T2 WITH(NOLOCK) ON T1.ROrderID = T2.ROrderID AND T1.DivisionID = T2.DivisionID
LEFT JOIN AT1011 A11 WITH (NOLOCK) ON T2.Ana01ID = A11.AnaID AND A11.AnaTypeID = ''A01''
LEFT JOIN CRMT20801 CR01 WITH(NOLOCK) ON T1.RequestID = CR01.APK
LEFT JOIN AT1103 T13 WITH (NOLOCK) ON T1.EmployeeID = T13.EmployeeID
LEFT JOIN OT3002 OT22 WITH(NOLOCK) ON T2.TransactionID = OT22.InheritTransactionID AND T2.DivisionID = OT22.DivisionID And OT22.InheritTableID = ''OT3101''

' + @sJoin + '	
WHERE T1.DivisionID = '''+@DivisionID+''' 
 ' --+ @sWhere2
 + 
 CASE WHEN @ScreenID ='CIF1361' THEN '' ----Khi hợp đồng kế thừa yêu cầu mua hàng	
	WHEN @ScreenID ='POF2041'  THEN ''
	WHEN @ScreenID ='POF2001'  THEN ''
	WHEN @ScreenID ='SOF2061A'  THEN ''
	WHEN @ScreenID ='SOF2061C'  THEN ''
	WHEN @ScreenID ='POF2031'  THEN ''
	WHEN @ScreenID = 'SOF2021' THEN ''
	ELSE 
 '
 AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT2102 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'') '
 END
 + @sWhere + ''
 + @sGroupbyHaving+ ''


IF(@ScreenID ='SOF2021' OR @ScreenID = 'SOF2061A' OR @ScreenID = 'SOF2061C') --Tính toán lại số lượng khi kế thừa
BEGIN
	SET @sSQL1 = @sSQL1 + N'
	INSERT INTO #OT3101
	SELECT DISTINCT 
	T1.APK APKMaster, T1.DivisionID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate,T1.OrderStatus,T1.InventoryTypeID,T1.ExchangeRate,T1.PaymentID,T1.ReceivedAddress,T1.Transport,
	T1.DueDate,T1.RequestID,CR01.RequestSubject As RequestName,T1.EmployeeID,T13.FullName As EmployeeName, T1.PriorityID, T1.Description '+ @select +' ,'''+@ScreenID+''' as ScreenID
	FROM OT3101 T1 WITH(NOLOCK)
	INNER JOIN OT3102 T2 WITH(NOLOCK) ON T1.ROrderID = T2.ROrderID AND T1.DivisionID = T2.DivisionID
	LEFT JOIN AT1011 A11 WITH (NOLOCK) ON T2.Ana01ID = A11.AnaID AND A11.AnaTypeID = ''A01''
	LEFT JOIN OT2102 OT21 WITH(NOLOCK) ON T2.TransactionID = OT21.InheritTransactionID AND T2.DivisionID = OT21.DivisionID And OT21.InheritTableID = ''OT3101''
	LEFT JOIN CRMT20801 CR01 WITH(NOLOCK) ON T1.RequestID = CR01.APK
	LEFT JOIN AT1103 T13 WITH (NOLOCK) ON T1.EmployeeID = T13.EmployeeID
	' + @sJoin + '	
	where T1.DivisionID = '''+@DivisionID+''' AND T1.APK NOT IN(select APKMaster from #OT3101)
	AND T2.TransactionID NOT IN (SELECT InheritTransactionID FROM OT3002 WITH(NOLOCK) WHERE InheritTableID = ''OT3101'')
	' + @sWhere + '
	GROUP BY T1.APK, T1.DivisionID,T2.InventoryID, T1.ROrderID, T1.VoucherNo, T1.OrderDate, T1.ShipDate,T1.OrderStatus,T1.InventoryTypeID,T1.ExchangeRate,T1.PaymentID, T1.ReceivedAddress,T1.Transport, 
	T1.DueDate,T1.RequestID,CR01.RequestSubject,T1.EmployeeID,T13.FullName,T1.PriorityID, T1.Description ,T2.OrderQuantity '+ @select +'
	HAVING SUM(OT21.QuoQuantity) < T2.OrderQuantity'
END

SET @sSQL2 = @sSQL2 + ' SELECT ROW_NUMBER() OVER (ORDER BY T1.OrderDate desc, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * FROM #OT3101 T1
ORDER BY '+@OrderBy+' 
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY
'

PRINT @sSQL 
PRINT @sSQL1
PRINT @sSQL2
EXEC (@sSQL + @sSQL1 + @sSQL2)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
