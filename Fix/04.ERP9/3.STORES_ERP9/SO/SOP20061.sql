IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20061]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20061]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---- Load Grid Master: màn hình Kế thừa đơn hàng gia công
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Học Huy on 20/11/2019
----Modified by Văn Tài on 02/01/2020 : Bổ sung tìm kiếm theo VoucherNo.
----Modified by Bảo Toàn on 17/03/2020 : [MAI THƯ] Tiến độ giao hàng kế thừa đơn hàng bán, không ràng buộc trạng thái phiếu.
----Modified by Đình Ly on 03/03/2021 : [MAI THƯ] Bổ sung trường hợp load dữ liệu cho nghiệp vụ Yêu cầu đóng gói (module M).
----Modified by Kiều Nga on 05/06/2021 : [MAI THƯ][2021/05/IS/0017] Fix lỗi không load được dữ liệu kế thừa.
----Modified by Lê Hoàng on 13/05/2021 : Lấy đúng dữ liệu tên tình trạng.
----Modified by Đình Hòa on 14/06/2021 : Bổ sung DivisionID(line 84) vì trường hợp gặp có 2 division trở lên.
----Modified by Đình Ly on 16/06/2021 : [MAI THƯ] Bổ sung trường hợp load dữ liệu cho nghiệp vụ Đơn hàng điều chỉnh (module SO).
----Modified by Đức Tuyên on 08/03/2023 : [Chuẩn] Cập nhật - Nếu đơn hàng đã lên tiến độ giao hàng, hoặc đơn hàng có check ngày giao hàng => vẫn có hiển thị kế thừa trên đơn hàng sản xuất.
----Modified by Đức Tuyên on 11/04/2023: Bổ sung Ẩn các đơn đã kế thừa hết sô lượng - Hiển thị đúng số lượng chưa kế thừa.
----Modified by Tiến Thành on 11/04/2023 : Ẩn nếu đơn hàng đã kế thừa hết số lượng (Sau khi đã lọc lại ngày)
----Modified by Đức Tuyên on 20/04/2023: Chỉnh sửa ẩn các đơn đã kế thừa hết số lượng.
----Modified by Tiến Thành 	on 24/04/2023: [2023/03/IS/0049] Chỉnh sửa ẩn các đơn đã kế thừa hết số lượng.
----Modified by Văn Tài		on 29/05/2023: [2023/05/IS/0164] Điều chỉnh bổ sung trường hợp kế thừa Đơn hàng bán - mà đơn đó chưa có DHSX nào.
----Modified by Đức Tuyên on 03/10/2023: Điều chỉnh ẩn kế thừa đơn hàng bán (Customize INNOTEK).
----Modified by Minh Dũng on 05/10/2023: Thêm điều kiện chỉ lấy đơn hàng bán trong màn POF2101 của INT
----Modified by Hoàng Long on 23/11/2023:[2023/11/IS/0168] - Thêm cột DeliveryAddress (địa chỉ giao hàng)
-- <Example>
---- 
/*-- <Example>
	exec SOP20061 @DivisionID=N'MTH',@UserID=N'HOCHUY',@PageNumber=1,@PageSize=25,@IsDate=1,
	@FromDate='2019-10-20 00:00:00',@ToDate='2019-11-21 00:00:00',@FromMonth=NULL,@FromYear=NULL,
	@ToMonth=NULL,@ToYear=NULL,@PriorityID=N'',
	@Ana01ID=N'',@Ana02ID=N'',@Ana03ID=N'',@Ana04ID=N'',@Ana05ID=N'',
	@Ana06ID=N'',@Ana07ID=N'',@Ana08ID=N'',@Ana09ID=N'',@Ana10ID=N'',@ScreenID=NULL,@ConditionOpportunityID=NULL
----*/

