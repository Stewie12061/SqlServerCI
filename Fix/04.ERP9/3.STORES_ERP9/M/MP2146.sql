IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2146]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2146]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---- Load dữ liệu lưới details nghiệp vụ Lệnh sản xuất.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Trọng Kiên on 06/04/2021
----Modified by Lê Hoàng on 27/05/2021: Bỏ join với bộ định mức/version bom, tính toán cột số lượng khi đổ dữ liệu lên Lệnh sản xuất
----Modified by Lê Hoàng on 03/06/2021: Làm tròn MaterialQuantity theo thiết lập Đơn vị
----Modified by Đình Hòa on 09/06/2021: Bổ sung param để xác định loại phiếu kế thừa
----Modified by Đình Ly on 29/06/2021: Xử lý load nhiều công đoạn theo ngày sản xuất.
----Modified by Đình Hòa on 20/01/2021: Xử lý load các nguyên vật liệu của nặt hàng được chọn (@APK_MT2141)
----Modified by Văn Tài	 on 26/01/2022: Bổ sung load DISCTINCT.
----Modified by Kiều Nga on 26/01/2022: Fix lỗi load Số lượng thành phẩm, số lượng dưới lưới detail
----Modified by Kiều Nga on 27/01/2022: Bổ sung load APK_MT2143
----Modified by Văn Tài  on 26/08/2022: Điều chỉnh dư dấu ,
----Modified by Kiều Nga on 21/11/2022: Fix lỗi lấy sai cột số lượng khi kế thừa kế hoạch sản xuất

-- <Example>

