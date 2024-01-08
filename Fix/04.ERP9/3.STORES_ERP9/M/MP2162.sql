IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2162]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2162]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






----Created by : Trọng Kiên, date: 19/04/2021
----Modified by: Văn Tài   , date: 07/02/2022 - Xử lý lỗi cột AmountLoss, Notes, MachineName.
----Modified by: Văn Tài   , date: 17/04/2023 - Xử lý fix lỗi in lệnh sản xuất. Sai tên cột và loại bỏ sử dụng biến bảng bên trong.
----Modified by: Đức Tuyên   , date: 30/08/2023 - Xử lý fix lỗi in lệnh sản xuất.
---- exec MP2162 @Divisionid=N'ANG',@Tranmonth=1,@Tranyear=2016,@APK=N''

CREATE PROCEDURE [dbo].[MP2162] 
				@DivisionID AS nvarchar(50),
				@APK AS nvarchar(4000),
				@CommandType AS Varchar(50),
				@TranMonth AS int,
				@TranYear AS INT,
				@PhaseID VARCHAR(50) = ''

AS

DECLARE @sSQL NVARCHAR(MAX) ='', 
		@PhaseCut VARCHAR(50),
		@PhasePrint VARCHAR(50),
		@PhaseWave VARCHAR(50),
		@InventoryID VARCHAR(50)

SET @PhaseCut = (SELECT ISNULL(CutPhaseID, '') FROM CRMT00000 WHERE DivisionID = ''+ @DivisionID +'')
SET @PhasePrint = (SELECT ISNULL(PrintPhaseID, '') FROM CRMT00000 WHERE DivisionID = ''+ @DivisionID +'')
SET @PhaseWave = (SELECT ISNULL(WavePhaseID, '') FROM CRMT00000 WHERE DivisionID = ''+ @DivisionID +'')


IF (@CommandType) = '0'
SET @sSQL = N'SELECT M1.*, S1.DeliveryTime, S2.AmountLoss, S2.Notes 
					 , CASE WHEN S2.Length <> '''' AND S2.Width <> '''' THEN CONCAT(S2.Length,'' x '', S2.Width) 
															ELSE '''' END AS SizePaper
					, ISNULL(CI50.MachineName, '''') AS MachineName
			  FROM MT2160 M1 WITH (NOLOCK)
				  LEFT JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.EstimateID = M1.MOrderID
				  LEFT JOIN OT2203 OT03 WITH (NOLOCK) ON OT03.APK_OT2202 = OT02.APK AND OT03.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON S1.APK = OT02.InheritTransactionID
				  LEFT JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.SemiProduct = M1.ProductID
				  LEFT JOIN CIT1150 CI50 WITH (NOLOCK) ON CI50.MachineID = M1.MachineID
			  WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''

