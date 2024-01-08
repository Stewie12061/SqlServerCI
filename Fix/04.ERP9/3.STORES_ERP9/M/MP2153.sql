IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2153]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2153]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
--- Tính dự trù
-- <Param> listAPK
----
-- <Return>
----
-- <Reference>
----
-- <History>
---- Created by: Trọng Kiên	Create on: 15/03/2021
---- Update by: Đình Hoà Date: 24/07/2021 : Tính dự trù khi kế thừa từ đơn hàng sản xuất
---- Modify by: Kiều Nga Date: 10/10/2022 : Fix lỗi join với bộ định mức
---- Update by: Đức Tuyên Date: 28/11/2022 : Điều chỉnh dự trù chi phí lấy BOM version mới nhất.


Create PROCEDURE [dbo].[MP2153]
(
    @DivisionID VARCHAR(50),
	@listAPK VARCHAR(MAX) = '',
	@ProductID VARCHAR(MAX) = '',
	@MOrderID VARCHAR(MAX) = '',
	@ProductQuantity DECIMAL(28,8) = 0,
	@APK_BomVersion VARCHAR(50) = '',
	@APK_OT2202 VARCHAR(50) = ''
)
AS

DECLARE @sSQL NVARCHAR(MAX) = N'',
		@OrderBy NVARCHAR(MAX) = N'', 
		@TotalRow NVARCHAR(50) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex)

