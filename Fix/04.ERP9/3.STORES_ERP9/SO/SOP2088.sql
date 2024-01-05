IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP2088]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[SOP2088]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




-- <Summary>
---- Load thông tin bán thành phẩm từ Đơn hàng bán.
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
----
-- <History>
----Created by Văn Tài on 12/07/2023
----Modify	by Văn Tài	on 12/04/2023 : 
----Modify by: Đức Tuyên on: 25/07/2023: Xử lý nghiệp vụ thông tin sản xuất(MAITHU)
-- <Example>
---- 
/*-- <Example>
    
	EXEC SOP2088 @DivisionID = 'MT', 
			@UserID = 'MINHTHU', 
			@TranMonth = 7, 
			@TranYear = 2023, 
			@SOrderID = 'e180b52a-a4f9-46fb-aa6e-35599f906ff2', 
			@Mode = 1

	Node:
	- Hiện tại chỉ có mode 1 để xử lý cho MAITHU luồng kế thừa: Đơn hàng bán / Báo giá / Dự toán / Yêu cầu khách hàng.

	- Dự toán: Estimate
	- Báo giá: Quotation
*/

CREATE PROCEDURE [dbo].[SOP2088]
( 
     @DivisionID VARCHAR(50),
     @UserID VARCHAR(50),
	 @TranMonth	AS INT,
	 @TranYear	AS INT,
	 @SOrderID AS VARCHAR(50),
	 @DetailAPK AS VARCHAR(50),
	 @Mode AS INT = 1			--- Mode: 1 --- Đơn hàng bán -> Lấy về Yêu cầu khách hàng để lấy BoomVersion. 
								--- Mode: 2 --- kế thừa TTSX cũ : Giữ Boom version, không giữ thông tin Đơn hàng bán.
)
AS 
BEGIN
	
	DECLARE @InventoryID VARCHAR(50) = NULL; --- Thành phẩm của bộ định mức.

	DECLARE @APK_MT2122 VARCHAR(50) = NULL;
	DECLARE @APK_MT2120 VARCHAR(50) = NULL;
	DECLARE @Version	VARCHAR(50) = NULL;
	DECLARE @APK_BomVersion	VARCHAR(50) = NULL;
	DECLARE @APKMInherited	VARCHAR(50) = NULL;

	/** 
		Bộ danh sách phiếu dự toán liên quan.
		OT2102.InheritTableID = 'CRMT2110'
		OT2102.InheritVoucherID = CRMT2110.APK
		OT2102.InheritTransactionID = CRMT2110.APK
		--- Đang trùng nhau APK master (Vì đang gộp 2 Dự toán vào chung 1 details Báo giá
		--- Sẽ không tìm được phiếu thứ 2. Cần phải dựa vào trùng mã kế thừa.
		--- BOM có BTP trùng và khác nhau quy cách: Dài, Rộng, Cao.
	**/ 
	CREATE TABLE #SOP2088_ESTIMATES
	(
		SemiOrders				INT NULL
		, VoucherNo				VARCHAR(50) NULL
		, VoucherID				VARCHAR(50) NULL
		, TableInherited		VARCHAR(50) NULL
		, ProductID				VARCHAR(50) NULL
		, BOMVersion			INT NULL
		, APK_BomVersion		VARCHAR(50) NULL
		, SemiProduct			VARCHAR(50) NULL
		, APKMInherited			VARCHAR(50) NULL		--- APK YCKH.
		, APKDInherited			VARCHAR(50) NULL		--- APK Node MT2123.
		, PaperTypeID			VARCHAR(50) NULL
		, [Length]				NVARCHAR(50)
		, [Width]				NVARCHAR(50)
		, [Height]				NVARCHAR(50)
		, PrintSize				NVARCHAR(50)
		, CutSize				NVARCHAR(50)
		, LengthPaper			NVARCHAR(50)
		, WithPaper				NVARCHAR(50)
		, Package				DECIMAL(28, 8)
		, PrintNumber			INT
		, SideColor1			TINYINT
		, ColorPrint01			NVARCHAR(250)
		, SideColor2			TINYINT
		, ColorPrint02			NVARCHAR(250)
		, InvenSheetPrint01		DECIMAL(28, 8)
		, InvenSheetTemplate	DECIMAL(28, 8)
		, PackageAmount			DECIMAL(28, 8)
		, ActualQuantity		DECIMAL(28, 8)
		, OffsetQuantity		DECIMAL(28, 8)
		, KindPaper				NVARCHAR(50)
		, OffsetSize			DECIMAL(28, 8)
		, OffsetCut				DECIMAL(28, 8)
		, InvenSheetPrint02		DECIMAL(28, 8)
		, SheetPrintQuantity	DECIMAL(28, 8)
		, RPaper				DECIMAL(28, 8)
		, FilmDate				DATETIME
		, FilmStatus			NVARCHAR(50)
		, LengthFilm			DECIMAL(28, 8)
		, WidthFilm				DECIMAL(28, 8)
		, AmountLoss			DECIMAL(28, 8)
		, PercentLoss			DECIMAL(28, 8)
		, StatusMold			DECIMAL(28, 8)
		, CartonQuantity		DECIMAL(28, 8)
		, SplitSheets			DECIMAL(28, 8)
		, CartonTotal			DECIMAL(28, 8)
		, AccretionSize			DECIMAL(28, 8)
		, AccretionCut			DECIMAL(28, 8)
		, WavePaperSize			DECIMAL(28, 8)
		, WavePaperCut			DECIMAL(28, 8)
		, Notes					NVARCHAR(250)
		, TotalVariableFee		DECIMAL(28, 8)
		, PercentCost			DECIMAL(28, 8)
		, Cost					DECIMAL(28, 8)
		, PercentProfit			DECIMAL(28, 8)
		, Profit				DECIMAL(28, 8)
		, InvenUnitPrice		DECIMAL(28, 8)
		, SquareMetersPrice		DECIMAL(28, 8)
		, ExchangeRate			DECIMAL(28, 8)
		, CurrencyID			NVARCHAR(50)
		, [FileName]			NVARCHAR(50)
		, ContentSampleDate		NVARCHAR(250)
		, ColorSampleDate		NVARCHAR(250)
		, MTSignedSampleDate	NVARCHAR(250)
		, FileLength			DECIMAL(28, 8)
		, FileWidth				DECIMAL(28, 8)
		, FileSum				DECIMAL(28, 8)
		, [Include]				NVARCHAR(50)
		, FileUnitID			VARCHAR(25)
		, PrintTypeID			VARCHAR(25)
		, TotalProfitCost		DECIMAL(28, 8)
		, TotalAmount			DECIMAL(28, 8)
		, TotalSetupTime		DECIMAL(28, 8)
	)

	IF (@Mode = 1)
	BEGIN

		-- Lấy thành phẩm
		SET @InventoryID = (
							SELECT TOP 1 OT02.InventoryID 
								FROM OT2002 OT02 WITH (NOLOCK) 
								WHERE OT02.DivisionID = @DivisionID
										AND CONVERT(VARCHAR(50), OT02.SOrderID) = @SOrderID
										AND CONVERT(VARCHAR(50), OT02.APK) = @DetailAPK
							)

		IF (ISNULL(@InventoryID, '') = '') BEGIN PRINT (N'Không thể tìm thấy thành phẩm ở đơn hàng bán.'); END

		--- Lấy APK: YCKH kế thừa của Dự toán. Từ đó lấy N dự toán liên quan.
		SET @APKMInherited =	(
									SELECT TOP 1 CT11.APKMInherited
									FROM OT2002 OT02 WITH (NOLOCK)
									-- Báo giá
									INNER JOIN OT2102 OT22 WITH (NOLOCK) ON OT22.DivisionID = OT02.DivisionID
																			AND OT22.InheritTableID = 'CRMT2110'
																			AND OT22.APK = OT02.QuotationID
									-- Dự toán
									INNER JOIN CRMT2111 CT11 WITH (NOLOCK) ON CT11.DivisionID = OT02.DivisionID
																				AND CT11.APKMaster = OT22.InheritVoucherID
									INNER JOIN CRMT2110 CT10 WITH (NOLOCK) ON CT10.DivisionID = CT11.DivisionID
																				AND ISNULL(CT10.DeleteFlg, 0) = 0
																				AND CT10.APK = CT11.APKMaster																		
									WHERE 
										OT02.DivisionID = @DivisionID
										AND CONVERT(VARCHAR(50), OT02.SOrderID) = @SOrderID
										AND CONVERT(VARCHAR(50), OT02.APK) = @DetailAPK
								)
		IF ISNULL(@APKMInherited, '') = '' PRINT (N'Không tìm được APK của Yêu cầu khách hàng gốc');
		PRINT (@APKMInherited)
		--- Lấy thông tin BOM Version
		BEGIN
			SELECT TOP 1 @Version = CONVERT(INT, ISNULL(MT22.[Version], -1)), @APK_BomVersion = MT22.APK
			-- Yêu cầu khách hàng : Details NVL
			FROM CRMT2104 CT04 WITH (NOLOCK)
			--INNER JOIN CRMT2100 CT00 WITH (NOLOCK) ON CT00.DivisionID = CT04.DivisionID
			--											AND ISNULL(CT00.DeleteFlg, 0) = 0

			---- BOM Version
			--INNER JOIN MT2123 MT23 WITH (NOLOCK) ON MT23.DivisionID = CT04.DivisionID
			--										--- Không quan tâm BTP, NVL
			--										--AND MT23.APKMaster = CT04.NodeParent
			--										AND MT23.APK = CT04.APKNodeParent
			--INNER JOIN MT2122 MT22 WITH (NOLOCK) ON MT22.DivisionID = CT04.DivisionID
			--										AND MT22.APK = MT23.APK_2120
			INNER JOIN CRMT2100 CT00 WITH (NOLOCK) ON CT00.DivisionID = CT04.DivisionID
														AND ISNULL(CT00.DeleteFlg, 0) = 0
														AND CT00.APK = CT04.APKMaster
			INNER JOIN CRMT2101 CT01 WITH (NOLOCK) ON CT01.DivisionID = CT04.DivisionID
														AND CT01.APKMaster = CT04.APKMaster

			-- BOM Version
			INNER JOIN MT2122 MT22 WITH (NOLOCK) ON MT22.DivisionID = CT04.DivisionID
													AND MT22.APK = CT01.APK_BomVersion
			
			WHERE
				CT04.DivisionID = @DivisionID
				AND CT04.APKMaster = @APKMInherited
				--- Không quan tâm BTP, NVL
				-- AND ISNULL(CT04.NodeTypeID, 0) = 1
		END		

		IF ISNULL(@Version, -1) = -1 BEGIN PRINT (N'Không tìm được Version của bộ BOM.'); END
		PRINT(@Version)
		PRINT (@APK_BomVersion)

		--- Lấy kết quả thành phẩm của các dự toán liên quan.
		INSERT INTO #SOP2088_ESTIMATES
		(
			SemiOrders
			, VoucherID
			, VoucherNo
			, TableInherited
			, ProductID
			, BOMVersion
			, APK_BomVersion
			, SemiProduct
			, APKMInherited
			, APKDInherited
			, PaperTypeID
			, [Length]
			, [Width]
			, [Height]
			, PrintSize			
			, CutSize			
			, LengthPaper		
			, WithPaper			
			, Package			
			, PrintNumber		
			, SideColor1		
			, ColorPrint01		
			, SideColor2		
			, ColorPrint02		
			, InvenSheetPrint01	
			, InvenSheetTemplate
			, PackageAmount
			, ActualQuantity
			, OffsetQuantity	
			, KindPaper			
			, OffsetSize		
			, OffsetCut			
			, InvenSheetPrint02	
			, SheetPrintQuantity
			, RPaper			
			, FilmDate			
			, FilmStatus		
			, LengthFilm		
			, WidthFilm			
			, AmountLoss		
			, PercentLoss		
			, StatusMold		
			, CartonQuantity	
			, SplitSheets		
			, CartonTotal		
			, AccretionSize		
			, AccretionCut		
			, WavePaperSize		
			, WavePaperCut		
			, Notes				
			, TotalVariableFee	
			, PercentCost		
			, Cost				
			, PercentProfit		
			, Profit			
			, InvenUnitPrice	
			, SquareMetersPrice	
			, ExchangeRate		
			, CurrencyID		
			, [FileName]		
			, ContentSampleDate	
			, ColorSampleDate	
			, MTSignedSampleDate
			, FileLength		
			, FileWidth			
			, FileSum			
			, [Include]			
			, FileUnitID		
			, PrintTypeID		
			, TotalProfitCost	
			, TotalAmount		
			, TotalSetupTime
		)
		SELECT 
			MT23.NodeOrder	AS SemiOrders
			, CT10.APK
			, CT10.VoucherNo
			, CT10.TableInherited
			, @InventoryID			AS ProductID
			, @Version				AS BOMVersion
			, @APK_BomVersion		AS APK_BomVersion
			, CT10.SemiProduct		
			, CT11.APKMInherited
			, CT11.APKDInherited
			, CT11.PaperTypeID
			, CT11.[Length]			
			, CT11.[Width]			
			, CT11.[Height]
			, CT11.PrintSize				
			, CT11.CutSize				
			, CT11.LengthPaper			
			, CT11.WithPaper				
			, CT11.Package				
			, CT11.PrintNumber			
			, CT11.SideColor1			
			, CT11.ColorPrint01			
			, CT11.SideColor2			
			, CT11.ColorPrint02			
			, CT11.InvenSheetPrint01		
			, CT11.InvenSheetTemplate	
			, CT11.PackageAmount
			, CT11.ActualQuantity
			, CT11.OffsetQuantity		
			, CT11.KindPaper				
			, CT11.OffsetSize			
			, CT11.OffsetCut				
			, CT11.InvenSheetPrint02		
			, CT11.SheetPrintQuantity	
			, CT11.RPaper				
			, CT11.FilmDate				
			, CT11.FilmStatus			
			, CT11.LengthFilm			
			, CT11.WidthFilm				
			, CT11.AmountLoss			
			, CT11.PercentLoss			
			, CT11.StatusMold			
			, CT11.CartonQuantity		
			, CT11.SplitSheets			
			, CT11.CartonTotal			
			, CT11.AccretionSize			
			, CT11.AccretionCut			
			, CT11.WavePaperSize			
			, CT11.WavePaperCut			
			, CT11.Notes					
			, CT11.TotalVariableFee		
			, CT11.PercentCost			
			, CT11.Cost					
			, CT11.PercentProfit			
			, CT11.Profit				
			, CT11.InvenUnitPrice		
			, CT11.SquareMetersPrice		
			, CT11.ExchangeRate			
			, CT11.CurrencyID			
			, CT11.[FileName]			
			, CT11.ContentSampleDate		
			, CT11.ColorSampleDate		
			, CT11.MTSignedSampleDate	
			, CT11.FileLength			
			, CT11.FileWidth				
			, CT11.FileSum				
			, CT11.[Include]				
			, CT11.FileUnitID			
			, CT11.PrintTypeID
			, CT11.TotalProfitCost
			, CT11.TotalAmount
			, CT11.TotalSetupTime
		FROM CRMT2111 CT11 WITH (NOLOCK)
		INNER JOIN CRMT2110 CT10 WITH (NOLOCK) ON CT10.DivisionID = CT11.DivisionID
													AND ISNULL(CT10.DeleteFlg, 0) = 0
													AND CT10.APK = CT11.APKMaster
		INNER JOIN MT2123 MT23 WITH (NOLOCK) ON MT23.DivisionID = CT11.DivisionID
												AND MT23.APK = CT11.APKDInherited
		WHERE CT11.DivisionID = @DivisionID
				AND CT11.APKMInherited = @APKMInherited
		ORDER BY MT23.NodeOrder
				, CT10.SemiProduct

		--- Join Name và trả về kết quả.
		SELECT 
			CONVERT(VARCHAR(50), NEWID())	AS APK
			, S88.SemiOrders
			, @DivisionID			AS DivisionID
			, S88.VoucherNo
			, S88.VoucherID
			, S88.TableInherited
			, S88.ProductID
			, S88.BOMVersion
			, S88.APK_BomVersion
			, S88.SemiProduct
			, AT02.InventoryName	AS SemiProductName
			, S88.APKMInherited
			, S88.APKDInherited
			, S88.PaperTypeID
			, MT92.[Description]	AS PaperTypeName
			, S88.[Length]
			, S88.[Width]
			, S88.[Height]
			, S88.PrintSize
			, S88.CutSize
			, S88.LengthPaper
			, S88.WithPaper
			, S88.Package
			, S88.PrintNumber		
			, S88.SideColor1
			, S88.ColorPrint01		
			, S88.SideColor2		
			, S88.ColorPrint02		
			, S88.InvenSheetPrint01	
			, S88.InvenSheetTemplate
			, S88.PackageAmount		
			, S88.ActualQuantity
			, S88.OffsetQuantity	
			, S88.KindPaper			
			, S88.OffsetSize		
			, S88.OffsetCut			
			, S88.InvenSheetPrint02	
			, S88.SheetPrintQuantity
			, S88.RPaper			
			, S88.FilmDate			
			, S88.FilmStatus
			, (CASE WHEN S88.FilmStatus IS NULL THEN NULL
					WHEN ISNULL(S88.FilmStatus, 0) = 0 THEN N'Cũ' 
					ELSE N'Mới' 
					END) AS FilmStatusName
			, S88.PrintTypeID		
			, C2.[Description]					AS PrintTypeName
			, S88.LengthFilm
			, S88.WidthFilm
			, S88.AmountLoss
			, S88.PercentLoss
			, S88.StatusMold
			, (CASE WHEN S88.StatusMold IS NULL THEN NULL
					WHEN ISNULL(S88.StatusMold, 0) = 0 THEN N'Cũ'
					ELSE N'Mới'
					END) AS StatusMoldName
			, S88.CartonQuantity
			, S88.SplitSheets
			, S88.CartonTotal
			, S88.AccretionSize
			, S88.AccretionCut
			, S88.WavePaperSize		
			, S88.WavePaperCut		
			, S88.Notes				
			, S88.TotalVariableFee	
			, S88.PercentCost		
			, S88.Cost				
			, S88.PercentProfit		
			, S88.Profit			
			, S88.InvenUnitPrice	
			, S88.SquareMetersPrice	
			, S88.ExchangeRate		
			, S88.CurrencyID		
			, S88.[FileName]		
			, S88.ContentSampleDate	
			, S88.ColorSampleDate	
			, S88.MTSignedSampleDate
			, S88.FileLength		
			, S88.FileWidth			
			, S88.FileSum			
			, S88.[Include]			
			, S88.FileUnitID		
			, MT91.[Description]				AS FileUnitName
			, S88.TotalProfitCost	
			, S88.TotalAmount		
			, S88.TotalSetupTime
			, 0									AS ApproveCutRollStatusID
			, OT91.[Description]				AS ApproveCutRollStatusName
			, 0									AS ApproveWaveStatusID
			, OT91.[Description]				AS ApproveWaveStatusName
			, S88.VoucherID						AS InheritAPKMaster
		FROM #SOP2088_ESTIMATES S88
		LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN ('@@@', @DivisionID)
													AND AT02.InventoryID = S88.SemiProduct
		LEFT JOIN OOT0099 OT91 WITH (NOLOCK) ON OT91.CodeMaster = 'Status'
													AND ISNULL(OT91.[Disabled], 0) = 0
													AND OT91.ID1 = '0'
		LEFT JOIN CRMT0099 C2 WITH (NOLOCK) ON C2.CodeMaster = 'CRMF2111.PrintTypeID'
													AND ISNULL(C2.[Disabled], 0) = 0
													AND C2.ID = S88.PrintTypeID
		LEFT JOIN MT0099 MT91 WITH (NOLOCK) ON MT91.CodeMaster = 'UnitSize'
													AND ISNULL(MT91.[Disabled], 0) = 0
													AND MT91.ID = S88.FileUnitID
		LEFT JOIN CRMT0099 MT92 WITH (NOLOCK) ON MT92.CodeMaster = 'CRMT00000022'
													AND ISNULL(MT92.[Disabled], 0) = 0
													AND MT92.ID = S88.PaperTypeID
		ORDER BY S88.SemiOrders
	END

	IF (@Mode = 2)
	BEGIN
		-- Lấy thành phẩm
		SET @InventoryID = (
								SELECT TOP 1 OT02.InventoryID 
									FROM SOT2080 OT02 WITH (NOLOCK) 
									WHERE OT02.DivisionID = @DivisionID
											--- APK phiếu TTSX
											AND OT02.APK = @SOrderID
							)

		IF (ISNULL(@InventoryID, '') = '') BEGIN PRINT (N'Không thể tìm thấy thành phẩm ở đơn hàng bán.'); END

		--- Không cần tìm mã YCKH vì đã kế thừa TTSX luôn.
		--- IF ISNULL(@APKMInherited, '') = '' PRINT (N'Không tìm được APK của Yêu cầu khách hàng gốc');

		--- Lấy thông tin BOM Version
		SET @Version = (
							SELECT TOP 1 MT22.[Version]
							-- Yêu cầu khách hàng : Details NVL
							FROM SOT2081 ST81 WITH (NOLOCK)						
							-- BOM Version
							INNER JOIN MT2123 MT23 WITH (NOLOCK) ON MT23.DivisionID = ST81.DivisionID
																	--- Không quan tâm BTP, NVL
																	--AND MT23.APKMaster = CT04.NodeParent
																	AND MT23.APK = ST81.APKDInherited
							INNER JOIN MT2122 MT22 WITH (NOLOCK) ON MT22.DivisionID = ST81.DivisionID
																	AND MT22.APK = MT23.APK_2120
							
							WHERE
								ST81.DivisionID = @DivisionID
								AND ST81.APKMaster = @SOrderID								
						)

		IF ISNULL(@Version, -1) = -1 BEGIN PRINT (N'Không tìm được Version của bộ BOM.'); END

		--- Lấy kết quả thành phẩm của Thông tin sản xuất lên.
		INSERT INTO #SOP2088_ESTIMATES
		(
			SemiOrders
			, VoucherID
			, VoucherNo
			, TableInherited
			, ProductID
			, BOMVersion
			, PaperTypeID
			, SemiProduct
			, APKMInherited
			, APKDInherited
			, [Length]
			, [Width]
			, [Height]
			, PrintSize			
			, CutSize			
			, LengthPaper		
			, WithPaper			
			, Package			
			, PrintNumber		
			, SideColor1		
			, ColorPrint01		
			, SideColor2		
			, ColorPrint02		
			, InvenSheetPrint01	
			, InvenSheetTemplate
			, PackageAmount
			, ActualQuantity
			, OffsetQuantity	
			, KindPaper			
			, OffsetSize		
			, OffsetCut			
			, InvenSheetPrint02	
			, SheetPrintQuantity
			, RPaper			
			, FilmDate			
			, FilmStatus		
			, LengthFilm		
			, WidthFilm			
			, AmountLoss		
			, PercentLoss		
			, StatusMold		
			, CartonQuantity	
			, SplitSheets		
			, CartonTotal		
			, AccretionSize		
			, AccretionCut		
			, WavePaperSize		
			, WavePaperCut		
			, Notes				
			, TotalVariableFee	
			, PercentCost		
			, Cost				
			, PercentProfit		
			, Profit			
			, InvenUnitPrice	
			, SquareMetersPrice	
			, ExchangeRate		
			, CurrencyID		
			, [FileName]		
			, ContentSampleDate	
			, ColorSampleDate	
			, MTSignedSampleDate
			, FileLength		
			, FileWidth			
			, FileSum			
			, [Include]			
			, FileUnitID		
			, PrintTypeID		
			, TotalProfitCost	
			, TotalAmount		
			, TotalSetupTime
		)
		SELECT 
			MT23.NodeOrder	AS SemiOrders
			, ST80.APK				AS VoucherID
			, ST80.VoucherNo		AS VoucherNo
			, 'SOT2081'				AS TableInherited
			, @InventoryID			AS ProductID
			, @Version				AS BOMVersion
			, ST81.PaperTypeID
			, ST81.SemiProduct
			, @SOrderID				AS APKMInherited
			, ST81.APKDInherited	AS APKDInherited
			, ST81.[Length]			
			, ST81.[Width]			
			, ST81.[Height]
			, NULL					AS PrintSize				
			, NULL					AS CutSize				
			, NULL					AS LengthPaper			
			, NULL					AS WithPaper				
			, NULL					AS Package				
			, ST81.PrintNumber			
			, ST81.SideColor1			
			, ST81.ColorPrint01			
			, ST81.SideColor2			
			, ST81.ColorPrint02			
			, NULL					AS InvenSheetPrint01		
			, NULL					AS InvenSheetTemplate	
			, NULL					AS PackageAmount
			, ST81.ActualQuantity
			, ST81.OffsetQuantity		
			, NULL					AS KindPaper				
			, NULL					AS OffsetSize			
			, NULL					AS OffsetCut				
			, NULL					AS InvenSheetPrint02		
			, NULL					AS SheetPrintQuantity	
			, NULL					AS RPaper				
			, ST81.FilmDate				
			, ST81.FilmStatus			
			, NULL					AS LengthFilm			
			, NULL					AS WidthFilm				
			, ST81.AmountLoss			
			, ST81.PercentLoss			
			, NULL					AS StatusMold			
			, NULL					AS CartonQuantity		
			, NULL					AS SplitSheets			
			, NULL					AS CartonTotal			
			, NULL					AS AccretionSize			
			, NULL					AS AccretionCut			
			, NULL					AS WavePaperSize			
			, NULL					AS WavePaperCut			
			, ST81.Notes					
			, ST81.TotalVariableFee		
			, ST81.PercentCost			
			, ST81.Cost					
			, ST81.PercentProfit			
			, ST81.Profit				
			, ST81.InvenUnitPrice		
			, ST81.SquareMetersPrice		
			, ST81.ExchangeRate			
			, ST81.CurrencyID			
			, ST81.[FileName]			
			, ST81.ContentSampleDate		
			, ST81.ColorSampleDate		
			, ST81.MTSignedSampleDate	
			, ST81.FileLength			
			, ST81.FileWidth				
			, ST81.FileSum				
			, ST81.[Include]				
			, ST81.FileUnitID			
			, ST81.PrintTypeID
			, NULL					AS TotalProfitCost
			, NULL					AS TotalAmount
			, NULL					AS TotalSetupTime
		FROM SOT2081 ST81 WITH (NOLOCK)
		INNER JOIN SOT2080 ST80 WITH (NOLOCK) ON ST80.DivisionID = ST81.DivisionID
													AND ISNULL(ST80.DeleteFlg, 0) = 0
													AND ST80.APK = ST81.APKMaster
		INNER JOIN MT2123 MT23 WITH (NOLOCK) ON MT23.DivisionID = ST81.DivisionID
												AND MT23.APK = ST81.APKDInherited
		WHERE ST81.DivisionID = @DivisionID
				AND ST81.APKMaster = @SOrderID
		ORDER BY MT23.NodeOrder
				, ST80.SemiProduct

		--- Join Name và trả về kết quả.
		SELECT 
			S88.SemiOrders
			, @DivisionID			AS DivisionID
			, S88.VoucherNo
			, S88.VoucherID
			, S88.TableInherited
			, S88.ProductID
			, S88.BOMVersion
			, S88.SemiProduct
			, AT02.InventoryName	AS SemiProductName
			, S88.APKMInherited
			, S88.APKDInherited
			, S88.PaperTypeID
			, MT92.[Description]	AS PaperTypeName
			, S88.[Length]
			, S88.[Width]
			, S88.[Height]
			, S88.PrintSize
			, S88.CutSize
			, S88.LengthPaper
			, S88.WithPaper
			, S88.Package
			, S88.PrintNumber		
			, S88.SideColor1
			, S88.ColorPrint01		
			, S88.SideColor2		
			, S88.ColorPrint02		
			, S88.InvenSheetPrint01	
			, S88.InvenSheetTemplate
			, S88.PackageAmount		
			, S88.ActualQuantity
			, S88.OffsetQuantity	
			, S88.KindPaper			
			, S88.OffsetSize		
			, S88.OffsetCut			
			, S88.InvenSheetPrint02	
			, S88.SheetPrintQuantity
			, S88.RPaper			
			, S88.FilmDate			
			, S88.FilmStatus
			, (CASE WHEN S88.FilmStatus IS NULL THEN NULL
					WHEN ISNULL(S88.FilmStatus, 0) = 0 THEN N'Cũ' 
					ELSE N'Mới' 
					END) AS FilmStatusName
			, S88.PrintTypeID		
			, C2.[Description]					AS PrintTypeName
			, S88.LengthFilm
			, S88.WidthFilm
			, S88.AmountLoss
			, S88.PercentLoss
			, S88.StatusMold
			, (CASE WHEN S88.StatusMold IS NULL THEN NULL
					WHEN ISNULL(S88.StatusMold, 0) = 0 THEN N'Cũ'
					ELSE N'Mới'
					END) AS StatusMoldName
			, S88.CartonQuantity
			, S88.SplitSheets
			, S88.CartonTotal
			, S88.AccretionSize
			, S88.AccretionCut
			, S88.WavePaperSize		
			, S88.WavePaperCut		
			, S88.Notes				
			, S88.TotalVariableFee	
			, S88.PercentCost		
			, S88.Cost				
			, S88.PercentProfit		
			, S88.Profit			
			, S88.InvenUnitPrice	
			, S88.SquareMetersPrice	
			, S88.ExchangeRate		
			, S88.CurrencyID		
			, S88.[FileName]		
			, S88.ContentSampleDate	
			, S88.ColorSampleDate	
			, S88.MTSignedSampleDate
			, S88.FileLength		
			, S88.FileWidth			
			, S88.FileSum			
			, S88.[Include]			
			, S88.FileUnitID		
			, MT91.[Description]				AS FileUnitName
			, S88.TotalProfitCost	
			, S88.TotalAmount		
			, S88.TotalSetupTime
			, 0									AS ApproveCutRollStatusID
			, OT91.[Description]				AS ApproveCutRollStatusName
			, 0									AS ApproveWaveStatusID
			, OT91.[Description]				AS ApproveWaveStatusName
			, S88.VoucherID						AS InheritAPKMaster
		FROM #SOP2088_ESTIMATES S88
		LEFT JOIN AT1302 AT02 WITH (NOLOCK) ON AT02.DivisionID IN ('@@@', @DivisionID)
													AND AT02.InventoryID = S88.SemiProduct
		LEFT JOIN OOT0099 OT91 WITH (NOLOCK) ON OT91.CodeMaster = 'Status'
													AND ISNULL(OT91.[Disabled], 0) = 0
													AND OT91.ID1 = '0'
		LEFT JOIN CRMT0099 C2 WITH (NOLOCK) ON C2.CodeMaster = 'CRMF2111.PrintType'
													AND ISNULL(C2.[Disabled], 0) = 0
													AND C2.ID = S88.PrintTypeID
		LEFT JOIN MT0099 MT91 WITH (NOLOCK) ON MT91.CodeMaster = 'UnitSize'
													AND ISNULL(MT91.[Disabled], 0) = 0
													AND MT91.ID = S88.FileUnitID
		LEFT JOIN CRMT0099 MT92 WITH (NOLOCK) ON MT92.CodeMaster = 'CRMT00000022'
													AND ISNULL(MT92.[Disabled], 0) = 0
													AND MT92.ID = S88.PaperTypeID
		ORDER BY S88.SemiOrders
	END
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