ELSE IF (@CommandType) = '1'
-- Loại lệnh cắt cuộn
BEGIN
SET @sSQL = N'SELECT M1.*, S1.DeliveryTime, S2.AmountLoss, S2.Notes, A1.InventoryName AS MaterialName, S2.OffsetQuantity
					 , CASE WHEN S2.Length <> '''' AND S2.Width <> '''' THEN CONCAT(S2.Length,'' x '', S2.Width) 
															ELSE '''' END AS SizePaper
					 , CASE WHEN ISNULL(S3.Gsm, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.Gsm)
			  			  WHEN ISNULL(S3.Sheets, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.Sheets)
			  			  WHEN ISNULL(S3.Ram, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.Ram)
			  			  WHEN ISNULL(S3.Kg, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.Kg)
			  			  WHEN ISNULL(S3.M2, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.M2) END AS MaterialQuantity
					 , CASE WHEN ISNULL(S3.Size, 0) <> 0 AND ISNULL(S3.Cut, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0),S3.Size),'' x '', CONVERT(DECIMAL(28,0),S3.Cut))
							ELSE '''' END AS SizePaperFirst
					 , A2.PhaseName AS PhaseNext
					, ISNULL(CI50.MachineName, '''') AS MachineName
			  FROM MT2160 M1 WITH (NOLOCK)
				  LEFT JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.EstimateID = M1.MOrderID
				  LEFT JOIN OT2203 OT03 WITH (NOLOCK) ON OT03.APK_OT2202 = OT02.APK AND OT03.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON S1.APK = OT02.InheritTransactionID
				  LEFT JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2082 S3 WITH (NOLOCK) ON S1.APK = S3.APKMaster AND S3.APK_SOT2081 = S2.APK AND M1.PhaseID = ''' + @PhaseCut + '''
				  LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S3.MaterialID = A1.InventoryID
				  LEFT JOIN MT2120 M2 WITH (NOLOCK) ON M2.NodeID = M1.ProductID
				  LEFT JOIN MT2130 M3 WITH (NOLOCK) ON M3.RoutingID = OT03.RoutingID
				  LEFT JOIN MT2131 M4 WITH (NOLOCK) ON M4.APKMaster = M3.APK AND M1.PhaseID = M4.PhaseID
				  LEFT JOIN MT2131 M5 WITH (NOLOCK) ON M5.APKMaster = M3.APK AND M5.PhaseOrder = M4.NextOrders
				  LEFT JOIN AT0126 A2 WITH (NOLOCK) ON M5.PhaseID = A2.PhaseID
				  LEFT JOIN CIT1150 CI50 WITH (NOLOCK) ON CI50.MachineID = M1.MachineID
			  WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''
END
ELSE IF (@CommandType) = '2'
-- Loại lệnh chụp kẽm
BEGIN
SET @sSQL = N'SELECT M1.*, S1.DeliveryTime, S2.AmountLoss, S2.Notes, A1.InventoryName AS MaterialName, S2.OffsetQuantity
					 , S2.ActualQuantity, S2.FilmDate
					 , CASE WHEN ISNULL(S2.FileSum, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0), S2.FileSum) , M7.Description)
							ELSE '''' END AS FilmChild
					 , CASE WHEN ISNULL(S2.FileLength, 0) <> 0 AND ISNULL(S2.FileWidth, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0),S2.FileLength),'' x '', CONVERT(DECIMAL(28,0),S2.FileWidth))
							ELSE '''' END AS SizeFilm
					 , CASE WHEN ISNULL(S3.Size, 0) <> 0 AND ISNULL(S3.Cut, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0),S3.Size),'' x '', CONVERT(DECIMAL(28,0),S3.Cut))
							ELSE '''' END AS SizePaper
					 , CASE WHEN ISNULL(S3.Child, 0) <> 0 THEN CONCAT (CONVERT(DECIMAL(28,0), S3.Child) , M6.Description)
							ELSE '''' END AS Child
					 , CASE WHEN ISNULL(S3.Gsm, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.Gsm)
			  			  WHEN ISNULL(S3.Sheets, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.Sheets)
			  			  WHEN ISNULL(S3.Ram, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.Ram)
			  			  WHEN ISNULL(S3.Kg, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.Kg)
			  			  WHEN ISNULL(S3.M2, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.M2) END AS MaterialQuantity
					 , A2.PhaseName AS PhaseNext, A3.PhaseName AS PhasePrevious, '''' AS PrintTypeName, '''' AS TypeColor
					, ISNULL(CI50.MachineName, '''') AS MachineName
			  FROM MT2160 M1 WITH (NOLOCK)
				  LEFT JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.EstimateID = M1.MOrderID
				  LEFT JOIN OT2203 OT03 WITH (NOLOCK) ON OT03.APK_OT2202 = OT02.APK AND OT03.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON S1.APK = OT02.InheritTransactionID
				  LEFT JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2082 S3 WITH (NOLOCK) ON S1.APK = S3.APKMaster AND S3.APK_SOT2081 = S2.APK AND M1.PhaseID = ''' + @PhaseCut + '''
				  LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S3.MaterialID = A1.InventoryID
				  LEFT JOIN MT2120 M2 WITH (NOLOCK) ON M2.NodeID = M1.ProductID
				  LEFT JOIN MT2130 M3 WITH (NOLOCK) ON M3.RoutingID = OT03.RoutingID
				  LEFT JOIN MT2131 M4 WITH (NOLOCK) ON M4.APKMaster = M3.APK AND M1.PhaseID = M4.PhaseID
				  LEFT JOIN MT2131 M5 WITH (NOLOCK) ON M5.APKMaster = M3.APK AND M5.PhaseOrder = M4.NextOrders
				  LEFT JOIN AT0126 A2 WITH (NOLOCK) ON M5.PhaseID = A2.PhaseID
				  LEFT JOIN MT0099 M6 WITH (NOLOCK) ON S3.UnitSizeID = M6.ID AND M6.CodeMaster = ''UnitSize''
				  LEFT JOIN MT0099 M7 WITH (NOLOCK) ON S2.FileUnitID = M7.ID AND M7.CodeMaster = ''UnitSize''
				  --LEFT JOIN SOT2082 S4 WITH (NOLOCK) ON S1.APK = S4.APKMaster AND S4.PhaseID = ''' + @PhasePrint + '''
				  LEFT JOIN MT2131 M8 WITH (NOLOCK) ON M8.APKMaster = M3.APK AND M8.PhaseOrder = M4.PreviousOrders 
				  LEFT JOIN AT0126 A3 WITH (NOLOCK) ON M8.PhaseID = A3.PhaseID
				  LEFT JOIN CIT1150 CI50 WITH (NOLOCK) ON CI50.MachineID = M1.MachineID
			  WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''
END
ELSE IF (@CommandType) = '3'
-- Loại lệnh Offset
BEGIN
SET @sSQL = N'SELECT M1.*, S1.DeliveryTime, S2.AmountLoss, S2.Notes, A1.InventoryName AS MaterialName, S2.OffsetQuantity
					 , S2.ActualQuantity, S2.FilmDate, S2.ContentSampleDate, S2.ColorSampleDate, S2.MTSignedSampleDate
					 , CASE WHEN ISNULL(S3.Size, 0) <> 0 AND ISNULL(S3.Cut, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0),S3.Size),'' x '', CONVERT(DECIMAL(28,0),S3.Cut))
							ELSE '''' END AS SizePaper
					 , CASE WHEN ISNULL(S3.Child, 0) <> 0 THEN CONCAT (CONVERT(DECIMAL(28,0), S3.Child) , M6.Description)
							ELSE '''' END AS Child
					 , CASE WHEN ISNULL(S3.Gsm, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.Gsm)
			  			  WHEN ISNULL(S3.Sheets, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.Sheets)
			  			  WHEN ISNULL(S3.Ram, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.Ram)
			  			  WHEN ISNULL(S3.Kg, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.Kg)
			  			  WHEN ISNULL(S3.M2, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.M2) END AS MaterialQuantity
					 , A2.PhaseName AS PhaseNext, A3.PhaseName AS PhasePrevious, '''' AS PrintTypeName, '''' AS TypeColor
					 , '''' AS ColorNum
					, ISNULL(CI50.MachineName, '''') AS MachineName
			  FROM MT2160 M1 WITH (NOLOCK)
				  LEFT JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.EstimateID = M1.MOrderID
				  LEFT JOIN OT2203 OT03 WITH (NOLOCK) ON OT03.APK_OT2202 = OT02.APK AND OT03.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON S1.APK = OT02.InheritTransactionID
				  LEFT JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2082 S3 WITH (NOLOCK) ON S1.APK = S3.APKMaster AND S3.APK_SOT2081 = S2.APK AND M1.PhaseID = ''' + @PhaseCut + '''
				  LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S3.MaterialID = A1.InventoryID
				  LEFT JOIN MT2120 M2 WITH (NOLOCK) ON M2.NodeID = M1.ProductID
				  LEFT JOIN MT2130 M3 WITH (NOLOCK) ON M3.RoutingID = OT03.RoutingID
				  LEFT JOIN MT2131 M4 WITH (NOLOCK) ON M4.APKMaster = M3.APK AND M1.PhaseID = M4.PhaseID
				  LEFT JOIN MT2131 M5 WITH (NOLOCK) ON M5.APKMaster = M3.APK AND M5.PhaseOrder = M4.NextOrders
				  LEFT JOIN AT0126 A2 WITH (NOLOCK) ON M5.PhaseID = A2.PhaseID
				  LEFT JOIN MT0099 M6 WITH (NOLOCK) ON S3.UnitSizeID = M6.ID AND M6.CodeMaster = ''UnitSize''
				  LEFT JOIN MT0099 M7 WITH (NOLOCK) ON S2.FileUnitID = M7.ID AND M7.CodeMaster = ''UnitSize''
				  --LEFT JOIN SOT2082 S4 WITH (NOLOCK) ON S1.APK = S4.APKMaster AND S4.PhaseID = ''' + @PhasePrint + '''
				  LEFT JOIN MT2131 M8 WITH (NOLOCK) ON M8.APKMaster = M3.APK AND M8.PhaseOrder = M4.PreviousOrders 
				  LEFT JOIN AT0126 A3 WITH (NOLOCK) ON M8.PhaseID = A3.PhaseID
				  LEFT JOIN CIT1150 CI50 WITH (NOLOCK) ON CI50.MachineID = M1.MachineID
			  WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''
