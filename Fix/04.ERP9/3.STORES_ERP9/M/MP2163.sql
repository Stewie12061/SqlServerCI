IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[MP2163]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[MP2163]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




----Created by	: Trọng Kiên, date: 19/04/2021
----Modified by	: Văn Tài   , date: 17/04/2023 - Xử lý fix lỗi in lệnh sản xuất. Sai tên cột và loại bỏ sử dụng biến bảng bên trong.
---- exec MP2163 @Divisionid=N'ANG',@Tranmonth=1,@Tranyear=2016,@APK=N''

CREATE PROCEDURE [dbo].[MP2163] 
				@DivisionID AS nvarchar(50),
				@APK AS nvarchar(4000),
				@CommandType AS Varchar(50),
				@TranMonth AS int,
				@TranYear AS int

AS

DECLARE @sSQL NVARCHAR(MAX) ='', 
		@PhaseCut VARCHAR(50),
		@PhasePrint VARCHAR(50),
		@PhaseWave VARCHAR(50)

SET @PhaseCut = (SELECT CutPhaseID FROM CRMT00000 WHERE DivisionID = ''+ @DivisionID +'')
SET @PhasePrint = (SELECT PrintPhaseID FROM CRMT00000 WHERE DivisionID = ''+ @DivisionID +'')
SET @PhaseWave = (SELECT WavePhaseID FROM CRMT00000 WHERE DivisionID = ''+ @DivisionID +'')

IF (@CommandType) = '0'
SET @sSQL = N'SELECT S2.MaterialID, A1.InventoryName AS MaterialName
			  , CASE WHEN ISNULL(S2.Gsm, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Gsm)
			  			  WHEN ISNULL(S2.Sheets, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Sheets)
			  			  WHEN ISNULL(S2.Ram, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Ram)
			  			  WHEN ISNULL(S2.Kg, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Kg)
			  			  WHEN ISNULL(S2.M2, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.M2) END AS MaterialQuantity
			  , CASE WHEN ISNULL(S2.Size, 0) <> 0 AND ISNULL(S2.Cut, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0),S2.Size),'' x '', CONVERT(DECIMAL(28,0),S2.Cut))
					 ELSE '''' END AS SizePaperFirst
	FROM MT2160 M1 WITH (NOLOCK)
	LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON M1.MOrderID = S1.VoucherNo
	LEFT JOIN SOT2082 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster
	LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S2.MaterialID = A1.InventoryID
WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''

IF (@CommandType) = '1'
SET @sSQL = N'SELECT S2.MaterialID, A1.InventoryName AS MaterialName
			  , CASE WHEN ISNULL(S2.Gsm, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Gsm)
			  			  WHEN ISNULL(S2.Sheets, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Sheets)
			  			  WHEN ISNULL(S2.Ram, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Ram)
			  			  WHEN ISNULL(S2.Kg, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Kg)
			  			  WHEN ISNULL(S2.M2, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.M2) END AS MaterialQuantity
			  , CASE WHEN ISNULL(S2.Size, 0) <> 0 AND ISNULL(S2.Cut, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0),S2.Size),'' x '', CONVERT(DECIMAL(28,0),S2.Cut))
					 ELSE '''' END AS SizePaperFirst
	FROM MT2160 M1 WITH (NOLOCK)
	LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON M1.MOrderID = S1.VoucherNo
	LEFT JOIN SOT2082 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster
	LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S2.MaterialID = A1.InventoryID
WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''

IF (@CommandType) = '2'
SET @sSQL = N'SELECT S2.MaterialID, A1.InventoryName AS MaterialName
			  , CASE WHEN ISNULL(S2.Gsm, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Gsm)
			  			  WHEN ISNULL(S2.Sheets, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Sheets)
			  			  WHEN ISNULL(S2.Ram, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Ram)
			  			  WHEN ISNULL(S2.Kg, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Kg)
			  			  WHEN ISNULL(S2.M2, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.M2) END AS MaterialQuantity
			  , CASE WHEN ISNULL(S2.Size, 0) <> 0 AND ISNULL(S2.Cut, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0),S2.Size),'' x '', CONVERT(DECIMAL(28,0),S2.Cut))
					 ELSE '''' END AS SizePaperFirst
	FROM MT2160 M1 WITH (NOLOCK)
	LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON M1.MOrderID = S1.VoucherNo
	LEFT JOIN SOT2082 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster
	LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S2.MaterialID = A1.InventoryID
WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''

IF (@CommandType) = '3'
SET @sSQL = N'SELECT S2.MaterialID, A1.InventoryName AS MaterialName
			  , CASE WHEN ISNULL(S2.Gsm, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Gsm)
			  			  WHEN ISNULL(S2.Sheets, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Sheets)
			  			  WHEN ISNULL(S2.Ram, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Ram)
			  			  WHEN ISNULL(S2.Kg, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Kg)
			  			  WHEN ISNULL(S2.M2, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.M2) END AS MaterialQuantity
			  , CASE WHEN ISNULL(S2.Size, 0) <> 0 AND ISNULL(S2.Cut, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0),S2.Size),'' x '', CONVERT(DECIMAL(28,0),S2.Cut))
					 ELSE '''' END AS SizePaperFirst
	FROM MT2160 M1 WITH (NOLOCK)
	LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON M1.MOrderID = S1.VoucherNo
	LEFT JOIN SOT2082 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster
	LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S2.MaterialID = A1.InventoryID
WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''

IF (@CommandType) = '4'
SET @sSQL = N'SELECT S2.MaterialID, A1.InventoryName AS MaterialName, M2.Description AS TypeWave

	FROM MT2160 M1 WITH (NOLOCK)
	LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON M1.MOrderID = S1.VoucherNo
	LEFT JOIN SOT2082 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.PhaseID = ''' + @PhaseWave + ''' AND S2.KindOfSuppliersID = ''SONG''
	LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S2.MaterialID = A1.InventoryID
	LEFT JOIN MT0099 M2 WITH (NOLOCK) ON S2.DisplayName = M2.ID AND M2.CodeMaster = ''DisplayName''
WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''

IF (@CommandType) = '5'
SET @sSQL = N'SELECT S2.MaterialID, A1.InventoryName AS MaterialName, ISNULL(S2.Size, 0) AS Size, M2.Description AS Type
			  , CASE WHEN ISNULL(S2.Gsm, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Gsm)
			    						  WHEN ISNULL(S2.Sheets, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Sheets)
			    						  WHEN ISNULL(S2.Ram, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Ram)
			    						  WHEN ISNULL(S2.Kg, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Kg)
			    						  WHEN ISNULL(S2.M2, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.M2) END AS MaterialQuantity

	FROM MT2160 M1 WITH (NOLOCK)
	LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON M1.MOrderID = S1.VoucherNo
	LEFT JOIN SOT2082 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.PhaseID = ''03'' AND S2.KindOfSuppliersID = ''CANMANG'' --- Đang set cứng PhaseID là 03 -> cần có gì để phân biệt công đoạn như cắt, sóng, in
	LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S2.MaterialID = A1.InventoryID
	LEFT JOIN MT0099 M2 WITH (NOLOCK) ON S2.DisplayName = M2.ID AND M2.CodeMaster = ''DisplayName''
WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''

IF (@CommandType) = '6'
SET @sSQL = N'SELECT S2.MaterialID, A1.InventoryName AS MaterialName
			  , CASE WHEN ISNULL(S2.Gsm, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Gsm)
			  			  WHEN ISNULL(S2.Sheets, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Sheets)
			  			  WHEN ISNULL(S2.Ram, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Ram)
			  			  WHEN ISNULL(S2.Kg, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Kg)
			  			  WHEN ISNULL(S2.M2, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.M2) END AS MaterialQuantity
			  , CASE WHEN ISNULL(S2.Size, 0) <> 0 AND ISNULL(S2.Cut, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0),S2.Size),'' x '', CONVERT(DECIMAL(28,0),S2.Cut))
					 ELSE '''' END AS SizePaperFirst
	FROM MT2160 M1 WITH (NOLOCK)
	LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON M1.MOrderID = S1.VoucherNo
	LEFT JOIN SOT2082 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster
	LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S2.MaterialID = A1.InventoryID
WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''

IF (@CommandType) = '7'
SET @sSQL = N'SELECT S2.MaterialID, A1.InventoryName AS MaterialName
			  , CASE WHEN ISNULL(S2.Gsm, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Gsm)
			  			  WHEN ISNULL(S2.Sheets, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Sheets)
			  			  WHEN ISNULL(S2.Ram, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Ram)
			  			  WHEN ISNULL(S2.Kg, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Kg)
			  			  WHEN ISNULL(S2.M2, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.M2) END AS MaterialQuantity
			  , CASE WHEN ISNULL(S2.Size, 0) <> 0 AND ISNULL(S2.Cut, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0),S2.Size),'' x '', CONVERT(DECIMAL(28,0),S2.Cut))
					 ELSE '''' END AS SizePaperFirst
	FROM MT2160 M1 WITH (NOLOCK)
	LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON M1.MOrderID = S1.VoucherNo
	LEFT JOIN SOT2082 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster
	LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S2.MaterialID = A1.InventoryID
WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''

