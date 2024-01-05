IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2148]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2148]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
--- Load dữ liệu màn hình kế thừa đơn hàng sản xuất(Master).
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Đình hòa Date 01/06/2021
-- Updated by: Đức Tuyên Date 22/11/2022 Bổ sung 'KHSX' điều kiện kế thừa đơn hàng sản xuất thỏa: Trạng thái đơn hàng = 1(Đang sản xuất) và Mã hàng còn lại >0
-- <Example>

 CREATE PROCEDURE [dbo].[MP2148] 
 (
	 @DivisionID NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @IsDate TINYINT, ---- 0: Radiobutton từ kỳ có check
					  ---- 1: Radiobutton từ ngày có check
	 @FromScreen VARCHAR(50) = '', ---- MF2141: Từ màn hình kế hoạch sản xuất
	 @FromDate DATETIME, 
	 @ToDate DATETIME, 
	 @FromMonth INT, 
	 @FromYear INT, 
	 @ToMonth INT, 
	 @ToYear INT, 
	 @VoucherNo VARCHAR(50),
	 @ObjectID NVARCHAR(MAX),
	 @PageNumber INT,
	 @PageSize INT
)
AS

DECLARE @sSQL NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX) ='',
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50),
		@CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex)



IF @IsDate = 0 
BEGIN
	SET @sWhere = @sWhere + N'
	AND T.TranMonth + T.TranYear * 100 BETWEEN '+STR(@FromMonth + @FromYear * 100)+' AND '+STR(@ToMonth + @ToYear * 100)+''
END
ELSE
BEGIN
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') = '') 
		SET @sWhere = @sWhere + N'AND T.OrderDate >= '''+CONVERT(VARCHAR(10), @FromDate, 120)+''''
	IF (ISNULL(@FromDate, '') = '' AND ISNULL(@ToDate, '') <> '') 
		SET @sWhere = @sWhere + N'AND T.OrderDate <= '''+CONVERT(VARCHAR(10), @ToDate, 120)+''''
	IF (ISNULL(@FromDate, '') <> '' AND ISNULL(@ToDate, '') <> '') 
		SET @sWhere = @sWhere + N'
		AND T.OrderDate BETWEEN '''+CONVERT(VARCHAR(10), @FromDate, 120)+''' AND '''+CONVERT(VARCHAR(10), @ToDate, 120)+''' '
END


IF ISNULL(@VoucherNo,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND T.VoucherNo like ''%' + @VoucherNo + '%'''
END

IF ISNULL(@ObjectID,'') <> ''
BEGIN
	SET @sWhere = @sWhere + ' AND ( T.ObjectID Like ''%'+@ObjectID+'%'' OR T1.ObjectName  Like N''%'+@ObjectID+'%'' )'
END

IF (@CustomerIndex IN (117,158)) -- Khách hàng MAITHU và HIPC
BEGIN
	IF @FromScreen = 'MF2141'
	BEGIN
		SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY T.OrderDate desc) AS RowNum, COUNT(*) OVER () AS TotalRow
		,T.APK,T.DivisionID,T.SOrderID,T.VoucherNo,T.OrderDate, T.VoucherTypeID, T.IsWholeSale, T.ObjectID, T1.ObjectName, T2.FullName AS EmployeeID, T.Notes, T.ShipDate
		, T.OrderStatus, T3.Description AS OrderStatusName, ''MF2141'' AS FromScreen
		FROM OT2001 T WITH (NOLOCK)
		LEFT JOIN AT1202 T1 WITH (NOLOCK) ON T.ObjectID = T1.ObjectID AND T1.DivisionID IN (''@@@'',T.DivisionID)
		LEFT JOIN AT1103 T2 WITH (NOLOCK) ON T.EmployeeID = T2.EmployeeID AND T2.DivisionID IN (''@@@'',T.DivisionID)
		LEFT JOIN SOT0099 T3 WITH(NOLOCK) ON T.OrderStatus = T3.ID AND T3.CodeMaster = ''SOT2080.StatusID'' AND ISNULL(T3.Disabled, 0)= 0
		OUTER APPLY 
		( 
			SELECT TOP 1 OT02.* 
			FROM OT2002 OT02 WITH (NOLOCK)
				LEFT JOIN MT2141 MT41 WITH (NOLOCK) ON MT41.InheritTableID = ''OT2002'' 
											AND MT41.InheritVoucherID = OT02.SOrderID 
											AND MT41.InheritTransactionID = OT02.APK 
											AND MT41.DeleteFlg =0
				WHERE 
					OT02.DivisionID = T.DivisionID
					AND OT02.SOrderID = T.SOrderID
					AND  MT41.InheritTransactionID IS NULL
		) A1
		WHERE T.DivisionID = '''+@DivisionID+''' AND T.OrderType = 1 '+ @sWhere +' AND OrderStatus = 1 AND A1.SOrderID = T.SOrderID'
	END
	ELSE
	BEGIN
	SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY T.OrderDate desc) AS RowNum, COUNT(*) OVER () AS TotalRow
			,T.APK,T.DivisionID,T.SOrderID,T.VoucherNo,T.OrderDate, T.VoucherTypeID, T.IsWholeSale, T.ObjectID, T1.ObjectName, T2.FullName AS EmployeeID, T.Notes, T.ShipDate
			, T.OrderStatus, T3.Description AS OrderStatusName
			FROM OT2001 T WITH (NOLOCK)
			LEFT JOIN AT1202 T1 WITH (NOLOCK) ON T.ObjectID = T1.ObjectID AND T1.DivisionID IN (''@@@'',T.DivisionID)
			LEFT JOIN AT1103 T2 WITH (NOLOCK) ON T.EmployeeID = T2.EmployeeID AND T2.DivisionID IN (''@@@'',T.DivisionID)
			LEFT JOIN SOT0099 T3 WITH(NOLOCK) ON T.OrderStatus = T3.ID AND T3.CodeMaster = ''SOT2080.StatusID'' AND ISNULL(T3.Disabled, 0)= 0
			WHERE T.DivisionID = '''+@DivisionID+''' AND T.OrderType = 1 '+ @sWhere +' AND OrderStatus = 0'
	END