END
ELSE IF (@CommandType) = '4'
-- Loại lệnh cán màng
BEGIN
SET @sSQL = N'SELECT M1.*, S1.DeliveryTime, S2.AmountLoss, S2.Notes, S2.OffsetQuantity, S2.ActualQuantity
					 , A2.PhaseName AS PhaseNext, A3.PhaseName AS PhasePrevious
					 , CASE WHEN ISNULL(S4.Size, 0) <> 0 AND ISNULL(S4.Cut, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0),S4.Size),'' x '', CONVERT(DECIMAL(28,0),S4.Cut))
							ELSE '''' END AS SizePaper
					 , CASE WHEN ISNULL(S4.Child, 0) <> 0 THEN CONCAT (CONVERT(DECIMAL(28,0), S4.Child) , M6.Description)
							ELSE '''' END AS Child
					, '''' AS MachineName
			  FROM MT2160 M1 WITH (NOLOCK)
				  LEFT JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.EstimateID = M1.MOrderID
				  LEFT JOIN OT2203 OT03 WITH (NOLOCK) ON OT03.APK_OT2202 = OT02.APK AND OT03.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON S1.APK = OT02.InheritTransactionID
				  LEFT JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2082 S3 WITH (NOLOCK) ON S1.APK = S3.APKMaster AND M1.PhaseID = ''' + @PhaseCut + ''' --- Cần biết công đoạn Cán màng mã là gì để thay vào PhaseCut -> lấy được công đoạn trước sau
				  LEFT JOIN SOT2082 S4 WITH (NOLOCK) ON S1.APK = S4.APKMaster AND S4.PhaseID = ''' + @PhaseCut + '''
				  LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S3.MaterialID = A1.InventoryID
				  LEFT JOIN MT2120 M2 WITH (NOLOCK) ON M2.NodeID = M1.ProductID
				  LEFT JOIN MT2130 M3 WITH (NOLOCK) ON M3.RoutingID = OT03.RoutingID
				  LEFT JOIN MT2131 M4 WITH (NOLOCK) ON M4.APKMaster = M3.APK AND M1.PhaseID = M4.PhaseID
				  LEFT JOIN MT2131 M5 WITH (NOLOCK) ON M5.APKMaster = M3.APK AND M5.PhaseOrder = M4.NextOrders
				  LEFT JOIN AT0126 A2 WITH (NOLOCK) ON M5.PhaseID = A2.PhaseID
				  LEFT JOIN MT0099 M6 WITH (NOLOCK) ON S4.UnitSizeID = M6.ID AND M6.CodeMaster = ''UnitSize''
				  LEFT JOIN MT0099 M7 WITH (NOLOCK) ON S2.FileUnitID = M7.ID AND M7.CodeMaster = ''UnitSize''
				  LEFT JOIN MT2131 M8 WITH (NOLOCK) ON M8.APKMaster = M3.APK AND M8.PhaseOrder = M4.PreviousOrders 
				  LEFT JOIN AT0126 A3 WITH (NOLOCK) ON M8.PhaseID = A3.PhaseID
			  WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''
END
ELSE IF (@CommandType) = '5'
-- Loại lệnh bồi
BEGIN
SET @sSQL = N'SELECT M1.*, S1.DeliveryTime, S2.AmountLoss, S2.Notes, S2.OffsetQuantity, S2.ActualQuantity
					 , A2.PhaseName AS PhaseNext, A3.PhaseName AS PhasePrevious
					 , A1.InventoryName AS MaterialName, A1.InventoryName AS SheetName
					, '''' AS MachineName
			  FROM MT2160 M1 WITH (NOLOCK)
				  LEFT JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.EstimateID = M1.MOrderID
				  LEFT JOIN OT2203 OT03 WITH (NOLOCK) ON OT03.APK_OT2202 = OT02.APK AND OT03.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON S1.APK = OT02.InheritTransactionID
				  LEFT JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2082 S3 WITH (NOLOCK) ON S1.APK = S3.APKMaster AND M1.PhaseID = ''04'' --- Cần biết công đoạn Bồi mã là gì để thay vào 04 -> lấy được công đoạn trước sau
				  LEFT JOIN SOT2082 S4 WITH (NOLOCK) ON S1.APK = S4.APKMaster AND S4.PhaseID = ''' + @PhaseCut + '''
				  LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S4.MaterialID = A1.InventoryID
				  LEFT JOIN AT1302 A4 WITH (NOLOCK) ON S3.MaterialID = A4.InventoryID
				  LEFT JOIN MT2120 M2 WITH (NOLOCK) ON M2.NodeID = M1.ProductID
				  LEFT JOIN MT2130 M3 WITH (NOLOCK) ON M3.RoutingID = OT03.RoutingID
				  LEFT JOIN MT2131 M4 WITH (NOLOCK) ON M4.APKMaster = M3.APK AND M1.PhaseID = M4.PhaseID
				  LEFT JOIN MT2131 M5 WITH (NOLOCK) ON M5.APKMaster = M3.APK AND M5.PhaseOrder = M4.NextOrders
				  LEFT JOIN AT0126 A2 WITH (NOLOCK) ON M5.PhaseID = A2.PhaseID
				  LEFT JOIN MT0099 M6 WITH (NOLOCK) ON S4.UnitSizeID = M6.ID AND M6.CodeMaster = ''UnitSize''
				  LEFT JOIN MT0099 M7 WITH (NOLOCK) ON S2.FileUnitID = M7.ID AND M7.CodeMaster = ''UnitSize''
				  LEFT JOIN MT2131 M8 WITH (NOLOCK) ON M8.APKMaster = M3.APK AND M8.PhaseOrder = M4.PreviousOrders 
				  LEFT JOIN AT0126 A3 WITH (NOLOCK) ON M8.PhaseID = A3.PhaseID
			  WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''
