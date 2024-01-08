IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2102]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP2102]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



-- <Summary>
---- Load lưới detail cho màn hình xem chi tiết tiến độ giao hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>

-- <History>
---- Create on 06/12/2018 by Đình Ly
---- Modified on 04/10/2022 by Đình Định : Hiển thị số lượng đã giao
---- Modified on 01/11/2022 by Đình Định : Bổ sung cột địa chỉ 
---- Modified on 09/02/2023 by Viết Toàn : Bổ sung cột tham số 
---- Modified on 06/07/2023 by Thanh Lượng :[2023/07/IS/0047] - Bổ sung select distinct fix lỗi double dữ liệu khi join bảng.
----.Modified on 26/10/2023 by Viết Toàn : Llấy số lượng giao hàng theo ngày (Trường hợp mặt hàng có nhiều địa chỉ giao hàng)
----.Modified on 02/01/2024 by Thành Sang: Tách chuỗi
-- <Example> 


CREATE PROCEDURE [dbo].[SOP2102]
( 
	 @DivisionID VARCHAR(50), 
	 @UserID VARCHAR(50), 
	 @APK NVARCHAR(50),
	 @PageNumber INT,
	 @PageSize INT
)
AS 
	DECLARE @sSQL NVARCHAR (MAX) = N'',
			@sSQL_01 NVARCHAR (MAX) = N'',
     		@OrderBy NVARCHAR(MAX) = N'', 
			@TotalRow NVARCHAR(50) = N''

	SET @OrderBy = N'O.InventoryID'
	IF  @PageNumber = 1 SET @TotalRow = 'COUNT OVER ()' ELSE SET @TotalRow = 'NULL'
	SET @sSQL = N'
		SELECT DISTINCT O.InventoryID
			 , A1.InventoryName
			 , O.UnitID
			 , O.OrderQuantity
			 , O.ConvertedQuantity
			 , T3.Address
			 , CASE 
				WHEN A3.ActualQuantity IS NULL
					THEN 0
				ELSE A3.ActualQuantity
				END	AS ShippedAmount
			 , CASE
				WHEN (O.OrderQuantity - A3.ActualQuantity) IS NULL
					THEN O.OrderQuantity 
				ELSE (O.OrderQuantity - A3.ActualQuantity) 
				END AS RemainedAmount
			 ,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity01'' THEN O.Quantity01 ELSE 0 END, 0
			)) AS Quantity01
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity02'' THEN O.Quantity02 ELSE 0 END, 0
			)) AS Quantity02						   					   
			,MAX(COALESCE(							   					   
				CASE WHEN T3.Quantity = ''Quantity03'' THEN O.Quantity03 ELSE 0 END, 0
			)) AS Quantity03
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity04'' THEN O.Quantity04 ELSE 0 END, 0
			)) AS Quantity04
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity05'' THEN O.Quantity05 ELSE 0 END, 0
			)) AS Quantity05
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity06'' THEN O.Quantity06 ELSE 0 END, 0
			)) AS Quantity06
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity07'' THEN O.Quantity07 ELSE 0 END, 0
			)) AS Quantity07
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity08'' THEN O.Quantity08 ELSE 0 END, 0
			)) AS Quantity08
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity09'' THEN O.Quantity09 ELSE 0 END, 0
			)) AS Quantity09
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity10'' THEN O.Quantity10 ELSE 0 END, 0
			)) AS Quantity10
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity11'' THEN O.Quantity11 ELSE 0 END, 0
			)) AS Quantity11
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity12'' THEN O.Quantity12 ELSE 0 END, 0
			)) AS Quantity12
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity13'' THEN O.Quantity13 ELSE 0 END, 0
			)) AS Quantity13
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity14'' THEN O.Quantity14 ELSE 0 END, 0
			)) AS Quantity14
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity15'' THEN O.Quantity15 ELSE 0 END, 0
			)) AS Quantity15
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity16'' THEN O.Quantity16 ELSE 0 END, 0
			)) AS Quantity16
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity17'' THEN O.Quantity17 ELSE 0 END, 0
			)) AS Quantity17
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity18'' THEN O.Quantity18 ELSE 0 END, 0
			)) AS Quantity18
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity19'' THEN O.Quantity19 ELSE 0 END, 0
			)) AS Quantity19
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity20'' THEN O.Quantity20 ELSE 0 END, 0
			)) AS Quantity20
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity21'' THEN O.Quantity21 ELSE 0 END, 0
			)) AS Quantity21
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity22'' THEN O.Quantity22 ELSE 0 END, 0
			)) AS Quantity22
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity23'' THEN O.Quantity23 ELSE 0 END, 0
			)) AS Quantity23
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity24'' THEN O.Quantity24 ELSE 0 END, 0
			)) AS Quantity24
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity25'' THEN O.Quantity25 ELSE 0 END, 0
			)) AS Quantity25
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity26'' THEN O.Quantity26 ELSE 0 END, 0
			)) AS Quantity26
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity27'' THEN O.Quantity27 ELSE 0 END, 0
			)) AS Quantity27
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity28'' THEN O.Quantity28 ELSE 0 END, 0
			)) AS Quantity28
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity29'' THEN O.Quantity29 ELSE 0 END, 0
			)) AS Quantity29
			,MAX(COALESCE(
				CASE WHEN T3.Quantity = ''Quantity30'' THEN O.Quantity30 ELSE 0 END, 0
			)) AS Quantity30'

		SET @sSQL_01 =  N'
			 , O.nvarchar01, O.nvarchar02, O.nvarchar03, O.nvarchar04, O.nvarchar05, O.nvarchar06, O.nvarchar07, O.nvarchar08, O.nvarchar09, O.nvarchar10
			 , O2.S01ID, O2.S02ID , O2.S03ID, O2.S04ID, O2.S05ID, O2.S06ID, O2.S07ID, O2.S08ID, O2.S09ID, O2.S10ID 
             , O2.S11ID, O2.S12ID , O2.S13ID, O2.S14ID, O2.S15ID, O2.S16ID, O2.S17ID, O2.S18ID, O2.S19ID, O2.S20ID 
		INTO #TempOT2002
		FROM OT2002 O WITH (NOLOCK)
			INNER JOIN OT2003_MT AS T3 ON T3.SOrderID = O.SOrderID
			LEFT JOIN OT2003 O1 ON CONVERT(NVARCHAR(50), O1.APK) = O.SOrderID
			LEFT JOIN AT1302 A1 ON A1.InventoryID = O.InventoryID
			LEFT JOIN (
				SELECT A3.InventoryID, A3.OTransactionID AS InheritTransactionID, A3.ActualQuantity
				FROM AT2007 A3 WITH(NOLOCK) 
					LEFT JOIN AT2006 A4 WITH(NOLOCK) ON A4.VoucherID = A3.VoucherID
				WHERE A4.KindVoucherID IN (2,4,6)
			) AS A3 on O.InventoryID = A3.InventoryID AND O.TransactionID = A3.InheritTransactionID
			LEFT JOIN OT8899 O2 WITH(NOLOCK) ON O2.TransactionID = O.TransactionID
			LEFT JOIN OT2001 O3 WITH(NOLOCK) ON O3.SOrderID = O.SOrderID
			LEFT JOIN OT2003 O4 WITH(NOLOCK) ON O4.SOrderID = CONVERT(VARCHAR(50), O3.APK)
		WHERE O4.APK = ''' + @APK + '''
		GROUP BY O.InventoryID
			 , A1.InventoryName
			 , O.UnitID
			 , O.OrderQuantity
			 , O.ConvertedQuantity
			 , T3.Address
			 , A3.ActualQuantity
			 , O.OrderQuantity
			 , O.nvarchar01, O.nvarchar02, O.nvarchar03, O.nvarchar04, O.nvarchar05, O.nvarchar06, O.nvarchar07, O.nvarchar08, O.nvarchar09, O.nvarchar10
			 , O2.S01ID, O2.S02ID , O2.S03ID, O2.S04ID, O2.S05ID, O2.S06ID, O2.S07ID, O2.S08ID, O2.S09ID, O2.S10ID 
             , O2.S11ID, O2.S12ID , O2.S13ID, O2.S14ID, O2.S15ID, O2.S16ID, O2.S17ID, O2.S18ID, O2.S19ID, O2.S20ID 
		
		DECLARE @Count INT
		SELECT @Count = COUNT(InventoryID) FROM #TempOT2002

		SELECT ROW_NUMBER() OVER (ORDER BY ' + @OrderBy + ') AS RowNum, @count AS TotalRow
			 , O.InventoryID
			 , O.InventoryName
			 , O.UnitID
			 , O.Address
			 , O.OrderQuantity
			 , O.ConvertedQuantity
			 , O.ShippedAmount
			 , O.RemainedAmount
			 , O.Quantity01, O.Quantity02, O.Quantity03, O.Quantity04, O.Quantity05, O.Quantity06, O.Quantity07, O.Quantity08, O.Quantity09, O.Quantity10
			 , O.Quantity11, O.Quantity12, O.Quantity13, O.Quantity14, O.Quantity15, O.Quantity16, O.Quantity17, O.Quantity18, O.Quantity19, O.Quantity20
			 , O.Quantity21, O.Quantity22, O.Quantity23, O.Quantity24, O.Quantity25, O.Quantity26, O.Quantity27, O.Quantity28, O.Quantity29, O.Quantity30
			 , O.nvarchar01, O.nvarchar02, O.nvarchar03, O.nvarchar04, O.nvarchar05, O.nvarchar06, O.nvarchar07, O.nvarchar08, O.nvarchar09, O.nvarchar10
			 , S01ID, S02ID , S03ID, S04ID, S05ID, S06ID, S07ID, S08ID, S09ID, S10ID 
             , S11ID, S12ID , S13ID, S14ID, S15ID, S16ID, S17ID, S18ID, S19ID, S20ID 
		FROM #TempOT2002 O
		ORDER BY ' + @OrderBy + '
		OFFSET ' + STR((@PageNumber - 1) * @PageSize) + ' ROWS
		FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY '
	EXEC (@sSQL + @sSQL_01)
	PRINT (@sSQL)
	PRINT (@sSQL_01)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
