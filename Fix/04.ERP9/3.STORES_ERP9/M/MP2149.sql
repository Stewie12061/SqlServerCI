IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2149]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2149]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
--- Load dữ liệu màn hình kế thừa đơn hàng sản xuất (Detail).
-- <Param>
-- <Return>
-- <Reference>
-- <History>
-- Created by: Đình hòa Date 01/06/2021
-- Updated by: Phương Thảo Date 26/10/2022 bổ sung điều kiện để biết kế thừa từ bộ định mức nào 
-- Updated by: Đức Tuyên Date 22/11/2022 Bổ sung 'KHSX' điều kiện kế thừa đơn hàng sản xuất thỏa: Trạng thái đơn hàng = 1(Đang sản xuất) và Mã hàng còn lại >0
-- Updated by: Đức Tuyên Date 16/03/2023 Phân tách: TH1-Kế thừa 1 đơn hàng, TH2-Kế thừa cộng dồn mặt hàng nhiều đơn hàng.
-- Updated by: Đức Tuyên Date 22/09/2023 Update: Fix lỗi - bỏ điều kiện left join đơn hàng sản xuất với định mức theo APK sai.
-- <Example>

 CREATE PROCEDURE [dbo].[MP2149] 
 (
	 @DivisionID NVARCHAR(250),
	 @UserID VARCHAR(50),
	 @SOrderID VARCHAR(MAX),
	 @PageNumber INT,
	 @PageSize INT,
	 @FromScreen VARCHAR(50) = '' ---- MF2141: Từ màn hình kế hoạch sản xuất
)
AS

DECLARE @sSQL NVARCHAR (MAX),
		@OrderBy NVARCHAR(500),
		@TotalRow NVARCHAR(50),
		@CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex)

SET @OrderBy = 'T0.SOrderID'

IF @FromScreen = 'MF2141'
BEGIN
	SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY T.InventoryID desc) AS RowNum, COUNT(*) OVER () AS TotalRow
			, T.APK,T.DivisionID,T.SOrderID AS VoucherNo, T.InventoryID, T3.UnitID, T.OrderQuantity, T.SalePrice, T.OriginalAmount, T.ConvertedAmount, T.VATGroupID,	T.VATPercent, T.VATOriginalAmount, T.VATConvertedAmount
			, T.Description, T1.InventoryName, T3.RoutingTime, T0.ShipDate, T4.UnitName, T4.UnitID AS UnitIDProduct,T0.ObjectID, T0.ObjectName, T5.Description AS	UnitNameMachine
			, T.Ana01ID, T.Ana02ID, T.Ana03ID, T.Ana04ID, T.Ana05ID, T.Ana06ID, T.Ana07ID, T.Ana08ID, T.Ana09ID, T.Ana10ID
			FROM OT2002 T WITH (NOLOCK)
			LEFT JOIN OT2001 T0 WITH (NOLOCK) ON T.SOrderID = T0.SOrderID AND T.DivisionID IN (''@@@'', T0.DivisionID)
			LEFT JOIN AT1302 T1 WITH (NOLOCK) ON T.InventoryID = T1.InventoryID AND T.DivisionID IN (''@@@'', T1.DivisionID)
			LEFT JOIN MT2120 T2 WITH (NOLOCK) ON T.InventoryID = T2.NodeID AND T.DivisionID IN (''@@@'', T2.DivisionID)
			LEFT JOIN MT2130 T3 WITH (NOLOCK) ON T2.RoutingID = T3.RoutingID AND T.DivisionID IN (''@@@'', T3.DivisionID)
			LEFT JOIN AT1304 T4 WITH (NOLOCK) ON T.UnitID = T4.UnitID AND T4.DivisionID IN (''@@@'', T.DivisionID)
			LEFT JOIN MT0099 T5 WITH (NOLOCK) ON T3.UnitID = T5.ID AND  T5.CodeMaster = ''RoutingUnit'' AND ISNULL(T5.Disabled, 0)= 0
			LEFT JOIN MT2141 T6 WITH (NOLOCK) ON T6.InheritTableID = ''OT2002'' AND  T6.InheritVoucherID = T.SOrderID AND T6.InheritTransactionID = T.APK AND T6.DeleteFlg =0
			WHERE T.DivisionID = '''+@DivisionID+''' AND T.SOrderID IN  ('''+ @SOrderID +''') AND T6.InheritTransactionID IS NULL'