END
ELSE IF (@CommandType) = '6'
-- Loại lệnh bế chạp
BEGIN
SET @sSQL = N'SELECT M1.*, S1.DeliveryTime, S2.AmountLoss, S2.Notes, S2.OffsetQuantity, S2.ActualQuantity
					 , A2.PhaseName AS PhaseNext, A3.PhaseName AS PhasePrevious
					 , A1.InventoryName AS MaterialName, A1.InventoryName AS SheetName
					 , CONCAT(ISNULL(S2.Length, 0), '' x '', ISNULL(S2.Width, 0), '' x  '', ISNULL(S2.Height, 0)) AS SizeProduct
					 , CASE WHEN ISNULL(S3.Gsm, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.Gsm)
			  			  WHEN ISNULL(S3.Sheets, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.Sheets)
			  			  WHEN ISNULL(S3.Ram, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.Ram)
			  			  WHEN ISNULL(S3.Kg, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.Kg)
			  			  WHEN ISNULL(S3.M2, 0) > 0 THEN CONVERT(DECIMAL(28,0), S3.M2) END AS MaterialQuantity
					 , CASE WHEN ISNULL(S3.Size, 0) <> 0 AND ISNULL(S3.Cut, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0),S3.Size),'' x '', CONVERT(DECIMAL(28,0),S3.Cut))
							ELSE '''' END AS SizePaper
					 , CASE WHEN ISNULL(S3.Child, 0) <> 0 THEN CONCAT (CONVERT(DECIMAL(28,0), S3.Child) , M6.Description)
							ELSE '''' END AS Child
					, ISNULL(CI50.MachineName, '''') AS MachineName
			  FROM MT2160 M1 WITH (NOLOCK)
				  LEFT JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.EstimateID = M1.MOrderID
				  LEFT JOIN OT2203 OT03 WITH (NOLOCK) ON OT03.APK_OT2202 = OT02.APK AND OT03.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON S1.APK = OT02.InheritTransactionID
				  LEFT JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2082 S3 WITH (NOLOCK) ON S1.APK = S3.APKMaster AND S3.APK_SOT2081 = S2.APK AND S3.PhaseID = ''' + @PhaseID + ''' --- Cần biết công đoạn Bế mã là gì để thay vào 06 -> lấy được công đoạn trước sau
				  --LEFT JOIN SOT2082 S3 WITH (NOLOCK) ON S1.APK = S3.APKMaster AND S3.PhaseID = ''' + @PhaseCut + '''
				  LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S3.MaterialID = A1.InventoryID
				  LEFT JOIN AT1302 A4 WITH (NOLOCK) ON S3.MaterialID = A4.InventoryID
				  LEFT JOIN MT2120 M2 WITH (NOLOCK) ON M2.NodeID = M1.ProductID
				  LEFT JOIN MT2130 M3 WITH (NOLOCK) ON M3.RoutingID = OT03.RoutingID
				  LEFT JOIN MT2131 M4 WITH (NOLOCK) ON M4.APKMaster = M3.APK AND M1.PhaseID = M4.PhaseID
				  LEFT JOIN MT2131 M5 WITH (NOLOCK) ON M5.APKMaster = M3.APK AND M5.PhaseOrder = M4.NextOrders
				  LEFT JOIN AT0126 A2 WITH (NOLOCK) ON M5.PhaseID = A2.PhaseID
				  LEFT JOIN MT0099 M6 WITH (NOLOCK) ON S3.UnitSizeID = M6.ID AND M6.CodeMaster = ''UnitSize''
				  LEFT JOIN MT0099 M7 WITH (NOLOCK) ON S2.FileUnitID = M7.ID AND M7.CodeMaster = ''UnitSize''
				  LEFT JOIN MT2131 M8 WITH (NOLOCK) ON M8.APKMaster = M3.APK AND M8.PhaseOrder = M4.PreviousOrders 
				  LEFT JOIN AT0126 A3 WITH (NOLOCK) ON M8.PhaseID = A3.PhaseID
				  LEFT JOIN CIT1150 CI50 WITH (NOLOCK) ON CI50.MachineID = M1.MachineID
			  WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''
END
ELSE IF (@CommandType) = '7'
-- Loại lệnh In Flexo
BEGIN
SET @sSQL = N'SELECT M1.*, S1.DeliveryTime, S2.AmountLoss, S2.Notes, S2.OffsetQuantity, S2.ActualQuantity
					 , A2.PhaseName AS PhaseNext, A3.PhaseName AS PhasePrevious, '''' AS PrintTypeName
					 , CONCAT(ISNULL(S2.Length, 0), '' x '', ISNULL(S2.Width, 0), '' x  '', ISNULL(S2.Height, 0)) AS SizeProduct
					 , CASE WHEN ISNULL(S4.Size, 0) <> 0 AND ISNULL(S4.Cut, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0),S4.Size),'' x '', CONVERT(DECIMAL(28,0),S4.Cut))
							ELSE '''' END AS SizePaper
					 , CASE WHEN ISNULL(S4.Child, 0) <> 0 THEN CONCAT (CONVERT(DECIMAL(28,0), S4.Child) , M6.Description)
							ELSE '''' END AS Child
					 , C1.Description AS FilmStatusName, S2.ContentSampleDate, S2.ColorSampleDate, S2.MTSignedSampleDate
					 , '''' AS ColorNum, '''' AS TypeColor
					 , CASE WHEN ISNULL(S3.Size, 0) <> 0 AND ISNULL(S3.Cut, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0),S3.Size),'' x '', CONVERT(DECIMAL(28,0),S3.Cut))
							ELSE '''' END AS Size
					 --, C2.Description AS RunPaperName
					 , '''' AS RunPaperName
					, '''' AS MachineName
			  FROM MT2160 M1 WITH (NOLOCK)
				  LEFT JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.EstimateID = M1.MOrderID
				  LEFT JOIN OT2203 OT03 WITH (NOLOCK) ON OT03.APK_OT2202 = OT02.APK AND OT03.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON S1.APK = OT02.InheritTransactionID
				  LEFT JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2082 S3 WITH (NOLOCK) ON S1.APK = S3.APKMaster AND M1.PhaseID = ''06'' --- Cần biết công đoạn Bế mã là gì để thay vào 06 -> lấy được công đoạn trước sau
				  LEFT JOIN SOT2082 S4 WITH (NOLOCK) ON S1.APK = S4.APKMaster AND S4.PhaseID = ''' + @PhasePrint + '''
				  LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S4.MaterialID = A1.InventoryID
				  LEFT JOIN AT1302 A4 WITH (NOLOCK) ON S3.MaterialID = A4.InventoryID
				  LEFT JOIN MT2120 M2 WITH (NOLOCK) ON M2.NodeID = M1.ProductID
				  LEFT JOIN MT2130 M3 WITH (NOLOCK) ON M3.RoutingID = OT03.RoutingID
				  LEFT JOIN MT2131 M4 WITH (NOLOCK) ON M4.APKMaster = M3.APK AND M1.PhaseID = M4.PhaseID
				  LEFT JOIN MT2131 M5 WITH (NOLOCK) ON M5.APKMaster = M3.APK AND M5.PhaseOrder = M4.NextOrders
				  LEFT JOIN AT0126 A2 WITH (NOLOCK) ON M5.PhaseID = A2.PhaseID
				  LEFT JOIN MT0099 M6 WITH (NOLOCK) ON S4.UnitSizeID = M6.ID AND M6.CodeMaster = ''UnitSize''
				  LEFT JOIN MT0099 M7 WITH (NOLOCK) ON S2.FileUnitID = M7.ID AND M7.CodeMaster = ''UnitSize''
				  LEFT JOIN MT2131 M8 WITH (NOLOCK) ON M8.APKMaster = M3.APK AND M8.PhaseOrder = M4.PreviousOrders 
				  LEFT JOIN AT0126 A3 WITH (NOLOCK) ON M8.PhaseID = A3.PhaseID
				  LEFT JOIN CRMT0099 C1 WITH (NOLOCK) ON S2.FilmStatus = C1.ID AND C1.CodeMaster = ''CRMF2111.Status''
				  --LEFT JOIN CRMT0099 C2 WITH (NOLOCK) ON S2.RunPaperID = C2.ID AND C2.CodeMaster = ''CRMF2111.RunPaper''
			  WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''
END
ELSE IF (@CommandType) = '8'
--Loại lệnh bẻ
BEGIN
SET @sSQL = N'SELECT M1.*, S1.DeliveryTime, S2.AmountLoss, S2.Notes, S2.OffsetQuantity, S2.ActualQuantity
					 , A2.PhaseName AS PhaseNext, A3.PhaseName AS PhasePrevious
					 , CASE WHEN ISNULL(S4.Child, 0) <> 0 THEN CONCAT (CONVERT(DECIMAL(28,0), S4.Child), M6.Description)
							ELSE '''' END AS Child
					, '''' AS MachineName
			  FROM MT2160 M1 WITH (NOLOCK)
				  LEFT JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.EstimateID = M1.MOrderID
				  LEFT JOIN OT2203 OT03 WITH (NOLOCK) ON OT03.APK_OT2202 = OT02.APK AND OT03.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON S1.APK = OT02.InheritTransactionID
				  LEFT JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2082 S3 WITH (NOLOCK) ON S1.APK = S3.APKMaster AND M1.PhaseID = ''' + @PhasePrint + ''' --- Cần biết công đoạn bẻ hàng mã là gì để thay vào @PhasePrint -> lấy được công đoạn trước sau
				  LEFT JOIN SOT2082 S4 WITH (NOLOCK) ON S1.APK = S4.APKMaster AND S4.PhaseID = ''' + @PhasePrint + '''
				  LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S4.MaterialID = A1.InventoryID
				  LEFT JOIN AT1302 A4 WITH (NOLOCK) ON S3.MaterialID = A4.InventoryID
				  LEFT JOIN MT2120 M2 WITH (NOLOCK) ON M2.NodeID = M1.ProductID
				  LEFT JOIN MT2130 M3 WITH (NOLOCK) ON M3.RoutingID = OT03.RoutingID
				  LEFT JOIN MT2131 M4 WITH (NOLOCK) ON M4.APKMaster = M3.APK AND M1.PhaseID = M4.PhaseID
				  LEFT JOIN MT2131 M5 WITH (NOLOCK) ON M5.APKMaster = M3.APK AND M5.PhaseOrder = M4.NextOrders
				  LEFT JOIN AT0126 A2 WITH (NOLOCK) ON M5.PhaseID = A2.PhaseID
				  LEFT JOIN MT0099 M6 WITH (NOLOCK) ON S4.UnitSizeID = M6.ID AND M6.CodeMaster = ''UnitSize''
				  LEFT JOIN MT0099 M7 WITH (NOLOCK) ON S2.FileUnitID = M7.ID AND M7.CodeMaster = ''UnitSize''
				  LEFT JOIN MT2131 M8 WITH (NOLOCK) ON M8.APKMaster = M3.APK AND M8.PhaseOrder = M4.PreviousOrders 
				  LEFT JOIN AT0126 A3 WITH (NOLOCK) ON M8.PhaseID = A3.PhaseID
				  LEFT JOIN CRMT0099 C1 WITH (NOLOCK) ON S2.FilmStatus = C1.ID AND C1.CodeMaster = ''CRMF2111.Status''
				  LEFT JOIN CRMT0099 C2 WITH (NOLOCK) ON S2.RunPaperID = C2.ID AND C2.CodeMaster = ''CRMF2111.RunPaper''
			  WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''
END
ELSE IF (@CommandType) = '9'
--Loại lệnh dán Supo
BEGIN
SET @sSQL = N'SELECT M1.*, S1.DeliveryTime, S2.AmountLoss, S2.Notes, S2.OffsetQuantity, S2.ActualQuantity
					 , A2.PhaseName AS PhaseNext, A3.PhaseName AS PhasePrevious
					 , CONCAT (ISNULL(S2.Length, 0) , '' x '', ISNULL(S2.Width, 0), '' x  '', ISNULL(S2.Height, 0)) AS SizeProduct
					 , CASE WHEN ISNULL(S2.Height , 0) <> 0 THEN S2.Height
							ELSE '''' END AS Height
					, '''' AS MachineName
			  FROM MT2160 M1 WITH (NOLOCK)
				  LEFT JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.EstimateID = M1.MOrderID
				  LEFT JOIN OT2203 OT03 WITH (NOLOCK) ON OT03.APK_OT2202 = OT02.APK AND OT03.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON S1.APK = OT02.InheritTransactionID
				  LEFT JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2082 S3 WITH (NOLOCK) ON S1.APK = S3.APKMaster AND M1.PhaseID = ''07'' --- Cần biết công đoạn DánSuppo mã là gì để thay vào 07 -> lấy được công đoạn trước sau
				  LEFT JOIN AT1302 A4 WITH (NOLOCK) ON S3.MaterialID = A4.InventoryID
				  LEFT JOIN MT2120 M2 WITH (NOLOCK) ON M2.NodeID = M1.ProductID
				  LEFT JOIN MT2130 M3 WITH (NOLOCK) ON M3.RoutingID = OT03.RoutingID
				  LEFT JOIN MT2131 M4 WITH (NOLOCK) ON M4.APKMaster = M3.APK AND M1.PhaseID = M4.PhaseID
				  LEFT JOIN MT2131 M5 WITH (NOLOCK) ON M5.APKMaster = M3.APK AND M5.PhaseOrder = M4.NextOrders
				  LEFT JOIN AT0126 A2 WITH (NOLOCK) ON M5.PhaseID = A2.PhaseID
				  LEFT JOIN MT0099 M7 WITH (NOLOCK) ON S2.FileUnitID = M7.ID AND M7.CodeMaster = ''UnitSize''
				  LEFT JOIN MT2131 M8 WITH (NOLOCK) ON M8.APKMaster = M3.APK AND M8.PhaseOrder = M4.PreviousOrders 
				  LEFT JOIN AT0126 A3 WITH (NOLOCK) ON M8.PhaseID = A3.PhaseID
			  WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''
END

ELSE IF (@CommandType) = '10'
-- Loại lệnh dán
BEGIN
SET @sSQL = N'SELECT M1.*, S1.DeliveryTime, S2.AmountLoss, S2.Notes, S2.OffsetQuantity, S2.ActualQuantity
					 , A2.PhaseName AS PhaseNext, A3.PhaseName AS PhasePrevious
					 , CONCAT (ISNULL (S2.Length, 0) , '' x '', ISNULL (S2.Width, 0), '' x  '', ISNULL (S2.Height, 0)) AS SizeProduct
					, '''' AS MachineName
			  FROM MT2160 M1 WITH (NOLOCK)
				  LEFT JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.EstimateID = M1.MOrderID
				  LEFT JOIN OT2203 OT03 WITH (NOLOCK) ON OT03.APK_OT2202 = OT02.APK AND OT03.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON S1.APK = OT02.InheritTransactionID
				  LEFT JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2082 S3 WITH (NOLOCK) ON S1.APK = S3.APKMaster AND M1.PhaseID = ''07'' --- Cần biết công đoạn Dán mã là gì để thay vào 07 -> lấy được công đoạn trước sau
				  LEFT JOIN AT1302 A4 WITH (NOLOCK) ON S3.MaterialID = A4.InventoryID
				  LEFT JOIN MT2120 M2 WITH (NOLOCK) ON M2.NodeID = M1.ProductID
				  LEFT JOIN MT2130 M3 WITH (NOLOCK) ON M3.RoutingID = OT03.RoutingID
				  LEFT JOIN MT2131 M4 WITH (NOLOCK) ON M4.APKMaster = M3.APK AND M1.PhaseID = M4.PhaseID
				  LEFT JOIN MT2131 M5 WITH (NOLOCK) ON M5.APKMaster = M3.APK AND M5.PhaseOrder = M4.NextOrders
				  LEFT JOIN AT0126 A2 WITH (NOLOCK) ON M5.PhaseID = A2.PhaseID
				  LEFT JOIN MT0099 M7 WITH (NOLOCK) ON S2.FileUnitID = M7.ID AND M7.CodeMaster = ''UnitSize''
				  LEFT JOIN MT2131 M8 WITH (NOLOCK) ON M8.APKMaster = M3.APK AND M8.PhaseOrder = M4.PreviousOrders 
				  LEFT JOIN AT0126 A3 WITH (NOLOCK) ON M8.PhaseID = A3.PhaseID
			  WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''