END
ELSE
-- Xử lý chuẩn
BEGIN
	IF @FromScreen = 'MF2141'
	BEGIN
		SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY T.OrderDate desc) AS RowNum, COUNT(*) OVER () AS TotalRow
		,T.APK,T.DivisionID,T.SOrderID,T.VoucherNo,T.OrderDate, T.VoucherTypeID, T.IsWholeSale, T.ObjectID, T1.ObjectName, T2.FullName AS EmployeeID, T.Notes, T.ShipDate
		, T.OrderStatus, T3.Description AS OrderStatusName, ''MF2141'' AS FromScreen
		FROM OT2001 T WITH (NOLOCK)
		LEFT JOIN AT1202 T1 WITH (NOLOCK) ON T.ObjectID = T1.ObjectID AND T1.DivisionID IN (''@@@'',T.DivisionID)
		LEFT JOIN AT1103 T2 WITH (NOLOCK) ON T.EmployeeID = T2.EmployeeID AND T2.DivisionID IN (''@@@'',T.DivisionID)
		LEFT JOIN SOT0099 T3 WITH(NOLOCK) ON T.OrderStatus = T3.ID AND T3.CodeMaster = ''SOT2080.StatusID'' AND ISNULL(T3.Disabled, 0)= 0
		OUTER APPLY 
		( 
			SELECT TOP 1 OT02.* 
			FROM OT2002 OT02 WITH (NOLOCK)
				LEFT JOIN MT2141 MT41 WITH (NOLOCK) ON MT41.InheritTableID = ''OT2002'' 
											AND MT41.InheritVoucherID = OT02.SOrderID 
											AND MT41.InheritTransactionID = OT02.APK 
											AND MT41.DeleteFlg =0
				WHERE 
					OT02.DivisionID = T.DivisionID
					AND OT02.SOrderID = T.SOrderID
					AND  MT41.InheritTransactionID IS NULL
		) A1
		WHERE T.DivisionID = '''+@DivisionID+''' AND T.OrderType = 1 '+ @sWhere +' AND OrderStatus = 1 AND A1.SOrderID = T.SOrderID'
	END
	ELSE
	BEGIN
	SET @OrderBy = 'T.VoucherNo DESC'
	--Kế thừa tại Dự Trù điều kiện: ĐHSX trạng thái(chưa xử lý); 
	SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY T.OrderDate desc) AS RowNum, COUNT(*) OVER () AS TotalRow
			,T.APK,T.DivisionID,T.SOrderID,T.VoucherNo,T.OrderDate, T.VoucherTypeID, T.IsWholeSale
			, T.ObjectID, T1.ObjectName, T2.FullName AS EmployeeID, T.Notes, T.ShipDate
			, T.OrderStatus, T3.Description AS OrderStatusName
			FROM OT2001 T WITH (NOLOCK)
				LEFT JOIN AT1202 T1 WITH (NOLOCK) ON T.ObjectID = T1.ObjectID AND T1.DivisionID IN (''@@@'',T.DivisionID)
				LEFT JOIN AT1103 T2 WITH (NOLOCK) ON T.EmployeeID = T2.EmployeeID AND T2.DivisionID IN (''@@@'',T.DivisionID)
				LEFT JOIN SOT0099 T3 WITH(NOLOCK) ON T.OrderStatus = T3.ID AND T3.CodeMaster = ''SOT2080.StatusID'' AND ISNULL(T3.Disabled, 0)= 0
			OUTER APPLY 
			( 
				SELECT TOP 1 OT02.* 
				FROM OT2002 OT02 WITH (NOLOCK)
					LEFT JOIN OT2202 OT22 WITH (NOLOCK) ON OT22.InheritTableID = ''OT2002'' 
												AND OT22.InheritVoucherID = OT02.SOrderID 
												AND OT22.InheritTransactionID = OT02.APK 
												AND OT22.DeleteFlg =0
				WHERE 
					OT02.DivisionID = T.DivisionID
					AND OT02.SOrderID = T.SOrderID
					AND OT22.InheritTransactionID IS NULL
			) A1
			WHERE T.DivisionID = '''+@DivisionID+''' AND T.OrderType = 1 '+ @sWhere +' AND OrderStatus = 0 AND A1.SOrderID = T.SOrderID
			ORDER BY ' + @OrderBy + '
			OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
			FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	END
END

PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