CREATE PROCEDURE SOP20061
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
	 @VoucherNo VARCHAR(50),
	 @Ana01ID NVARCHAR(50),
	 @Ana02ID NVARCHAR(50),
	 @Ana03ID NVARCHAR(50),
	 @Ana04ID NVARCHAR(50),
	 @Ana05ID NVARCHAR(50),
	 @Ana06ID NVARCHAR(50),
	 @Ana07ID NVARCHAR(50),
	 @Ana08ID NVARCHAR(50),
	 @Ana09ID NVARCHAR(50),
	 @Ana10ID NVARCHAR(50),
	 @ScreenID NVARCHAR(250) ='',
	 @ObjectName NVARCHAR(250) ='',
	 @ConditionOpportunityID nvarchar(max)
)
AS 

DECLARE @sSQL NVARCHAR(MAX) = N'',	
		@sSQL1 NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N'',
		@sJoin VARCHAR(MAX) = N'',
		@Customerindex INT,
		@ListSOT0002 NVARCHAR(MAX) = N'',
		@ParentScreenID VARCHAR = ''

SET @Customerindex = (SELECT CustomerName FROM CustomerIndex)
SET @ListSOT0002 = ISNULL((SELECT VoucherOutSource FROM SOT0002 WITH (NOLOCK) WHERE DivisionID = @DivisionID), '')
SET @OrderBy = 'T1.VoucherNo'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

IF ISNULL(@ListSOT0002,'') <> ''
	BEGIN
		SET @ListSOT0002 = REPLACE(@ListSOT0002, ',', ''',''')
	END

IF @IsDate = 0 
	BEGIN
		SET @sWhere = @sWhere + N'
			AND T1.TranMonth + T1.TranYear * 100 BETWEEN ' + STR(@FromMonth + @FromYear * 100) + ' AND ' + STR(@ToMonth + @ToYear * 100) + ''
	END
ELSE
	BEGIN
		IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') 
			SET @sWhere = @sWhere + N'
				AND T1.OrderDate >= '''+CONVERT(VARCHAR(10), @FromDate, 120)+''''
		IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') 
			SET @sWhere = @sWhere + N'
				AND T1.OrderDate <= '''+CONVERT(VARCHAR(10), @ToDate, 120)+''''
		IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') 
			SET @sWhere = @sWhere + N'
				AND T1.OrderDate BETWEEN '''+CONVERT(VARCHAR(10), @FromDate, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToDate, 120)+''' '
	END

-- Số chứng từ
IF ISNULL(@VoucherNo, '') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T1.VoucherNo LIKE ''' + @VoucherNo + '%'' )'
	END

IF ISNULL(@Ana01ID,'') <> ''
	BEGIN
		IF(@Customerindex = 114)
			BEGIN
    			SET @sWhere = @sWhere + ' AND T2.Ana01ID IN (''' + @Ana01ID + ''')'
			END
		ELSE
			BEGIN
  				SET @sWhere = @sWhere + ' AND (T2.Ana01ID like ''' + @Ana01ID + '%'' OR A11.AnaName like N''%' + @Ana01ID + '%'')'
			END
	END

IF ISNULL(@Ana02ID,'') <> ''
	BEGIN
		IF(@Customerindex = 114)
			BEGIN
				SET @sWhere = @sWhere + ' AND T2.Ana02ID IN (''' + @Ana02ID + ''')'
			END
		ELSE
			BEGIN
				SET @sWhere = @sWhere + ' AND (T2.Ana02ID like ''' + @Ana02ID + '%'' OR A11.AnaName like N''%' + @Ana02ID + '%'')'
			END
		SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A12 WITH (NOLOCK) ON T2.Ana02ID = A12.AnaID AND A12.AnaTypeID = ''A02''' 
	END

IF ISNULL(@Ana03ID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T2.Ana03ID like ''%' + @Ana03ID + '%'' OR A13.AnaName like N''%' + @Ana03ID + '%'')'
		SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A13 WITH (NOLOCK) ON T2.Ana03ID = A13.AnaID AND A13.AnaTypeID = ''A03''' 
	END