END
ELSE IF (@CommandType) = '11'
-- Loại lệnh đóng kim
BEGIN
SET @sSQL = N'SELECT M1.*, S1.DeliveryTime, S2.AmountLoss, S2.Notes, S2.OffsetQuantity, S2.ActualQuantity
					 , A2.PhaseName AS PhaseNext, A3.PhaseName AS PhasePrevious
					 , CONCAT(ISNULL(S2.Length, 0), '' x '', ISNULL(S2.Width, 0), '' x  '', ISNULL(S2.Height, 0)) AS SizeProduct
					, '''' AS MachineName
			  FROM MT2160 M1 WITH (NOLOCK)
				  LEFT JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.EstimateID = M1.MOrderID
				  LEFT JOIN OT2203 OT03 WITH (NOLOCK) ON OT03.APK_OT2202 = OT02.APK AND OT03.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON S1.APK = OT02.InheritTransactionID
				  LEFT JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2082 S3 WITH (NOLOCK) ON S1.APK = S3.APKMaster AND M1.PhaseID = ''07'' --- Cần biết công đoạn Đóng kim mã là gì để thay vào 07 -> lấy được công đoạn trước sau
				  LEFT JOIN AT1302 A4 WITH (NOLOCK) ON S3.MaterialID = A4.InventoryID
				  LEFT JOIN MT2120 M2 WITH (NOLOCK) ON M2.NodeID = M1.ProductID
				  LEFT JOIN MT2130 M3 WITH (NOLOCK) ON M3.RoutingID = OT03.RoutingID
				  LEFT JOIN MT2131 M4 WITH (NOLOCK) ON M4.APKMaster = M3.APK AND M1.PhaseID = M4.PhaseID
				  LEFT JOIN MT2131 M5 WITH (NOLOCK) ON M5.APKMaster = M3.APK AND M5.PhaseOrder = M4.NextOrders
				  LEFT JOIN AT0126 A2 WITH (NOLOCK) ON M5.PhaseID = A2.PhaseID
				  LEFT JOIN MT0099 M7 WITH (NOLOCK) ON S2.FileUnitID = M7.ID AND M7.CodeMaster = ''UnitSize''
				  LEFT JOIN MT2131 M8 WITH (NOLOCK) ON M8.APKMaster = M3.APK AND M8.PhaseOrder = M4.PreviousOrders 
				  LEFT JOIN AT0126 A3 WITH (NOLOCK) ON M8.PhaseID = A3.PhaseID
			  WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''
END
ELSE IF (@CommandType) = '12'
-- Loại lệnh kiểm phẩm và đóng gói
BEGIN
SET @InventoryID = (SELECT ProductID FROM MT2160 WITH (NOLOCK) WHERE DivisionID IN ('@@@', '' + @DivisionID + '') AND CONVERT(VARCHAR(50), APK) = '' + @APK + '')

SET @sSQL = N' DECLARE @TempLenhDongGoi TABLE (PhaseID VARCHAR(50), InventoryID VARCHAR(50), Method NVARCHAR(MAX),StandardName NVARCHAR(MAX))
							 DECLARE @Cur CURSOR,
							 	  @PhaseID VARCHAR(50) = '''',
							 	  @InventoryID VARCHAR(50) = '''',
							 	  @Method NVARCHAR(MAX) = N'''',
							 	  @LMethod NVARCHAR(MAX) = N'''',
							 	  @StandardName NVARCHAR(MAX) = N'''',
							 	  @LStandardName NVARCHAR(MAX) = N'''',
							 	  @CountData INT = (SELECT COUNT (*) FROM QCT2002 Q1 WITH (NOLOCK)
							 	LEFT JOIN QCT2001 Q2 WITH (NOLOCK) ON Q1.APKMaster = Q2.APK
							 	LEFT JOIN QCT1000 Q3 WITH (NOLOCK) ON Q1.StandardID = Q3.StandardID
							 	 where Q2.InventoryID = ''' + @InventoryID + ''' AND Q2.PhaseID =''09'')
							 
							 SET @Cur = CURSOR SCROLL KEYSET FOR
							  select Q2.PhaseID, Q2.InventoryID, Q1.Method, Q3.StandardName from QCT2002 Q1 WITH (NOLOCK)
							 	LEFT JOIN QCT2001 Q2 WITH (NOLOCK) ON Q1.APKMaster = Q2.APK
							 	LEFT JOIN QCT1000 Q3 WITH (NOLOCK) ON Q1.StandardID = Q3.StandardID
							 	 where Q2.InventoryID = ''' + @InventoryID + ''' AND Q2.PhaseID =''09''
							 OPEN @Cur
							 FETCH NEXT FROM @Cur INTO @PhaseID, @InventoryID, @Method, @StandardName
							 WHILE @@FETCH_STATUS = 0
							 BEGIN
							 	  IF (@CountData > 1)
							 	  BEGIN
							 		  SET @PhaseID = @PhaseID
							 		  SET @InventoryID = @InventoryID
							 		  SET @LMethod = @LMethod + @Method 
							 		  SET @LStandardName = @LStandardName  + @StandardName
							 	  END
							 	  ELSE
							 	  BEGIN
							 		  SET @PhaseID = @PhaseID
							 		  SET @InventoryID = @InventoryID
							 		  SET @LMethod = @LMethod + '', '' + @Method 
							 		  SET @LStandardName = @LStandardName + '', '' + @StandardName
							 		  INSERT INTO @TempLenhDongGoi VALUES (@PhaseID, @InventoryID, @LMethod, @LStandardName)
							 	  END
							 FETCH NEXT FROM @Cur INTO @PhaseID, @InventoryID, @Method, @StandardName
							 SET @CountData = @CountData - 1
							 END

							 CLOSE @Cur
							 DEALLOCATE @Cur; 

			SELECT M1.*, S1.DeliveryTime, S2.AmountLoss, S2.Notes, S2.OffsetQuantity, S2.ActualQuantity
					 , A2.PhaseName AS PhaseNext, A3.PhaseName AS PhasePrevious
					 , CONCAT (ISNULL (S2.Length, 0) , '' x '', ISNULL (S2.Width, 0), '' x  '', ISNULL (S2.Height, 0)) AS SizeProduct
					 , A5.Method AS TypeCheck
					 , A5.StandardName AS Packing
					, '''' AS MachineName
			  FROM MT2160 M1 WITH (NOLOCK)
				  LEFT JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.EstimateID = M1.MOrderID
				  LEFT JOIN OT2203 OT03 WITH (NOLOCK) ON OT03.APK_OT2202 = OT02.APK AND OT03.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON S1.APK = OT02.InheritTransactionID
				  LEFT JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2082 S3 WITH (NOLOCK) ON S1.APK = S3.APKMaster AND M1.PhaseID = ''09'' --- Cần biết công đoạn Đóng gói mã là gì để thay vào 09 -> lấy được công đoạn trước sau
				  LEFT JOIN AT1302 A4 WITH (NOLOCK) ON S3.MaterialID = A4.InventoryID
				  LEFT JOIN MT2120 M2 WITH (NOLOCK) ON M2.NodeID = M1.ProductID
				  LEFT JOIN MT2130 M3 WITH (NOLOCK) ON M3.RoutingID = OT03.RoutingID
				  LEFT JOIN MT2131 M4 WITH (NOLOCK) ON M4.APKMaster = M3.APK AND M1.PhaseID = M4.PhaseID
				  LEFT JOIN MT2131 M5 WITH (NOLOCK) ON M5.APKMaster = M3.APK AND M5.PhaseOrder = M4.NextOrders
				  LEFT JOIN AT0126 A2 WITH (NOLOCK) ON M5.PhaseID = A2.PhaseID
				  LEFT JOIN MT0099 M7 WITH (NOLOCK) ON S2.FileUnitID = M7.ID AND M7.CodeMaster = ''UnitSize''
				  LEFT JOIN MT2131 M8 WITH (NOLOCK) ON M8.APKMaster = M3.APK AND M8.PhaseOrder = M4.PreviousOrders 
				  LEFT JOIN AT0126 A3 WITH (NOLOCK) ON M8.PhaseID = A3.PhaseID
				  LEFT JOIN @TempLenhDongGoi A5 ON A5.PhaseID = M1.PhaseID
			  WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''
