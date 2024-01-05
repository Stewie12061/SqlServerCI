IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP21402]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP21402]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- In bao cao Tổng hợp kế hoạch sản xuất - MR21401
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
---- Thêm mới ON 26/04/2021 by Trọng Kiên
---- Cập nhật ON 19/07/2021 by Đình Ly
-- <Example> EXEC MP21402 'AS', '', 1, '2017-01-01', '2017-06-30', '06/2017'',''06/2017', 'B-D-0000000000000002', 'KH0009', 'Hoang', 'VU', '', 'VU' 

CREATE PROCEDURE [dbo].[MP21402] (
	@DivisionID			NVARCHAR(50),	--Biến môi trường
	@DivisionIDList		NVARCHAR(MAX),	--Giá trị truyền Dropdown đơn vị
	@IsDate				TINYINT,		--1: Theo ngày; 0: Theo kỳ
	@FromDate			DATETIME, 
	@ToDate				DATETIME, 
	@PeriodIDList		NVARCHAR(2000),
	@FromAccountID		NVARCHAR(MAX),
	@ToAccountID		NVARCHAR(MAX),
	@FromInventoryID	NVARCHAR(MAX),
	@ToInventoryID		NVARCHAR(MAX),
	@OrderStatus		NVARCHAR(MAX),					
	@UserID				NVARCHAR(50)
)
AS
BEGIN
	DECLARE @sSQL NVARCHAR(max),
			@sSQL01 NVARCHAR(MAX),
			@sWhere NVARCHAR(max),
			@sSELECT nvarchar(max),
			@sGROUPBY nvarchar(max),
			@PhaseCut VARCHAR(50),
			@PhaseWave VARCHAR(50)

	SET @PhaseCut = (SELECT ISNULL(CutPhaseID, '') FROM CRMT00000 WHERE DivisionID = ''+ @DivisionID +'')
	SET @PhaseWave = (SELECT ISNULL(WavePhaseID, '') FROM CRMT00000 WHERE DivisionID = ''+ @DivisionID +'')
	SET @sWhere = ''

	--Search theo đơn vị @DivisionIDList trống thì lấy biến môi trường @DivisionID
	IF ISNULL(@DivisionIDList, '') != ''
		SET @sWhere = ' M1.DivisionID IN ('''+@DivisionIDList+''',''@@@'')'
	ELSE 
		SET @sWhere = ' M1.DivisionID in( N'''+@DivisionID+''',''@@@'')'	

	--Search theo điều điện thời gian
	IF @IsDate = 1	
	BEGIN
		SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR,M2.VoucherDate,112) BETWEEN '''+CONVERT(VARCHAR,@FromDate,112)+''' AND '''+CONVERT(VARCHAR,@ToDate,112)+''''
	END
	ELSE
	BEGIN
		SET @sWhere = @sWhere + ' AND (Case When  Month(M2.VoucherDate) <10 then ''0''+rtrim(ltrim(str(Month(M2.VoucherDate))))+''/''+ltrim(Rtrim(str(Year(M2.VoucherDate)))) 
										Else rtrim(ltrim(str(Month(M2.VoucherDate))))+''/''+ltrim(Rtrim(str(Year(M2.VoucherDate)))) End) IN ('''+@PeriodIDList+''')'
	END

	--Search theo khách hàng (Dữ liệu khách hàng nhiều nên dùng control từ khách hàng, đến khách hàng)
	IF ISNULL(@FromAccountID, '')!= '' and ISNULL(@ToAccountID, '') = ''
		SET @sWhere = @sWhere + ' AND ISNULL(M1.ObjectID, '''') > = N'''+@FromAccountID +''''
	ELSE IF ISNULL(@FromAccountID, '') = '' and ISNULL(@ToAccountID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M1.ObjectID, '''') < = N'''+@ToAccountID +''''
	ELSE IF ISNULL(@FromAccountID, '') != '' and ISNULL(@ToAccountID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M1.ObjectID, '''') BETWEEN N'''+@FromAccountID+''' AND N'''+@ToAccountID+''''

	--Search theo mặt hàng (Dữ liệu mặt hàng nhiều nên dùng control từ mặt hàng, đến mặt hàng)
	IF ISNULL(@FromInventoryID, '')!= '' and ISNULL(@ToInventoryID, '') = ''
		SET @sWhere = @sWhere + ' AND ISNULL(M1.InventoryID, '''') > = N'''+@FromInventoryID +''''
	ELSE IF ISNULL(@FromInventoryID, '') = '' and ISNULL(@ToInventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M1.InventoryID, '''') < = N'''+@ToInventoryID +''''
	ELSE IF ISNULL(@FromInventoryID, '') != '' and ISNULL(@ToInventoryID, '') != ''
		SET @sWhere = @sWhere + ' AND ISNULL(M1.InventoryID, '''') BETWEEN N'''+@FromInventoryID+''' AND N'''+@ToInventoryID+''''

	-- Search theo trạng thái phiếu thông tin sản xuất
	IF ISNULL(@OrderStatus, '') <> ''
		SET @sWhere = @sWhere + ' AND ISNULL(M1.StatusID, 0) IN (''' + @OrderStatus + ''')'

--Lấy kết quả
	
	SET @sSQL = N'
	SELECT M2.VoucherNo
		, M1.VoucherNoProduct
		, M1.InventoryID
		, M1.InventoryName
		, M1.Quantity
		, M1.DateDelivery
		, '''' AS TypePaper
		, S3.Size AS SizePaper
		, S3.Cut AS CutPaper
		, '''' AS SizeOut
		, '''' AS CutOut
		, S2.Length, S2.Width, S2.Height
		, M1.StartDate
		, M1.EndDate
		, S4.RunWavePaper
		, A1.InventoryName AS MaterialName
		, S4.QuantityRunWave AS SheetQuantity
		, S4.MaterialID, S4.Gsm, S4.Kg, M1.ObjectName
	INTO #TeMP21402
	FROM MT2141 M1 WITH (NOLOCK)
		LEFT JOIN MT2140 M2 WITH (NOLOCK) ON M1.APKMaster = M2.APK
		LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON M1.VoucherNoProduct = S1.VoucherNo
		LEFT JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster
		LEFT JOIN SOT2082 S3 WITH (NOLOCK) ON S1.APK = S3.APKMaster AND S3.PhaseID = ''' + @PhaseCut + '''
		LEFT JOIN SOT2082 S4 WITH (NOLOCK) ON S1.APK = S4.APKMaster AND S4.PhaseID = ''' + @PhaseWave +'''
		LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S4.MaterialID = A1.InventoryID
	WHERE '

	SET @sSQL01 = N'
	DECLARE @TempKHSX TABLE (VoucherNoProduct VARCHAR(50), SheetQuantity DECIMAL(28,0), RunWavePaper NVARCHAR(MAX))
	DECLARE @Cur CURSOR,
		@VoucherNoProduct VARCHAR(50) = '''',
		@SheetQuantity DECIMAL(28,0),
		@SUMQuantity DECIMAL(28,0) = 0,
		@RunWavePaper VARCHAR(MAX) = N'''',
		@LRunWavePaper NVARCHAR(MAX) = N'''',
		@VoucherNoProductDefaul VARCHAR(50) = (SELECT TOP 1 VoucherNoProduct FROM #TeMP21402),
		@CountData INT = (SELECT COUNT(*) FROM #TeMP21402)
							 
	SET @Cur = CURSOR SCROLL KEYSET FOR
	SELECT VoucherNoProduct, RunWavePaper, SheetQuantity FROM #TeMP21402
	OPEN @Cur
	FETCH NEXT FROM @Cur INTO @VoucherNoProduct, @RunWavePaper, @SheetQuantity
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (@VoucherNoProduct = @VoucherNoProductDefaul)
		BEGIN
		print @SUMQuantity
			SET @VoucherNoProduct = @VoucherNoProduct
			SET @SUMQuantity = @SUMQuantity + @SheetQuantity
			SET @LRunWavePaper = @LRunWavePaper + @RunWavePaper 
			IF (@CountData = 1)
			BEGIN
			INSERT INTO @TempKHSX VALUES (@VoucherNoProductDefaul, @SUMQuantity,@LRunWavePaper)
			END
		END
		ELSE
		BEGIN
			INSERT INTO @TempKHSX VALUES (@VoucherNoProductDefaul, @SUMQuantity, @LRunWavePaper)
			SET @LRunWavePaper = N''''
			SET @SUMQuantity = 0
			SET @VoucherNoProductDefaul = @VoucherNoProduct
			SET @SUMQuantity = @SUMQuantity + @SheetQuantity
			SET @LRunWavePaper = @LRunWavePaper + @RunWavePaper 
							 		  
		END
	FETCH NEXT FROM @Cur INTO @VoucherNoProduct, @RunWavePaper, @SheetQuantity
	SET @CountData = @CountData - 1
	END
	CLOSE @Cur

	SELECT DISTINCT T1.VoucherNo
		, T1.VoucherNoProduct
		, T1.InventoryID
		, T1.InventoryName
		, T1.Quantity
		, T1.DateDelivery
		, T1.TypePaper
		, T1.ObjectName
		, T1.Gsm, T1.Kg
		, T1.SizePaper
		, T1.CutPaper
		, T1.SizeOut
		, T1.CutOut
		, T1.Length
		, T1.Width
		, T1.Height
		, T1.StartDate
		, T1.EndDate
		, T2.RunWavePaper
		, T1.MaterialName
		, T1.MaterialID
		, T2.SheetQuantity
	FROM #TeMP21402 T1
		LEFT JOIN @TempKHSX T2 ON T1.VoucherNoProduct = T2.VoucherNoProduct
	ORDER BY T1.VoucherNo, T1.VoucherNoProduct

	DROP TABLE #TeMP21402'

	EXEC (@sSQL + @sWhere + @sSQL01)
	PRINT (@sSQL + @sWhere + @sSQL01)
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