IF ISNULL(@Ana04ID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T2.Ana04ID like ''%' + @Ana04ID + '%'' OR A14.AnaName like N''%' + @Ana04ID + '%'')'
		SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A14 WITH (NOLOCK) ON T2.Ana04ID = A14.AnaID AND A14.AnaTypeID = ''A04'''
	END

IF ISNULL(@Ana05ID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T2.Ana05ID like ''%' + @Ana05ID + '%'' OR A15.AnaName like N''%' + @Ana05ID + '%'')'
		SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A15 WITH (NOLOCK) ON T2.Ana05ID = A15.AnaID AND A15.AnaTypeID = ''A05''' 
	END

IF ISNULL(@Ana06ID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T2.Ana06ID like ''%' + @Ana06ID + '%'' OR A16.AnaName like N''%' + @Ana06ID + '%'')'
		SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A16 WITH (NOLOCK) ON T2.Ana06ID = A16.AnaID AND A16.AnaTypeID = ''A06'''
	END

IF ISNULL(@Ana07ID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T2.Ana07ID like ''%' + @Ana07ID + '%'' OR A17.AnaName like N''%' + @Ana07ID + '%'')'
		SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A17 WITH (NOLOCK) ON T2.Ana07ID = A17.AnaID AND A17.AnaTypeID = ''A07''' 
	END

IF ISNULL(@Ana08ID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T2.Ana08ID like ''%' + @Ana08ID + '%'' OR A18.AnaName like N''%' + @Ana08ID + '%'')'
		SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A18 WITH (NOLOCK) ON T2.Ana08ID = A18.AnaID AND A18.AnaTypeID = ''A08''' 
	END

IF ISNULL(@Ana09ID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T2.Ana09ID like ''%' + @Ana09ID + '%'' OR A19.AnaName like N''%' + @Ana09ID + '%'')'
		SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A19 WITH (NOLOCK) ON T2.Ana09ID = A19.AnaID AND A19.AnaTypeID = ''A09''' 
	END

IF ISNULL(@Ana10ID,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T2.Ana10ID like ''%' + @Ana10ID + '%'' OR A20.AnaName like N''%' + @Ana10ID + '%'')'
		SET @sJoin = @sJoin + ' LEFT JOIN AT1011 A20 WITH (NOLOCK) ON T2.Ana10ID = A20.AnaID AND A20.AnaTypeID = ''A10'''
	END

IF ISNULL(@ObjectName,'') <> ''
	BEGIN
		SET @sWhere = @sWhere + ' AND (T1.ObjectID LIKE ''%' + @ObjectName + '%'' OR T1.ObjectName LIKE N''%' + @ObjectName + '%'')'
	END