END
ELSE
BEGIN
IF (@CustomerIndex IN (117,158)) -- Khách hàng MAITHU và HIPC
	BEGIN
		SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY T.InventoryID desc) AS RowNum, COUNT(*) OVER () AS TotalRow
				, T.APK,T.DivisionID,T.SOrderID AS VoucherNo, T.InventoryID, T3.UnitID, T.OrderQuantity, T.SalePrice, T.OriginalAmount, T.ConvertedAmount, T.VATGroupID,	T.VATPercent, T.VATOriginalAmount, T.VATConvertedAmount
				, T.Description, T1.InventoryName, T3.RoutingTime, T0.ShipDate, T4.UnitName, T4.UnitID AS UnitIDProduct,T0.ObjectID, T0.ObjectName, T5.Description AS	UnitNameMachine
				, T.Ana01ID, T.Ana02ID, T.Ana03ID, T.Ana04ID, T.Ana05ID, T.Ana06ID, T.Ana07ID, T.Ana08ID, T.Ana09ID, T.Ana10ID
				FROM OT2002 T WITH (NOLOCK)
				LEFT JOIN OT2001 T0 WITH (NOLOCK) ON T.SOrderID = T0.SOrderID AND T.DivisionID IN (''@@@'', T0.DivisionID)
				LEFT JOIN AT1302 T1 WITH (NOLOCK) ON T.InventoryID = T1.InventoryID AND T.DivisionID IN (''@@@'', T1.DivisionID)
				LEFT JOIN MT2120 T2 WITH (NOLOCK) ON T.InventoryID = T2.NodeID AND T.DivisionID IN (''@@@'', T2.DivisionID)
				LEFT JOIN MT2130 T3 WITH (NOLOCK) ON T2.RoutingID = T3.RoutingID AND T.DivisionID IN (''@@@'', T3.DivisionID)
				LEFT JOIN AT1304 T4 WITH (NOLOCK) ON T.UnitID = T4.UnitID AND T4.DivisionID IN (''@@@'', T.DivisionID)
				LEFT JOIN MT0099 T5 WITH (NOLOCK) ON T3.UnitID = T5.ID AND  T5.CodeMaster = ''RoutingUnit'' AND ISNULL(T5.Disabled, 0)= 0
				WHERE T.DivisionID = '''+@DivisionID+''' AND T.SOrderID IN  ('''+ @SOrderID +''')'
	END