IF (@CommandType) = '8'
SET @sSQL = N'SELECT S2.MaterialID, A1.InventoryName AS MaterialName
			  , CASE WHEN ISNULL(S2.Gsm, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Gsm)
			  			  WHEN ISNULL(S2.Sheets, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Sheets)
			  			  WHEN ISNULL(S2.Ram, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Ram)
			  			  WHEN ISNULL(S2.Kg, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Kg)
			  			  WHEN ISNULL(S2.M2, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.M2) END AS MaterialQuantity
			  , CASE WHEN ISNULL(S2.Size, 0) <> 0 AND ISNULL(S2.Cut, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0),S2.Size),'' x '', CONVERT(DECIMAL(28,0),S2.Cut))
					 ELSE '''' END AS SizePaperFirst
	FROM MT2160 M1 WITH (NOLOCK)
	LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON M1.MOrderID = S1.VoucherNo
	LEFT JOIN SOT2082 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster
	LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S2.MaterialID = A1.InventoryID
WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''

IF (@CommandType) = '9'
SET @sSQL = N'SELECT S2.MaterialID, A1.InventoryName AS MaterialName
			  , CASE WHEN ISNULL(S2.Gsm, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Gsm)
			  			  WHEN ISNULL(S2.Sheets, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Sheets)
			  			  WHEN ISNULL(S2.Ram, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Ram)
			  			  WHEN ISNULL(S2.Kg, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Kg)
			  			  WHEN ISNULL(S2.M2, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.M2) END AS MaterialQuantity
			  , CASE WHEN ISNULL(S2.Size, 0) <> 0 AND ISNULL(S2.Cut, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0),S2.Size),'' x '', CONVERT(DECIMAL(28,0),S2.Cut))
					 ELSE '''' END AS SizePaperFirst
	FROM MT2160 M1 WITH (NOLOCK)
	LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON M1.MOrderID = S1.VoucherNo
	LEFT JOIN SOT2082 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster
	LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S2.MaterialID = A1.InventoryID
WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''

IF (@CommandType) = '10'
SET @sSQL = N'SELECT S2.MaterialID, A1.InventoryName AS MaterialName
			  , CASE WHEN ISNULL(S2.Gsm, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Gsm)
			  			  WHEN ISNULL(S2.Sheets, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Sheets)
			  			  WHEN ISNULL(S2.Ram, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Ram)
			  			  WHEN ISNULL(S2.Kg, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Kg)
			  			  WHEN ISNULL(S2.M2, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.M2) END AS MaterialQuantity
			  , CASE WHEN ISNULL(S2.Size, 0) <> 0 AND ISNULL(S2.Cut, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0),S2.Size),'' x '', CONVERT(DECIMAL(28,0),S2.Cut))
					 ELSE '''' END AS SizePaperFirst
	FROM MT2160 M1 WITH (NOLOCK)
	LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON M1.MOrderID = S1.VoucherNo
	LEFT JOIN SOT2082 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster
	LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S2.MaterialID = A1.InventoryID
WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''

IF (@CommandType) = '12'
SET @sSQL = N'SELECT S2.MaterialID, A1.InventoryName AS MaterialName
			  , CASE WHEN ISNULL(S2.Gsm, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Gsm)
			  			  WHEN ISNULL(S2.Sheets, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Sheets)
			  			  WHEN ISNULL(S2.Ram, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Ram)
			  			  WHEN ISNULL(S2.Kg, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.Kg)
			  			  WHEN ISNULL(S2.M2, 0) > 0 THEN CONVERT(DECIMAL(28,0),S2.M2) END AS MaterialQuantity
			  , CASE WHEN ISNULL(S2.Size, 0) <> 0 AND ISNULL(S2.Cut, 0) <> 0 THEN CONCAT(CONVERT(DECIMAL(28,0),S2.Size),'' x '', CONVERT(DECIMAL(28,0),S2.Cut))
					 ELSE '''' END AS SizePaperFirst
	FROM MT2160 M1 WITH (NOLOCK)
	LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON M1.MOrderID = S1.VoucherNo
	LEFT JOIN SOT2082 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster
	LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S2.MaterialID = A1.InventoryID
WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''

IF (@CommandType) = '13'
SET @sSQL = N'SELECT A1.InventoryName AS MaterialName, M2.Description AS TypePacking
	FROM MT2160 M1 WITH (NOLOCK)
	LEFT JOIN SOT2080 S1 WITH (NOLOCK) ON M1.MOrderID = S1.VoucherNo
	LEFT JOIN SOT2082 S2 WITH (NOLOCK) ON S1.APK = S2.APKMaster AND S2.PhaseID = ''09'' AND S2.KindOfSuppliersID = ''DONGGOI'' --- Đang set cứng PhaseID là 09 -> cần có gì để phân biệt công đoạn như cắt, sóng, in
	LEFT JOIN AT1302 A1 WITH (NOLOCK) ON S2.MaterialID = A1.InventoryID
	LEFT JOIN MT0099 M2 WITH (NOLOCK) ON S2.DisplayName = M2.ID AND M2.CodeMaster = ''DisplayName''
WHERE M1.DivisionID IN (''@@@'', ''' + @DivisionID + ''') AND CONVERT(VARCHAR(50), M1.APK) = ''' + @APK + ''''

EXEC (@sSQL)
PRINT @sSQL




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