IF ISNULL(@ConditionOpportunityID, '') != ''
	SET @sWhere = @sWhere + ' AND ISNULL(T1.CreateUserID,'''') IN (N'''+@ConditionOpportunityID+''' )'

--Phan quyen theo nghiep vu
SET @sWhere = @sWhere + dbo.GetPermissionVoucherNo(@UserID,'T1.VoucherNo')

IF @ScreenID = 'POF2001'
BEGIN
	SET @sSQL = @sSQL + N'
		SELECT DISTINCT T1.APK APKMaster, T1.DivisionID
			, T1.VoucherNo, T1.VoucherTypeID
			, T1.ObjectID, T1.ObjectName, T1.OrderDate, T1.Notes, T1.DeliveryAddress
		INTO #OT2001
		FROM OT2001 T1 WITH (NOLOCK) 
			LEFT JOIN SOT0002 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID
		' + @sJoin + '	
		WHERE T1.DivisionID = '''+ @DivisionID + '''
			AND T1.ClassifyID = ''GC''
			AND T1.OrderStatus = 1
		'+@sWhere +''
END
ELSE IF @ScreenID = 'POF2001DB'
BEGIN
	SET @sSQL = @sSQL + N'
		SELECT DISTINCT T1.APK APKMaster, T1.DivisionID
			, T1.VoucherNo, T1.VoucherTypeID
			, T1.ObjectID, T1.ObjectName, T1.OrderDate, T1.Notes, T1.DeliveryAddress
		INTO #OT2001
		FROM OT2001 T1 WITH (NOLOCK) 
			LEFT JOIN SOT0002 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID
			LEFT JOIN OT2002 WITH (NOLOCK) ON T1.SOrderID = OT2002.SOrderID
			LEFT JOIN AT2007 A07 WITH(NOLOCK) ON A07.SOrderID = OT2002.SOrderID AND A07.DivisionID = OT2002.DivisionID AND A07.InventoryID = OT2002.InventoryID    
		' + @sJoin + '	
		OUTER APPLY
		(
			SELECT TOP 1 OT02_DHB.APK, OT02_DHB.SOrderID, OT02_DSX.OrderQuantity
			FROM OT2002 OT02_DHB WITH (NOLOCK)
				LEFT JOIN 
				(SELECT OT02.InheritTransactionID, SUM(OT02.OrderQuantity) AS OrderQuantity FROM OT2002 OT02 WITH (NOLOCK)
					WHERE OT02.DivisionID = '''+ @DivisionID + '''
							AND OT02.InheritTableID = N''OT2002''
							AND OT02.InheritTransactionID IS NOT NULL
					GROUP BY OT02.InheritTransactionID
				)  OT02_DSX ON  OT02_DSX.InheritTransactionID = OT02_DHB.APK
							
			WHERE OT02_DHB.SOrderID = T1.SOrderID
				AND ISNULL(OT02_DHB.InheritTableID, '''') <> N''OT2002''
				AND ISNULL(OT02_DHB.InheritTransactionID, '''') = ''''
				AND (OT02_DSX.OrderQuantity < OT02_DHB.OrderQuantity OR OT02_DSX.InheritTransactionID IS NULL)
		) A1
		WHERE T1.DivisionID = '''+ @DivisionID + '''
			AND T1.OrderStatus = 1
			AND (A1.SOrderID IS NULL OR A1.SOrderID = T1.SOrderID)
		'+@sWhere +'
		GROUP BY T1.APK, T1.DivisionID
			, T1.VoucherNo, T1.VoucherTypeID
			, T1.ObjectID, T1.ObjectName, T1.OrderDate, T1.Notes, T1.DeliveryAddress, OT2002.OrderQuantity, A07.ActualQuantity
		HAVING (SUM(ISNULL(OT2002.OrderQuantity,0)) - SUM(ISNULL(A07.ActualQuantity,0))) > 0'

END
ELSE IF @ScreenID = 'SOF2081'
BEGIN
	SET @sSQL = @sSQL + N'
		SELECT DISTINCT T1.APK, T1.DivisionID
			, T1.VoucherNo, T1.VoucherTypeID, T1.DeliveryAddress
			, T1.ObjectID, T1.ObjectName, T1.OrderDate, T1.Notes,T1.ShipStartDate
		INTO #OT2001
		FROM OT2001 T1 WITH (NOLOCK) 
			LEFT JOIN SOT0002 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID
		' + @sJoin + '	
		WHERE T1.DivisionID = '''+ @DivisionID + '''
			AND ISNULL(T1.OrderStatus, 0) = 1'
		+@sWhere +''
END

ELSE IF @ScreenID = 'POF2061'
BEGIN
	-- TODO xử lý mô tả trạng thái
	SET @sSQL = @sSQL + N'
		SELECT DISTINCT T1.APK APKMaster
		, T1.DivisionID
		, T1.VoucherNo
		, T1.VoucherTypeID
		, T1.ObjectID
		, T1.ObjectName
		, T1.OrderDate
		, T1.OrderStatus
		, A99.Description AS OrderStatusName
		, T1.Notes
		INTO #OT2001
		FROM OT2001 T1 WITH (NOLOCK) 
			LEFT JOIN SOT0002 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID
			LEFT JOIN AT0099 A99 WITH (NOLOCK) ON A99.CodeMaster = ''AT00000003'' AND A99.ID = T1.OrderStatus
		' + @sJoin + '	
		WHERE T1.DivisionID = '''+ @DivisionID + '''
			AND ISNULL(T1.OrderStatus, 0) = 1'
		+@sWhere +''
END