END
ELSE IF (@CommandType) = '13'
-- Loại lệnh chạy sóng
BEGIN
SET @sSQL = N'SELECT M1.*, S1.DeliveryTime, S2.AmountLoss, S2.Notes, S2.OffsetQuantity, S2.ActualQuantity
					 , CONCAT( ISNULL(S2.Length, 0), '' x '', ISNULL(S2.Width, 0), '' x  '', ISNULL(S2.Height, 0)) AS SizeProduct
					 , CONCAT(ISNULL(S2.Length, 0), '' x '', ISNULL(S2.Width, 0), '' x  '', ISNULL(S2.Height, 0)) AS SizePaperFirst, '''' AS SizeCommune, '''' AS OutPaper
					 , A2.PhaseName AS PhaseNext, A3.PhaseName AS PhasePrevious
					, ISNULL(CI50.MachineName, '''') AS MachineName
			  FROM MT2160 M1 WITH (NOLOCK)
				  LEFT JOIN OT2202 OT02 WITH (NOLOCK) ON OT02.EstimateID = M1.MOrderID
				  LEFT JOIN OT2203 OT03 WITH (NOLOCK) ON OT03.APK_OT2202 = OT02.APK AND OT03.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON S1.APK = OT02.InheritTransactionID
				  LEFT JOIN SOT2081 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.SemiProduct = M1.ProductID
				  LEFT JOIN SOT2082 S3 WITH (NOLOCK) ON S1.APK = S3.APKMaster AND S3.APK_SOT2081 = S2.APK AND S3.PhaseID = ''' + @PhaseID + '''
				  LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S3.MaterialID = A1.InventoryID
				  LEFT JOIN MT2120 M2 WITH (NOLOCK) ON M2.NodeID = M1.ProductID
				  LEFT JOIN MT2130 M3 WITH (NOLOCK) ON M3.RoutingID = OT03.RoutingID
				  LEFT JOIN MT2131 M4 WITH (NOLOCK) ON M4.APKMaster = M3.APK AND M1.PhaseID = M4.PhaseID
				  LEFT JOIN MT2131 M5 WITH (NOLOCK) ON M5.APKMaster = M3.APK AND M5.PhaseOrder = M4.NextOrders
				  LEFT JOIN AT0126 A2 WITH (NOLOCK) ON M5.PhaseID = A2.PhaseID
				  LEFT JOIN MT0099 M6 WITH (NOLOCK) ON S3.UnitSizeID = M6.ID AND M6.CodeMaster = ''UnitSize''
				  LEFT JOIN MT0099 M7 WITH (NOLOCK) ON S2.FileUnitID = M7.ID AND M7.CodeMaster = ''UnitSize''
				  --LEFT JOIN SOT2082 S4 WITH (NOLOCK) ON S1.APK = S4.APKMaster AND S4.PhaseID = ''' + @PhasePrint + '''
				  LEFT JOIN MT2131 M8 WITH (NOLOCK) ON M8.APKMaster = M3.APK AND M8.PhaseOrder = M4.PreviousOrders 
				  LEFT JOIN AT0126 A3 WITH (NOLOCK) ON M8.PhaseID = A3.PhaseID
				  LEFT JOIN CIT1150 CI50 WITH (NOLOCK) ON CI50.MachineID = M1.MachineID
			  WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''
END

PRINT (@sSQL)
EXEC (@sSQL)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