IF EXISTS(SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 117) -- Khách hàng MAITHU
BEGIN
	SET @sWhere = N' S2.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), S1.APKMaster) IN (''' + @listAPK + ''')'
	SET @OrderBy = N' ORDER BY S2.VoucherNo, S1.PhaseOrder'

	SET @sSQL = 'SELECT S2.APK, S2.VoucherNo, S2.InventoryID, A3.InventoryName, S2.SemiProduct, S1.MaterialID, A1.InventoryName AS MaterialName, S3.Length, S3.Width, S3.Height
						, S1.UnitID, A2.UnitName, S1.S01ID, S1.S02ID, S1.S03ID, S1.S04ID, S1.S05ID, S1.S06ID, S1.S07ID
						, S1.S08ID, S1.S09ID, S1.S10ID, S1.S11ID, S1.S12ID, S1.S13ID, S1.S14ID, S1.S15ID
						, S1.S16ID, S1.S17ID, S1.S18ID, S1.S19ID, S1.S20ID, M2.MaterialGroupID, M2.MaterialID AS MaterialIDChange
						, A4.InventoryName AS MaterialNameChange, M2.QuantitativeTypeID, M2.QuantitativeValue, M2.MaterialConstant
						, CASE WHEN ISNULL(S1.Gsm, 0) <> 0 THEN S1.Gsm
							   WHEN ISNULL(S1.Sheets, 0) <> 0 THEN S1.Sheets
							   WHEN ISNULL(S1.Ram, 0) <> 0 THEN S1.Ram
							   WHEN ISNULL(S1.Kg, 0) <> 0 THEN S1.Kg
							   WHEN ISNULL(S1.M2, 0) <> 0 THEN S1.M2 END AS Quantity
				 FROM SOT2082 S1 WITH (NOLOCK)
			 		 LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S1.MaterialID = A1.InventoryID
			 		 LEFT JOIN AT1304 A2 WITH (NOLOCK) ON S1.UnitID = A2.UnitID
			 		 LEFT JOIN SOT2080 S2 WITH (NOLOCK) ON S1.APKMaster = S2.APK
			 		 LEFT JOIN SOT2081 S3 WITH (NOLOCK) ON S2.APK = S3.APKMaster
			 		 LEFT JOIN AT1302 A3 WITH (NOLOCK) ON S2.InventoryID = A3.InventoryID
					 LEFT JOIN MT2120 M1 WITH (NOLOCK) ON S2.InventoryID = M1.NodeID
					 LEFT JOIN MT2121 M2 WITH (NOLOCK) ON M1.APK = M2.APKMaster AND S1.MaterialID = M2.NodeID
					 LEFT JOIN AT1302 A4 WITH (NOLOCK) ON M2.MaterialID = A4.InventoryID
				 WHERE ' + @sWhere + @OrderBy
END
ELSE IF(@CustomerIndex = 158) -- Khách hàng HIPC
BEGIN
	SET @sWhere = N' M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) IN (''' + @listAPK + ''')'

	SET @sSQL = 'SELECT M1.APK AS APKDetail, M2.APK, M2.VoucherNo, M1.InventoryID, M6.NodeID AS MaterialID, M7.InventoryName AS MaterialName, M6.UnitID, M8.UnitName, (M1.OrderQuantity*M6.Quantity) AS Quantity
				 , M10.MaterialGroupID, M10.MaterialID AS MaterialIDChange, M11.InventoryName AS MaterialNameChange, M10.QuantitativeTypeID, M10.QuantitativeValue, M10.MaterialConstant, M9.NodeID, M6.OrderStd
				FROM OT2002 M1 WITH(NOLOCK)
					LEFT JOIN OT2001 M2 WITH(NOLOCK) ON M2.SOrderID = M1.SOrderID AND M2.OrderType = 1 AND M2.DivisionID = M1.DivisionID
					LEFT JOIN OT2002 M3 WITH(NOLOCK) ON  M3.InventoryID = M1.InventoryID AND CONVERT(VARCHAR(50),M3.APK) = M1.InheritVoucherID AND M3.DivisionID = M1.DivisionID
					LEFT JOIN OT2102 M4 WITH(NOLOCK) ON  M4.QuotationID = M3.InheritVoucherID AND  M4.TransactionID = M3.QuotationID AND  M4.InventoryID = M3.InventoryID AND M4.DivisionID = M1.DivisionID
					LEFT JOIN SOT2110 M5 WITH(NOLOCK) ON M5.DivisionID = M1.DivisionID AND M4.InheritVoucherID = CONVERT(VARCHAR(50),M5.APK) AND M4.InventoryID = M5.InventoryID
					LEFT JOIN SOT2112 M6 WITH(NOLOCK) ON M6.DivisionID = M1.DivisionID AND M5.APK = M6.APKMaster
					LEFT JOIN AT1302 M7 WITH(NOLOCK) ON M6.NodeID = M7.InventoryID AND M7.DivisionID IN (M1.DivisionID, ''@@@'')
					LEFT JOIN AT1304 M8 WITH (NOLOCK) ON M6.UnitID = M8.UnitID AND M8.DivisionID IN (M1.DivisionID, ''@@@'')
					LEFT JOIN MT2120 M9 WITH (NOLOCK) ON M5.InventoryID = M9.NodeID AND M5.APK_InheritBOM = CONVERT(varchar(50), M9.APK) AND M9.DivisionID = M5.DivisionID
					LEFT JOIN MT2121 M10 WITH (NOLOCK) ON M9.APK = M10.APKMaster AND M10.MaterialID = M6.NodeID AND M10.DivisionID = M9.DivisionID
					LEFT JOIN AT1302 M11 WITH (NOLOCK) ON M10.MaterialID = M11.InventoryID AND M11.DivisionID IN (M10.DivisionID,''@@@'')
				WHERE '+ @sWhere+ ' AND M6.NodeID IS NOT NULL  
				UNION ALL
				SELECT  M1.APK AS APKDetail, M2.APK, M2.VoucherNo, M1.InventoryID ,M10.NodeID AS MaterialID , M11.InventoryName AS MaterialName, M10.UnitID, M8.UnitName,  (M1.OrderQuantity * ISNULL(M10.QuantitativeValue,0)) AS Quantity,
				M10.MaterialGroupID, M10.MaterialID AS MaterialIDChange, M11.InventoryName AS MaterialNameChange, M10.QuantitativeTypeID, M10.QuantitativeValue, M10.MaterialConstant, M9.NodeID,  M10.NodeOrder AS OrderStd
				FROM OT2002 M1 WITH(NOLOCK)
				LEFT JOIN OT2001 M2 WITH(NOLOCK) ON M2.SOrderID = M1.SOrderID AND M2.OrderType = 1 AND M2.DivisionID = M1.DivisionID
				--LEFT JOIN MT2120 M9 WITH (NOLOCK) ON M9.NodeID = M1.InventoryID AND CONVERT(varchar(50), M9.APK) = M1.InheritVoucherID AND M9.DivisionID = M1.DivisionID
				--LEFT JOIN MT2121 M10 WITH (NOLOCK) ON M9.APK = M10.APK_2120 AND M10.DivisionID = M9.DivisionID
				CROSS APPLY
				(
					SELECT *
					FROM MT2122 MT22 WITH (NOLOCK)
					WHERE 
						MT22.DivisionID = M1.DivisionID
						AND MT22.APK = (SELECT TOP 1 APK 
										FROM MT2122 MT22 WITH (NOLOCK)
										WHERE MT22.DivisionID = M1.DivisionID
											AND MT22.NodeID = M1.InventoryID Order By Version DESC)
				) M9
				LEFT JOIN MT2123 M10 WITH (NOLOCK) ON M9.APK = M10.APK_2120 AND M10.DivisionID = M9.DivisionID
				LEFT JOIN AT1302 M11 WITH (NOLOCK) ON M10.NodeID = M11.InventoryID AND M11.DivisionID IN (M10.DivisionID,''@@@'')
				LEFT JOIN AT1304 M8 WITH (NOLOCK) ON M10.UnitID = M8.UnitID AND M8.DivisionID IN (M11.DivisionID, ''@@@'')
				WHERE '+ @sWhere + ' AND M10.NodeID IS NOT NULL
			    ORDER BY APKDetail, OrderStd'
END
ELSE -- Chuẩn chung
BEGIN
	SET @sWhere = N' M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) IN (''' + @listAPK + ''')'

	--SET @sSQL = '
	--			SELECT  M1.APK AS APKDetail, M2.APK, M2.VoucherNo, M1.InventoryID ,M10.NodeID AS MaterialID , M11.InventoryName AS MaterialName, M10.UnitID, M8.UnitName,  (M1.OrderQuantity * ISNULL(M10.QuantitativeValue,0)) AS Quantity,
	--			M10.MaterialGroupID, M10.MaterialID AS MaterialIDChange, M11.InventoryName AS MaterialNameChange, M10.QuantitativeTypeID, M10.QuantitativeValue, M10.MaterialConstant, M9.NodeID,  M10.NodeOrder AS OrderStd
	--			FROM OT2002 M1 WITH(NOLOCK)
	--			LEFT JOIN OT2001 M2 WITH(NOLOCK) ON M2.SOrderID = M1.SOrderID AND M2.OrderType = 1 AND M2.DivisionID = M1.DivisionID
	--			--LEFT JOIN MT2120 M9 WITH (NOLOCK) ON M9.NodeID = M1.InventoryID AND CONVERT(varchar(50), M9.APK) = M1.InheritVoucherID AND M9.DivisionID = M1.DivisionID
	--			--LEFT JOIN MT2121 M10 WITH (NOLOCK) ON M9.APK = M10.APK_2120 AND M10.DivisionID = M9.DivisionID
	--			CROSS APPLY
	--			(
	--				SELECT *
	--				FROM MT2122 MT22 WITH (NOLOCK)
	--				WHERE 
	--					MT22.DivisionID = M1.DivisionID
	--					AND MT22.APK = (SELECT TOP 1 APK 
	--									FROM MT2122 MT22 WITH (NOLOCK)
	--									WHERE MT22.DivisionID = M1.DivisionID
	--										AND MT22.NodeID = M1.InventoryID Order By Version DESC)
	--			) M9
	--			LEFT JOIN MT2123 M10 WITH (NOLOCK) ON M9.APK = M10.APK_2120 AND M10.DivisionID = M9.DivisionID
	--			LEFT JOIN AT1302 M11 WITH (NOLOCK) ON M10.NodeID = M11.InventoryID AND M11.DivisionID IN (M10.DivisionID,''@@@'')
	--			LEFT JOIN AT1304 M8 WITH (NOLOCK) ON M10.UnitID = M8.UnitID AND M8.DivisionID IN (M11.DivisionID, ''@@@'')
	--			WHERE  M1.DivisionID IN (''@@@'', ''EXV'') AND CONVERT(VARCHAR(50), M1.APK) 
	--			IN (
	--				''5A5A581B-4854-49BB-B0F4-491457C1A9F8''
	--			) 
	--			AND M10.NodeID IS NOT NULL
	--		    ORDER BY APKDetail, OrderStd'

	SET @sSQL = 'SELECT ''' + @MOrderID + ''' AS VoucherNo
					, ''' + @ProductID + ''' AS ProductID
					, M22.RoutingID
					, M23.PhaseID
					, M23.NodeTypeID
					, CASE WHEN  M23.NodeTypeID = ''1'' THEN M23.NodeID
						ELSE ''''
						END AS SemiProduct
					, M22.Version AS ApporitionID
					, CASE WHEN  M23.NodeTypeID = ''2'' THEN M23.NodeID
						ELSE ''''
						END AS MaterialID
					, M11.InventoryName AS MaterialName
					, M23.UnitID, M8.UnitName
					, (('+LTRIM(@ProductQuantity)+' * ISNULL(M23.QuantitativeValue,0)) + ((('+LTRIM(@ProductQuantity)+' * ISNULL(M23.QuantitativeValue,0))* ISNULL(M23.LossValue,0))/100)) AS Quantity
					, M11.Specification AS Specification

					, M23.LossValue
					, M22.NodeID AS InventoryID
					, M22.NodeID
					, M23.MaterialGroupID
					, M23.MaterialID AS MaterialIDChange
					, M11.InventoryName AS MaterialNameChange
					, M23.QuantitativeTypeID, M23.QuantitativeValue
					, M23.MaterialConstant
					, M23.NodeLevel
					, M23.NodeParent
					, M23.NodeOrder AS NodeOrder
					, M23.QuantitativeValue
					, M23.LossValue

					, ''' + @APK_OT2202 + ''' AS APK_OT2202
					
					
				FROM MT2122 M22 WITH (NOLOCK)
					LEFT JOIN MT2123 M23 WITH (NOLOCK) ON M22.APK = M23.APK_2120 AND M23.DivisionID = M22.DivisionID
					LEFT JOIN AT1302 M11 WITH (NOLOCK) ON M23.NodeID = M11.InventoryID AND M11.DivisionID IN (M23.DivisionID,''@@@'')
					LEFT JOIN AT1304 M8 WITH (NOLOCK) ON M23.UnitID = M8.UnitID AND M8.DivisionID IN (M11.DivisionID, ''@@@'')
				WHERE M22.DivisionID  IN (''@@@'', ''EXV'')
					AND M22.APK = ''' + @APK_BomVersion + '''
					AND M22.NodeID = ''' + @ProductID + '''
					AND M23.NodeID IS NOT NULL
				ORDER BY M23.NodeOrder'
END

PRINT (@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