ELSE IF @ScreenID = 'SOF2101' --[MAI THƯ]: Tiến độ giao hàng kế thừa đơn hàng bán, không ràng buộc trạng thái phiếu
BEGIN
	SET @sSQL = @sSQL + N'
		SELECT DISTINCT T1.APK APKMaster, T1.DivisionID
			, T1.VoucherNo, T1.VoucherTypeID
			, T1.ObjectID, T1.ObjectName, T1.OrderDate, T1.Notes,T1.DeliveryAddress,T1.Address,T1.ShipStartDate
		INTO #OT2001
		FROM OT2001 T1 WITH (NOLOCK) 
			LEFT JOIN SOT0002 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID
			LEFT JOIN OT2003_MT T3 WITH (NOLOCK) ON T1.SOrderID = T3.SOrderID
		' + @sJoin + '	
		WHERE T1.DivisionID = '''+ @DivisionID + '''
			AND ISNULL(T1.IsShipDate, 0) = 0				
			AND T1.SOrderID IS NOT NULL AND T3.SOrderID IS NULL
			' + CASE @Customerindex WHEN 161 THEN 'AND T1.OrderType = ''0''' ELSE '' END
		+@sWhere +''
END

ELSE IF @ScreenID = 'MF2181' --[MAI THƯ]: Bổ sung trường hợp load dữ liệu cho nghiệp vụ Yêu cầu đóng gói (module M).
BEGIN
	SET @sSQL = @sSQL + N'
		SELECT DISTINCT T1.APK APKMaster, T1.DivisionID, T1.VoucherNo, T1.VoucherTypeID
			, T1.ObjectID, T1.ObjectName, T1.OrderDate, T1.Notes, T1.DeliveryAddress, T1.Address, T1.ShipStartDate
		INTO #OT2001
		FROM OT2001 T1 WITH (NOLOCK) 
			LEFT JOIN SOT0002 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID
			LEFT JOIN OT2003_MT T3 WITH (NOLOCK) ON T1.SOrderID = T3.SOrderID
		' + @sJoin + '	
		WHERE T1.DivisionID = '''+ @DivisionID + '''			
			AND T1.SOrderID IS NOT NULL'
		+@sWhere +''
END

ELSE IF @ScreenID = 'SOF2091' --[MAI THƯ]: Bổ sung trường hợp load dữ liệu cho nghiệp vụ Đơn hàng điều chỉnh [SOF2091].
BEGIN
	SET @sSQL = @sSQL + N'
		SELECT DISTINCT T1.APK APKMaster, T1.DivisionID
			, T1.VoucherNo, T1.VoucherTypeID
			, T1.ObjectID, T1.ObjectName, T1.OrderDate, T1.Notes,T1.DeliveryAddress,T1.Address
		INTO #OT2001
		FROM OT2001 T1 WITH (NOLOCK) 
			LEFT JOIN SOT0002 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID
			LEFT JOIN OT2003 T3 WITH (NOLOCK) ON T1.SOrderID = T3.SOrderID
		' + @sJoin + '	
		WHERE T1.DivisionID = '''+ @DivisionID + '''
			--AND ISNULL(T1.IsShipDate, 0) = 0
			--AND ISNULL(T1.OrderStatus, 0) = 1
			--AND T1.SOrderID IS NOT NULL AND T3.SOrderID IS NULL'
		+@sWhere +''
END

ELSE
BEGIN	
	IF(@Customerindex = 161) --Khách hàng INNOTEK
	BEGIN
		SET @sSQL = @sSQL + N'
			SELECT DISTINCT T1.APK APKMaster, T1.DivisionID
				, T1.VoucherNo, T1.VoucherTypeID
				, T1.ObjectID, T1.ObjectName, T1.OrderDate, T1.Notes,T1.DeliveryAddress,T1.Address
			INTO #OT2001
			FROM OT2001 T1 WITH (NOLOCK) 
				LEFT JOIN SOT0002 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID
				LEFT JOIN OT2003 T3 WITH (NOLOCK) ON T1.SOrderID = T3.SOrderID
			' + @sJoin + '
			OUTER APPLY
			(
				SELECT TOP 1 OT02_DHB.APK, OT02_DHB.SOrderID, OT02_DSX.QuantityOfOrder
				FROM OT2002 OT02_DHB WITH (NOLOCK)
					LEFT JOIN OT2001 OT01_DHB WITH (NOLOCK) ON OT01_DHB.SOrderID = OT02_DHB.SOrderID
					LEFT JOIN 
					(SELECT OT02.InheritTransactionID, SUM(OT02.QuantityOfOrder) AS QuantityOfOrder FROM OT2002 OT02 WITH (NOLOCK)
						WHERE OT02.DivisionID = '''+ @DivisionID + '''
								AND OT02.InheritTableID = N''OT2002''
								AND OT02.InheritTransactionID IS NOT NULL
						GROUP BY OT02.InheritTransactionID
					)  OT02_DSX ON  OT02_DSX.InheritTransactionID = OT02_DHB.APK
				WHERE OT02_DHB.SOrderID = T1.SOrderID
					AND OT01_DHB.OrderType = N''0''
					AND (OT02_DSX.QuantityOfOrder < OT02_DHB.OrderQuantity OR OT02_DSX.InheritTransactionID IS NULL)
			) A1
			WHERE T1.DivisionID = '''+ @DivisionID + '''
				AND ISNULL(T1.OrderStatus, 0) = 1
				AND A1.SOrderID = T1.SOrderID'
			+@sWhere +''
	END
	ELSE
	BEGIN
		SET @sSQL = @sSQL + N'
			SELECT DISTINCT T1.APK APKMaster, T1.DivisionID
				, T1.VoucherNo, T1.VoucherTypeID
				, T1.ObjectID, T1.ObjectName, T1.OrderDate, T1.Notes,T1.DeliveryAddress,T1.Address
			INTO #OT2001
			FROM OT2001 T1 WITH (NOLOCK) 
				LEFT JOIN SOT0002 T2 WITH (NOLOCK) ON T1.DivisionID = T2.DivisionID
				LEFT JOIN OT2003 T3 WITH (NOLOCK) ON T1.SOrderID = T3.SOrderID
			' + @sJoin + '
			OUTER APPLY
			(
				SELECT TOP 1 OT02_DHB.APK, OT02_DHB.SOrderID, OT02_DSX.OrderQuantity
				FROM OT2002 OT02_DHB WITH (NOLOCK)
					LEFT JOIN 
					(SELECT OT02.InheritTransactionID, SUM(OT02.OrderQuantity) AS OrderQuantity FROM OT2002 OT02 WITH (NOLOCK)
						WHERE OT02.DivisionID = '''+ @DivisionID + '''
								AND OT02.InheritTableID = N''OT2002''
								AND OT02.InheritTransactionID IS NOT NULL
						GROUP BY OT02.InheritTransactionID
					)  OT02_DSX ON  OT02_DSX.InheritTransactionID = OT02_DHB.APK
							
				WHERE OT02_DHB.SOrderID = T1.SOrderID
					AND ISNULL(OT02_DHB.InheritTableID, '''') <> N''OT2002''
					AND ISNULL(OT02_DHB.InheritTransactionID, '''') = ''''
					AND (OT02_DSX.OrderQuantity < OT02_DHB.OrderQuantity OR OT02_DSX.InheritTransactionID IS NULL)
			) A1
			WHERE T1.DivisionID = '''+ @DivisionID + '''
				--AND ISNULL(T1.IsShipDate, 0) = 0
				AND ISNULL(T1.OrderStatus, 0) = 1
				AND (A1.SOrderID IS NULL OR A1.SOrderID = T1.SOrderID)'
			+@sWhere +''
	END
END
	

SET @sSQL1 = @sSQL1 + ' 
	SELECT ROW_NUMBER() OVER (ORDER BY T1.OrderDate DESC, '+@OrderBy+') AS RowNum, '+@TotalRow+' AS TotalRow, * 
	FROM #OT2001 T1
	ORDER BY '+@OrderBy+' 
	OFFSET ' + STR((@PageNumber-1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY
	'

PRINT (@sSQL)
PRINT (@sSQL1)
EXEC (@sSQL + @sSQL1)










GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
