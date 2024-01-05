IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POP2045]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[POP2045]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load Grid: màn hình kế thừa báo giá nhà cung cấp
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Kiều Nga on 27/07/2019
----Modified by Trọng Kiên	on 21/09/2020: Load dữ liệu đơn vị tính
----Modified by Hoài Thanh	on 21/09/2020: Thêm trường InventoryQuantity (số lượng tồn kho)
----Modified by Văn Tài		on 12/06/2023: [2023/06/IS/0024] - Xử lý trường hợp Báo giá nhà cung cấp không có cấp duyệt.
----Modified by Hoàng Long	on 05/10/2023: [2023/09/IS/0192] - PO/POF2002 - Chi tiết Đơn hàng mua không hiển thị số PO
-- <Example>
---- 
/*-- <Example>
	POP2045 @DivisionID = 'AIC', @UserID = '', @PageNumber = 1, @PageSize = 25, @APKMaster = ''

----*/

CREATE PROCEDURE POP2045
( 
	 @DivisionID VARCHAR(50),
	 @UserID VARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT,	 
	 @APKMaster NVARCHAR(MAX)
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',		
		@sWhere NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N''

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sSQL = @sSQL + N'
SELECT ROW_NUMBER() OVER (ORDER BY OrderID) AS RowNum
		, '+@TotalRow+' AS TotalRow
		, T22.APK
		, T22.APKMaster
		, T22.DivisionID
		, T22.OrderID
		, T22.InventoryID
		, T02.InventoryName
		, T22.Quantity
		, T22.UnitPrice
		, T22.RequestPrice
		, T22.TechnicalSpecifications
		, T22.Notes
		, T22.InheritTableID
		, T22.InheritAPK
		, T22.InheritAPKDetail
		, T02.UnitID
		, T03.UnitName
		, (SELECT ISNULL(SUM(ISNULL(SignQuantity, 0)), 0) AS Quantity FROM AV7000 WHERE AV7000.DivisionID IN ('''+@DivisionID+''',''@@@'') AND AV7000.InventoryID = T02.InventoryID) AS InventoryQuantity
		, T05.PONumber
		, O99.S01ID, O99.S02ID, O99.S03ID, O99.S04ID, O99.S05ID, O99.S06ID, O99.S07ID, O99.S08ID, O99.S09ID, O99.S10ID
		, O99.S11ID, O99.S12ID, O99.S13ID, O99.S14ID, O99.S15ID, O99.S16ID, O99.S17ID, O99.S18ID, O99.S19ID, O99.S20ID
		, T22.Parameter01, T22.Parameter02, T22.Parameter03, T22.Parameter04, T22.Parameter05, T22.ConvertedQuantity, T22.ConvertedUnitPrice
		, T22.ConvertedUnitID, WQ09.ConversionFactor, WQ09.DataType, WQ09.Operator, WQ09.FormulaDes
FROM POT2022 T22 WITH (NOLOCK) 
LEFT JOIN AT1302 T02 WITH (NOLOCK) ON T02.DivisionID IN (''@@@'', T22.DivisionID) AND T22.InventoryID = T02.InventoryID
LEFT JOIN AT1304 T03 WITH(NOLOCK) ON T03.DivisionID IN (''@@@'', T22.DivisionID) AND T03.UnitID = T02.UnitID
LEFT JOIN OT3101 T04 WITH(NOLOCK) ON T04.DivisionID IN (''@@@'', T22.DivisionID) AND T04.APK = T22.InheritAPK
LEFT JOIN OT3102 T05 WITH(NOLOCK) ON T05.DivisionID IN (''@@@'', T22.DivisionID) AND T05.ROrderID = T04.ROrderID
LEFT JOIN OT8899 O99 WITH (NOLOCK) ON O99.DivisionID = T22.DivisionID AND O99.VoucherID = CONVERT(VARCHAR(50), T22.APKMaster) AND O99.TransactionID = CONVERT(VARCHAR(50), T22.APK)
LEFT JOIN WQ1309 WQ09 WITH (NOLOCK) ON WQ09.DivisionID IN (T22.DivisionID, ''@@@'') 
												AND WQ09.InventoryID = T22.InventoryID
												AND WQ09.ConvertedUnitID = T22.ConvertedUnitID
												--AND (WQ09.S01ID = O99.S01ID OR (ISNULL(WQ09.S01ID, '''') =  ISNULL(O99.S01ID, '''')))
												--AND (WQ09.S02ID = O99.S02ID OR (ISNULL(WQ09.S02ID, '''') =  ISNULL(O99.S02ID, '''')))
												--AND (WQ09.S03ID = O99.S03ID OR (ISNULL(WQ09.S03ID, '''') =  ISNULL(O99.S03ID, '''')))
												--AND (WQ09.S04ID = O99.S04ID OR (ISNULL(WQ09.S04ID, '''') =  ISNULL(O99.S04ID, '''')))
												--AND (WQ09.S05ID = O99.S05ID OR (ISNULL(WQ09.S05ID, '''') =  ISNULL(O99.S05ID, '''')))
												--AND (WQ09.S06ID = O99.S06ID OR (ISNULL(WQ09.S06ID, '''') =  ISNULL(O99.S06ID, '''')))
												--AND (WQ09.S07ID = O99.S07ID OR (ISNULL(WQ09.S07ID, '''') =  ISNULL(O99.S07ID, '''')))
												--AND (WQ09.S08ID = O99.S08ID OR (ISNULL(WQ09.S08ID, '''') =  ISNULL(O99.S08ID, '''')))
												--AND (WQ09.S09ID = O99.S09ID OR (ISNULL(WQ09.S09ID, '''') =  ISNULL(O99.S09ID, '''')))
												--AND (WQ09.S10ID = O99.S10ID OR (ISNULL(WQ09.S10ID, '''') =  ISNULL(O99.S10ID, '''')))
												--AND (WQ09.S11ID = O99.S11ID OR (ISNULL(WQ09.S11ID, '''') =  ISNULL(O99.S11ID, '''')))
												--AND (WQ09.S12ID = O99.S12ID OR (ISNULL(WQ09.S12ID, '''') =  ISNULL(O99.S12ID, '''')))
												--AND (WQ09.S13ID = O99.S13ID OR (ISNULL(WQ09.S13ID, '''') =  ISNULL(O99.S13ID, '''')))
												--AND (WQ09.S14ID = O99.S14ID OR (ISNULL(WQ09.S14ID, '''') =  ISNULL(O99.S14ID, '''')))
												--AND (WQ09.S15ID = O99.S15ID OR (ISNULL(WQ09.S15ID, '''') =  ISNULL(O99.S15ID, '''')))
												--AND (WQ09.S16ID = O99.S16ID OR (ISNULL(WQ09.S16ID, '''') =  ISNULL(O99.S16ID, '''')))
												--AND (WQ09.S17ID = O99.S17ID OR (ISNULL(WQ09.S17ID, '''') =  ISNULL(O99.S17ID, '''')))
												--AND (WQ09.S18ID = O99.S18ID OR (ISNULL(WQ09.S18ID, '''') =  ISNULL(O99.S18ID, '''')))
												--AND (WQ09.S19ID = O99.S19ID OR (ISNULL(WQ09.S19ID, '''') =  ISNULL(O99.S19ID, '''')))
												--AND (WQ09.S20ID = O99.S20ID OR (ISNULL(WQ09.S20ID, '''') =  ISNULL(O99.S20ID, '''')))
WHERE T22.DivisionID = '''+@DivisionID+''' 
AND APKMaster IN ('''+@APKMaster+''')
AND 
	(
		--- Khong co cap duyet
		ISNULL(T22.ApproveLevel, 0) = 0
		OR
		T22.Status = 1
	)
AND T22.APK NOT IN (SELECT InheritTransactionID FROM AT1031 WITH(NOLOCK) WHERE InheritTableID = ''POT2021'')
AND T22.APK NOT IN (SELECT InheritTransactionID FROM OT2102 WITH(NOLOCK) WHERE InheritTableID = ''POT2021'')
AND T22.APK NOT IN (SELECT InheritTransactionID FROM OT3002 WITH(NOLOCK) WHERE InheritTableID = ''POT2021'')
ORDER BY T22.OrderID
OFFSET '+STR((@PageNumber-1) * @PageSize)+' ROWS
FETCH NEXT '+STR(@PageSize)+' ROWS ONLY'

PRINT (@sSQL)
EXEC (@sSQL)



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