CREATE PROCEDURE [dbo].[MP2146]
( 
     @DivisionID VARCHAR(50),
	 @APK_MT2142 VARCHAR(MAX) = '',
	 @IsInherit INT = 0,
	 @APK_MT2143 VARCHAR(MAX) = '',
	 @APK_MT2141 VARCHAR(MAX) = ''
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',
		@sJoin NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@sSQL1 NVARCHAR(MAX) = N'',
		@CustomerIndex INT = (SELECT CustomerName FROM CustomerIndex)
IF (@CustomerIndex IN (117)) -- Khách hàng MAITHU
BEGIN
	SET @sSQL = @sSQL + N'
			SELECT Distinct MT43.Date, MT43.Date AS StartDate
			, MT42.MaterialID
			, A1.InventoryName AS MaterialName
			, MT42.MachineID, MT42.MachineName
			, MT42.UnitID, A2.UnitName
			, MT42.PhaseID, MT42.PhaseName
			, ISNULL(A5.Quantity,0) AS MaterialQuantity
			, CAST(MT43.APK AS UNIQUEIDENTIFIER) AS APK_MT2143
			, CAST(MT42.APK AS UNIQUEIDENTIFIER) AS APK_MT242
			, CONVERT(VARCHAR(50), MT41.APK_BomVersion) AS APK_BomVersion
			, CONVERT(VARCHAR(50), OT02.APK) AS APK_OT2202
			, CAST(OT03.APKNode AS UNIQUEIDENTIFIER) AS APK_NodeParent
			, OT03.S01ID, OT03.S02ID, OT03.S03ID, OT03.S04ID, OT03.S05ID, OT03.S06ID, OT03.S07ID,	OT03.S08ID,OT03.S09ID, OT03.S10ID
			, OT03.S11ID, OT03.S12ID, OT03.S13ID, OT03.S14ID, OT03.S15ID, OT03.S16ID, OT03.S17ID,	OT03.S18ID,OT03.S19ID, OT03.S20ID
	
		FROM MT2142 MT42 WITH (NOLOCK)'
	SET @sJoin = @sJoin + N'
			LEFT JOIN MT2143 MT43 WITH (NOLOCK) ON MT42.APK = MT43.APKMaster
			LEFT JOIN MT2141 MT41 WITH (NOLOCK) ON MT41.APKMaster = MT42.APKMaster AND MT41.APK =MT42.APK_MT2141
	
			LEFT JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.APK = MT41.InheritTransactionID
			LEFT JOIN OT2203 OT03 WITH (NOLOCK) ON OT03.EstimateID = OT02.EstimateID
													AND OT03.APK_OT2202 = OT02.APK
													AND OT03.SemiProduct = MT42.MaterialID
	
			LEFT JOIN AT1101 A0 WITH (NOLOCK) ON A0.DivisionID = MT43.DivisionID
			LEFT JOIN AT1302 A1 WITH (NOLOCK) ON MT42.MaterialID = A1.InventoryID
			LEFT JOIN AT1304 A2 WITH (NOLOCK) ON MT42.UnitID = A2.UnitID
			LEFT JOIN (SELECT Product, Quantity FROM (
				SELECT [Quantity01], [Quantity02], [Quantity03], [Quantity04], [Quantity05], [Quantity06],  [Quantity07], [Quantity08], [Quantity09], [Quantity10]
					 , [Quantity11], [Quantity12], [Quantity13], [Quantity14], [Quantity15], [Quantity16],  [Quantity17], [Quantity18], [Quantity19], [Quantity20]
					 , [Quantity21], [Quantity22], [Quantity23], [Quantity24], [Quantity25], [Quantity26],  [Quantity27], [Quantity28], [Quantity29], [Quantity30]
					 , [Quantity31], [Quantity32], [Quantity33], [Quantity34], [Quantity35], [Quantity36],  [Quantity37], [Quantity38], [Quantity39], [Quantity40]
					 , [Quantity41], [Quantity42], [Quantity43], [Quantity44], [Quantity45], [Quantity46],  [Quantity47], [Quantity48], [Quantity49], [Quantity50]
					 , [Quantity51], [Quantity52], [Quantity53], [Quantity54], [Quantity55], [Quantity56],  [Quantity57], [Quantity58], [Quantity59], [Quantity60]
				FROM MT2142 WITH (NOLOCK) WHERE CONVERT(VARCHAR(50), APK) = ''' + @APK_MT2142 + ''') A
				UNPIVOT (Quantity FOR Product IN (
					   [Quantity01], [Quantity02], [Quantity03], [Quantity04], [Quantity05], [Quantity06],  [Quantity07], [Quantity08], [Quantity09], [Quantity10]
					 , [Quantity11], [Quantity12], [Quantity13], [Quantity14], [Quantity15], [Quantity16],  [Quantity17], [Quantity18], [Quantity19], [Quantity20]
					 , [Quantity21], [Quantity22], [Quantity23], [Quantity24], [Quantity25], [Quantity26],  [Quantity27], [Quantity28], [Quantity29], [Quantity30]
					 , [Quantity31], [Quantity32], [Quantity33], [Quantity34], [Quantity35], [Quantity36],  [Quantity37], [Quantity38], [Quantity39], [Quantity40]
					 , [Quantity41], [Quantity42], [Quantity43], [Quantity44], [Quantity45], [Quantity46],  [Quantity47], [Quantity48], [Quantity49], [Quantity50]
					 , [Quantity51], [Quantity52], [Quantity53], [Quantity54], [Quantity55], [Quantity56],  [Quantity57], [Quantity58], [Quantity59], [Quantity60])) 
					 AS UnPVT ) 
					 AS A5 ON A5.Product = MT43.Quantity'
	SET @sWhere = @sWhere + N'
		WHERE MT42.DivisionID IN (''@@@'', ''' + @DivisionID + ''') 
			AND CONVERT(VARCHAR(50), MT42.APK) = ''' + @APK_MT2142 + '''
			AND CONVERT(VARCHAR(50), MT43.APK) = ''' + @APK_MT2143 + '''
		ORDER BY MT43.Date ASC, MT42.PhaseID, MT42.MaterialID'
	
		EXEC (@sSQL + @sJoin + @sWhere + @sSQL1)
		PRINT(@sSQL + @sJoin + @sWhere + @sSQL1)
END

ELSE IF (@CustomerIndex IN (158)) -- Khách hàng HIPC
BEGIN
	IF @IsInherit = 1
	BEGIN
		SET @sSQL = @sSQL + N'
		SELECT Distinct M2.Date, M2.Date AS StartDate
			, S2.MaterialID
			, A1.InventoryName AS MaterialName
			, M1.MachineID, M1.MachineName
			, S2.UnitID, A2.UnitName
			, M1.PhaseID, M1.PhaseName
			--, ROUND(((
			--CASE WHEN ISNULL(S2.Gsm, 0) > 0 THEN S2.Gsm 
			--	 WHEN ISNULL(S2.Sheets, 0) > 0 THEN S2.Sheets
			--	 WHEN ISNULL(S2.Ram, 0) > 0 THEN S2.Ram
			--	 WHEN ISNULL(S2.Kg, 0) > 0 THEN S2.Kg
			--	 WHEN ISNULL(S2.M2, 0) > 0 THEN S2.M2 END) / M3.Quantity) * ISNULL  (A5.Quantity,0),A0.QuantityDecimals) 
			--	AS MaterialQuantity
			, ISNULL(A5.Quantity,0) AS MaterialQuantity
			, M2.APK as APK_MT2143
		FROM MT2142 M1 WITH (NOLOCK)
			LEFT JOIN MT2143 M2 WITH (NOLOCK) ON M1.APK = M2.APKMaster
			LEFT JOIN MT2141 M3 WITH (NOLOCK) ON M3.APKMaster = M1.APKMaster
			LEFT JOIN AT1101 A0 WITH (NOLOCK) ON A0.DivisionID = M2.DivisionID
			LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON S1.VoucherNo = M1.VoucherNoProduct
			LEFT JOIN SOT2082 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.PhaseID = M1.PhaseID
			LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S2.MaterialID = A1.InventoryID
			LEFT JOIN AT1304 A2 WITH (NOLOCK) ON S2.UnitID = A2.UnitID
			LEFT JOIN (SELECT Product, Quantity FROM (
				SELECT [Quantity01], [Quantity02], [Quantity03], [Quantity04], [Quantity05], [Quantity06],  [Quantity07], [Quantity08], [Quantity09], [Quantity10]
					 , [Quantity11], [Quantity12], [Quantity13], [Quantity14], [Quantity15], [Quantity16],  [Quantity17], [Quantity18], [Quantity19], [Quantity20]
					 , [Quantity21], [Quantity22], [Quantity23], [Quantity24], [Quantity25], [Quantity26],  [Quantity27], [Quantity28], [Quantity29], [Quantity30]
					 , [Quantity31], [Quantity32], [Quantity33], [Quantity34], [Quantity35], [Quantity36],  [Quantity37], [Quantity38], [Quantity39], [Quantity40]
					 , [Quantity41], [Quantity42], [Quantity43], [Quantity44], [Quantity45], [Quantity46],  [Quantity47], [Quantity48], [Quantity49], [Quantity50]
					 , [Quantity51], [Quantity52], [Quantity53], [Quantity54], [Quantity55], [Quantity56],  [Quantity57], [Quantity58], [Quantity59], [Quantity60]
				FROM MT2142 WITH (NOLOCK) WHERE CONVERT(VARCHAR(50), APK) IN (''' + @APK_MT2142 + ''')) A
				UNPIVOT (Quantity FOR Product IN (
					   [Quantity01], [Quantity02], [Quantity03], [Quantity04], [Quantity05], [Quantity06],  [Quantity07], [Quantity08], [Quantity09], [Quantity10]
					 , [Quantity11], [Quantity12], [Quantity13], [Quantity14], [Quantity15], [Quantity16],  [Quantity17], [Quantity18], [Quantity19], [Quantity20]
					 , [Quantity21], [Quantity22], [Quantity23], [Quantity24], [Quantity25], [Quantity26],  [Quantity27], [Quantity28], [Quantity29], [Quantity30]
					 , [Quantity31], [Quantity32], [Quantity33], [Quantity34], [Quantity35], [Quantity36],  [Quantity37], [Quantity38], [Quantity39], [Quantity40]
					 , [Quantity41], [Quantity42], [Quantity43], [Quantity44], [Quantity45], [Quantity46],  [Quantity47], [Quantity48], [Quantity49], [Quantity50]
					 , [Quantity51], [Quantity52], [Quantity53], [Quantity54], [Quantity55], [Quantity56],  [Quantity57], [Quantity58], [Quantity59], [Quantity60])) AS UnPVT ) AS A5 ON A5.Product	  M2.Quantity '
		SET @sWhere = ' 
		WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) IN ('''	+@APK_MT2142 + ''') AND M2.APK IN (''' + @APK_MT2143 + ''')
		ORDER BY M2.Date ASC, M1.PhaseID, S2.MaterialID'
	END
	
	ELSE IF @IsInherit = 2
	BEGIN
		SET @sSQL = @sSQL + N'
		SELECT DISTINCT M2.Date AS StartDate
			 , M21.NodeID AS MaterialID
			 , A1.InventoryName AS MaterialName
			 , M21.UnitID, A2.UnitName
			 , M2.Date
			 , M1.MachineID
			 , M1.MachineName
			 , M1.PhaseID
			 , M1.PhaseName
			 , ISNULL(A5.Quantity,0) AS SL_KHSX, M3.Quantity AS SL_TP
			 , ROUND((ISNULL(A5.Quantity,0) * ISNULL(M21.QuantitativeValue,0)), A0.QuantityDecimals)	ASMaterialQuantity
			 , M2.APK as APK_MT2143
			 INTO #MT2142
		FROM MT2142 M1 WITH (NOLOCK)
			LEFT JOIN MT2143 M2 WITH (NOLOCK) ON M1.APK = M2.APKMaster
			LEFT JOIN MT2141 M3 WITH (NOLOCK) ON M3.APKMaster = M1.APKMaster AND M3.APK = ''' + @APK_MT2141 +'''
			LEFT JOIN AT1101 A0 WITH (NOLOCK) ON A0.DivisionID = M2.DivisionID
			LEFT JOIN OT2001 O1 WITH (NOLOCK) ON O1.VoucherNo = M1.VoucherNoProduct AND O1.OrderType = 1
			LEFT JOIN OT2002 O2 WITH (NOLOCK) ON M1.VoucherNoProduct = O2.SOrderID
			LEFT JOIN MT2120 M20 WITH (NOLOCK) ON  M20.NodeID = O2.InventoryID
			LEFT JOIN MT2121 M21 WITH (NOLOCK) ON M20.APK = M21.APK_2120 AND M21.NodeTypeID <> 0 AND M1.PhaseID=	M21.PhaseID
			LEFT JOIN AT1302 A1 WITH (NOLOCK) ON M21.NodeID = A1.InventoryID
			LEFT JOIN AT1304 A2 WITH (NOLOCK) ON M21.UnitID = A2.UnitID
			LEFT JOIN (SELECT Product, Quantity FROM (
				SELECT [Quantity01], [Quantity02], [Quantity03], [Quantity04], [Quantity05], [Quantity06],  [Quantity07], [Quantity08], [Quantity09], [Quantity10]
					, [Quantity11], [Quantity12], [Quantity13], [Quantity14], [Quantity15], [Quantity16],   [Quantity17], [Quantity18], [Quantity19], [Quantity20]
					, [Quantity21], [Quantity22], [Quantity23], [Quantity24], [Quantity25], [Quantity26],   [Quantity27], [Quantity28], [Quantity29], [Quantity30]
					, [Quantity31], [Quantity32], [Quantity33], [Quantity34], [Quantity35], [Quantity36],   [Quantity37], [Quantity38], [Quantity39], [Quantity40]
					, [Quantity41], [Quantity42], [Quantity43], [Quantity44], [Quantity45], [Quantity46],   [Quantity47], [Quantity48], [Quantity49], [Quantity50]
					, [Quantity51], [Quantity52], [Quantity53], [Quantity54], [Quantity55], [Quantity56],   [Quantity57], [Quantity58], [Quantity59], [Quantity60]
				FROM MT2142 WITH (NOLOCK) WHERE CONVERT(VARCHAR(50), APK) IN (''' + @APK_MT2142 + ''')) A
				UNPIVOT (Quantity FOR Product IN ([Quantity01], [Quantity02], [Quantity03], [Quantity04],   [Quantity05], [Quantity06], [Quantity07], [Quantity08], [Quantity09], [Quantity10]
					, [Quantity11], [Quantity12], [Quantity13], [Quantity14], [Quantity15], [Quantity16],   [Quantity17], [Quantity18], [Quantity19], [Quantity20]
					, [Quantity21], [Quantity22], [Quantity23], [Quantity24], [Quantity25], [Quantity26],   [Quantity27], [Quantity28], [Quantity29], [Quantity30]
					, [Quantity31], [Quantity32], [Quantity33], [Quantity34], [Quantity35], [Quantity36],   [Quantity37], [Quantity38], [Quantity39], [Quantity40]
					, [Quantity41], [Quantity42], [Quantity43], [Quantity44], [Quantity45], [Quantity46],   [Quantity47], [Quantity48], [Quantity49], [Quantity50]
					, [Quantity51], [Quantity52], [Quantity53], [Quantity54], [Quantity55], [Quantity56],   [Quantity57], [Quantity58], [Quantity59], [Quantity60])) AS UnPVT ) AS A5 ON A5.Product	   =M2.Quantity '
		SET @sWhere = ' 
		WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) IN ('''	+@APK_MT2142 + ''') AND M2.APK IN (''' + @APK_MT2143 + ''') AND M21.NodeID IS NOT NULL
		ORDER BY M21.NodeID, M2.Date ASC'
	
		SET @sSQL1 = @sSQL1 + N'
		DECLARE @ProductQuantity decimal (28,8)
	    SET @ProductQuantity = (SELECT SUM(ISNULL(SL_KHSX,0)) FROM(SELECT Distinct StartDate, SL_KHSX FROM#MT2142	WITH (NOLOCK)) A)
	
		SELECT M.*, @ProductQuantity as ProductQuantity
		FROM #MT2142 M WITH (NOLOCK)
		'
	
	END
	
	EXEC (@sSQL + @sJoin + @sWhere + @sSQL1)
	PRINT(@sSQL + @sJoin + @sWhere + @sSQL1)
END
ELSE
BEGIN
	IF @APK_MT2142 IS NULL
		SET @APK_MT2142 = ''
	IF @APK_MT2143 IS NULL
		SET @APK_MT2143 = ''
	IF @APK_MT2141 IS NULL
		SET @APK_MT2141 = ''
	SET @sSQL = @sSQL + N'
	SELECT Distinct M2.Date, M2.Date AS StartDate
		, M1.MaterialID
		, A1.InventoryName AS MaterialName
		, M1.MachineID, M1.MachineName
		, M1.UnitID, A2.UnitName
		, M1.PhaseID, M1.PhaseName
		, MT23.APK AS APK_NodeParent
		--, ROUND(((
		--CASE WHEN ISNULL(S2.Gsm, 0) > 0 THEN S2.Gsm 
		--	 WHEN ISNULL(S2.Sheets, 0) > 0 THEN S2.Sheets
		--	 WHEN ISNULL(S2.Ram, 0) > 0 THEN S2.Ram
		--	 WHEN ISNULL(S2.Kg, 0) > 0 THEN S2.Kg
		--	 WHEN ISNULL(S2.M2, 0) > 0 THEN S2.M2 END) / M3.Quantity) * ISNULL(A5.Quantity,0),A0.QuantityDecimals) 
		--	AS MaterialQuantity
		, ISNULL(A5.Quantity,0) AS MaterialQuantity
		, M2.APK as APK_MT2143
		, M1.APK 
		, CONVERT(VARCHAR(50), M3.APK_BomVersion) AS APK_BomVersion
		, M3.nvarchar01
	
	FROM MT2142 M1 WITH (NOLOCK)
		LEFT JOIN MT2143 M2 WITH (NOLOCK) ON M1.APK = M2.APKMaster
		LEFT JOIN MT2141 M3 WITH (NOLOCK) ON M3.APKMaster = M1.APKMaster AND M3.APK = M1.APK_MT2141
		LEFT JOIN AT1101 A0 WITH (NOLOCK) ON A0.DivisionID = M2.DivisionID
		LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON S1.VoucherNo = M1.VoucherNoProduct
		LEFT JOIN SOT2082 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.PhaseID = M1.PhaseID
		LEFT JOIN AT1302 A1 WITH (NOLOCK) ON M1.MaterialID = A1.InventoryID
		LEFT JOIN AT1304 A2 WITH (NOLOCK) ON M1.UnitID = A2.UnitID
		LEFT JOIN (SELECT Product, Quantity FROM (
			SELECT [Quantity01], [Quantity02], [Quantity03], [Quantity04], [Quantity05], [Quantity06],[Quantity07],		[Quantity08], [Quantity09], [Quantity10]
				 , [Quantity11], [Quantity12], [Quantity13], [Quantity14], [Quantity15], [Quantity16],[Quantity17],		[Quantity18], [Quantity19], [Quantity20]
				 , [Quantity21], [Quantity22], [Quantity23], [Quantity24], [Quantity25], [Quantity26],[Quantity27],		[Quantity28], [Quantity29], [Quantity30]
				 , [Quantity31], [Quantity32], [Quantity33], [Quantity34], [Quantity35], [Quantity36],[Quantity37],		[Quantity38], [Quantity39], [Quantity40]
				 , [Quantity41], [Quantity42], [Quantity43], [Quantity44], [Quantity45], [Quantity46],[Quantity47],		[Quantity48], [Quantity49], [Quantity50]
				 , [Quantity51], [Quantity52], [Quantity53], [Quantity54], [Quantity55], [Quantity56],[Quantity57],		[Quantity58], [Quantity59], [Quantity60]
			FROM MT2142 WITH (NOLOCK) WHERE CONVERT(VARCHAR(50), APK) IN (''' + @APK_MT2142 + ''')) A
			UNPIVOT (Quantity FOR Product IN (
				   [Quantity01], [Quantity02], [Quantity03], [Quantity04], [Quantity05], [Quantity06],[Quantity07],		[Quantity08], [Quantity09], [Quantity10]
				 , [Quantity11], [Quantity12], [Quantity13], [Quantity14], [Quantity15], [Quantity16],[Quantity17],		[Quantity18], [Quantity19], [Quantity20]
				 , [Quantity21], [Quantity22], [Quantity23], [Quantity24], [Quantity25], [Quantity26],[Quantity27],		[Quantity28], [Quantity29], [Quantity30]
				 , [Quantity31], [Quantity32], [Quantity33], [Quantity34], [Quantity35], [Quantity36],[Quantity37],		[Quantity38], [Quantity39], [Quantity40]
				 , [Quantity41], [Quantity42], [Quantity43], [Quantity44], [Quantity45], [Quantity46],[Quantity47],		[Quantity48], [Quantity49], [Quantity50]
				 , [Quantity51], [Quantity52], [Quantity53], [Quantity54], [Quantity55], [Quantity56],[Quantity57],		[Quantity58], [Quantity59], [Quantity60])) 
				 AS UnPVT ) 
				 AS A5 ON A5.Product = M2.Quantity 
		LEFT JOIN MT2123 MT23 WITH (NOLOCK) ON MT23.DivisionID = M1.DivisionID AND MT23.NodeID = M1.MaterialID AND	CONVERT(VARCHAR(50), MT23.APK_2120) = M3.APK_BomVersion'
	SET @sWhere = ' 
	WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') 
		AND CONVERT(VARCHAR(50), M1.APK) IN (''' + @APK_MT2142 + ''') 
		AND CONVERT(VARCHAR(50), M2.APK) IN (''' + @APK_MT2143 + ''')
	ORDER BY M2.Date ASC, M1.PhaseID, M1.MaterialID'
	
	EXEC (@sSQL + @sJoin + @sWhere + @sSQL1)
	PRINT(@sSQL + @sJoin + @sWhere + @sSQL1)
END





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