ELSE
	BEGIN
	IF ((SELECT COUNT(RTRIM(LTRIM(VALUE))) FROM dbo.StringSplit(''+@SOrderID+'', ',')) > 1)
	BEGIN
		--TH2-Kế thừa cộng dồn mặt hàng nhiều đơn hàng.
		SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY T.InventoryID desc) AS RowNum, COUNT(*) OVER () AS TotalRow
			, T.InventoryID, T1.InventoryName, T3.UnitID, T4.UnitName, T4.UnitID AS UnitIDProduct
			, '''+ REPLACE(@SOrderID, '''', '') +''' AS VoucherNo
			, SUM(T.OrderQuantity) AS OrderQuantity
			, A.APK AS APK_BomVersion, A.Version, A.ObjectID
			, (SELECT TOP 1 M2.nvarchar01
				FROM OT2002 M2 WITH(NOLOCK)
				WHERE M2.DivisionID = '''+@DivisionID+''' AND M2.SOrderID IN  ('''+ @SOrderID +''') AND M2.InventoryID = T.InventoryID
			) AS nvarchar01
			, 1 AS IsManyOrders
			FROM OT2002 T WITH (NOLOCK)
			LEFT JOIN OT2001 T0 WITH (NOLOCK) ON T.SOrderID = T0.SOrderID AND T.DivisionID IN (''@@@'', T0.DivisionID)
			LEFT JOIN AT1302 T1 WITH (NOLOCK) ON T.InventoryID = T1.InventoryID AND T.DivisionID IN (''@@@'', T1.DivisionID)
			LEFT JOIN MT2120 T2 WITH (NOLOCK) ON T.InventoryID = T2.NodeID AND T.DivisionID IN (''@@@'', T2.DivisionID)
			LEFT JOIN MT2130 T3 WITH (NOLOCK) ON T2.RoutingID = T3.RoutingID AND T.DivisionID IN (''@@@'', T3.DivisionID)
			LEFT JOIN AT1304 T4 WITH (NOLOCK) ON T.UnitID = T4.UnitID AND T4.DivisionID IN (''@@@'', T.DivisionID)
			LEFT JOIN MT0099 T5 WITH (NOLOCK) ON T3.UnitID = T5.ID AND  T5.CodeMaster = ''RoutingUnit'' AND ISNULL(T5.Disabled, 0)= 0
			OUTER APPLY
			(
				SELECT TOP 1 M1.APK, M1.Version, ISNULL(M1.ObjectID, N'''') AS ObjectID
				FROM MT2122 M1 WITH (NOLOCK) 
				WHERE M1.DivisionID IN (''' + @DivisionID + ''', ''@@@'')
					--AND CONVERT(VARCHAR,GETDATE(),112) BETWEEN CONVERT(VARCHAR,M1.StartDate,112) AND CONVERT(VARCHAR,M1.EndDate,112)
					AND M1.NodeID = T.InventoryID
				ORDER BY M1.Version DESC, M1.CreateDate DESC
			) A
			WHERE T.DivisionID = '''+@DivisionID+''' AND T.SOrderID IN  ('''+ @SOrderID +''')
			GROUP BY T.InventoryID, T1.InventoryName, T3.UnitID, T4.UnitName, T4.UnitID, A.APK, A.Version, A.ObjectID, T.nvarchar01
			ORDER BY '+@OrderBy+' 
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END
	ELSE
	BEGIN
		--TH1-Kế thừa 1 đơn hàng
		SET @sSQL = 'SELECT ROW_NUMBER() OVER (ORDER BY T.InventoryID desc) AS RowNum, COUNT(*) OVER () AS TotalRow
			
			, T.APK AS APK_OT2002
			, T.DivisionID
			, T.SOrderID AS VoucherNo
			, T.InventoryID, T1.InventoryName
			, T3.UnitID, T4.UnitName
			, T4.UnitID AS UnitIDProduct
			, T.OrderQuantity AS OrderQuantity
			, A.APK AS APK_BomVersion, A.Version
			, T0.ObjectID, T0.ObjectName
			, T.nvarchar01 , T.nvarchar02 , T.nvarchar03 , T.nvarchar04, T.nvarchar05, T.nvarchar06, T.nvarchar07, T.nvarchar08, T.nvarchar09, T.nvarchar10
			, T.nvarchar11 , T.nvarchar12 , T.nvarchar13 , T.nvarchar14, T.nvarchar15, T.nvarchar16, T.nvarchar17, T.nvarchar18, T.nvarchar19, T.nvarchar20
			, T.Ana01ID, T01.AnaName As Ana01Name, T.Ana02ID, T02.AnaName As Ana02Name, T.Ana03ID, T03.AnaName As Ana03Name, T.Ana04ID, T04.AnaName As Ana04Name, T.Ana05ID, T05.AnaName As Ana05Name
			, T.Ana06ID, T06.AnaName As Ana06Name, T.Ana07ID, T07.AnaName As Ana07Name, T.Ana08ID, T08.AnaName As Ana08Name, T.Ana09ID, T09.AnaName As Ana09Name, T.Ana10ID, T10.AnaName As Ana10Name
			, 0 AS IsManyOrders
			, T.Description AS Description

			FROM OT2002 T WITH (NOLOCK)
				LEFT JOIN OT2001 T0 WITH (NOLOCK) ON T.DivisionID IN (''@@@'', T0.DivisionID)
													AND T.SOrderID = T0.SOrderID
				LEFT JOIN AT1302 T1 WITH (NOLOCK) ON T.DivisionID IN (''@@@'', T1.DivisionID)
													AND T.InventoryID = T1.InventoryID
				LEFT JOIN MT2120 T2 WITH (NOLOCK) ON T.DivisionID IN (''@@@'', T2.DivisionID)
													AND T.InventoryID = T2.NodeID 
				LEFT JOIN MT2130 T3 WITH (NOLOCK) ON T2.RoutingID = T3.RoutingID AND T.DivisionID IN (''@@@'', T3.DivisionID)
				LEFT JOIN AT1304 T4 WITH (NOLOCK) ON T.UnitID = T4.UnitID AND T4.DivisionID IN (''@@@'', T.DivisionID)
				LEFT JOIN MT0099 T5 WITH (NOLOCK) ON T3.UnitID = T5.ID AND  T5.CodeMaster = ''RoutingUnit'' AND ISNULL(T5.Disabled, 0)= 0
			
				LEFT JOIN AT1011 T01 WITH (NOLOCK) ON T01.AnaID = T.Ana01ID AND T01.AnaTypeID = ''A01''
				LEFT JOIN AT1011 T02 WITH (NOLOCK) ON T02.AnaID = T.Ana02ID AND T02.AnaTypeID = ''A02''
				LEFT JOIN AT1011 T03 WITH (NOLOCK) ON T03.AnaID = T.Ana03ID AND T03.AnaTypeID = ''A03''
				LEFT JOIN AT1011 T04 WITH (NOLOCK) ON T04.AnaID = T.Ana04ID AND T04.AnaTypeID = ''A04''
				LEFT JOIN AT1011 T05 WITH (NOLOCK) ON T05.AnaID = T.Ana05ID AND T05.AnaTypeID = ''A05''
				LEFT JOIN AT1011 T06 WITH (NOLOCK) ON T06.AnaID = T.Ana06ID AND T06.AnaTypeID = ''A06''
				LEFT JOIN AT1011 T07 WITH (NOLOCK) ON T07.AnaID = T.Ana07ID AND T07.AnaTypeID = ''A07''
				LEFT JOIN AT1011 T08 WITH (NOLOCK) ON T08.AnaID = T.Ana08ID AND T08.AnaTypeID = ''A08''
				LEFT JOIN AT1011 T09 WITH (NOLOCK) ON T09.AnaID = T.Ana09ID AND T09.AnaTypeID = ''A09''
				LEFT JOIN AT1011 T10 WITH (NOLOCK) ON T10.AnaID = T.Ana10ID AND T10.AnaTypeID = ''A10'' 
			--Lấy thông tin BomVersion 0 (Bộ Định Mức)
			OUTER APPLY
			(
				SELECT TOP 1 M1.APK, M1.Version, ISNULL(M1.ObjectID, N'''') AS ObjectID
				FROM MT2122 M1 WITH (NOLOCK) 
				WHERE M1.DivisionID IN (''' + @DivisionID + ''', ''@@@'')
					--AND CONVERT(VARCHAR,GETDATE(),112) BETWEEN CONVERT(VARCHAR,M1.StartDate,112) AND CONVERT(VARCHAR,M1.EndDate,112)
					AND M1.NodeID = T.InventoryID
					AND M1.Version = 0
				ORDER BY M1.Version DESC, M1.CreateDate DESC
			) A
			--Kiểm tra đơn hàng đã được kế thừa trước đó
			OUTER APPLY 
			( 
				SELECT OT02.* 
				FROM OT2002 OT02 WITH (NOLOCK)
					LEFT JOIN OT2202 OT22 WITH (NOLOCK) ON OT22.InheritTableID = ''OT2002'' 
												AND OT22.InheritVoucherID = OT02.SOrderID 
												AND OT22.InheritTransactionID = OT02.APK 
												AND OT22.DeleteFlg =0
				WHERE 
					OT02.DivisionID = T.DivisionID
					AND OT02.SOrderID = T.SOrderID
					AND OT22.InheritTransactionID IS NULL
			) A2
			WHERE T.DivisionID = '''+@DivisionID+''' 
				AND T.SOrderID IN  ('''+ @SOrderID +''')
				AND T.APK = A2.APK
			--GROUP BY T.InventoryID, T1.InventoryName, T3.UnitID, T4.UnitName, T4.UnitID, A.APK, A.Version, A.ObjectID, T.nvarchar01
			ORDER BY '+@OrderBy+' 
			OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
			FETCH NEXT '+STR(@PageSize)+' ROWS ONLY '
	END
	END
END

PRINT(@sSQL)
EXEC (@sSQL)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
