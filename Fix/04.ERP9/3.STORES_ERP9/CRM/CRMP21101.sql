IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP21101]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP21101]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO












-- <Summary>
---		In dự toán 
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Kiều Nga, Date: 14/02/2020
----Modified by: Trọng Kiên, Date: 16/12/2020: Fix load dữ liệu phiếu in dự toán
----Modified by: Kiều Nga, Date: 25/05/2021: Fix lỗi chưa load chạy giấy, tình trạng khuôn
--- Modified on ... by ...:
/* <Example>
EXEC CRMP21101 
*/
 CREATE PROCEDURE CRMP21101
(
 	@DivisionID VARCHAR(50),
	@APK VARCHAR(50)
)
AS
DECLARE @sSQL01 NVARCHAR(MAX) ='', 
		@sSQL02 NVARCHAR(MAX) ='',
		@sFROM02 NVARCHAR(MAX) ='',
		@sSQL01_1 NVARCHAR(MAX) =''

SET @sSQL01 = N'SELECT C1.VoucherNo ,C1.ObjectID, P1.MemberName AS ObjectName, C1.DeliveryTime, C1.DeliveryAddressName, C1.InventoryID, A1.InventoryName, C2.ActualQuantity, A2.UnitName, CONCAT(C2.Length, '' x '', C2.Width, '' x '', C2.Height) AS Dimension,
                       C3.Description AS PaperTypeName, C2.FileName, C2.FilmDate, C4.Description AS FilmStatus, C2.OffsetQuantity, C2.AmountLoss, C2.PercentLoss,
					   CASE
					       WHEN ISNULL(C2.ColorPrint01, '''') <> '''' THEN CASE WHEN LEN(C2.ColorPrint01) - LEN(REPLACE(C2.ColorPrint01, '','', '''')) > 0 THEN CONCAT(CONVERT(VARCHAR, (LEN(C2.ColorPrint01) - LEN(REPLACE(C2.ColorPrint01, '','', '''')) + 1)), N'' Màu'')
						                                                        ELSE  N''1 Màu''
																				END
						   ELSE ''''
					   END AS ColorPrint01,
					   CASE
					       WHEN ISNULL(C2.ColorPrint02, '''') <> '''' THEN CASE WHEN LEN(C2.ColorPrint02) - LEN(REPLACE(C2.ColorPrint02, '','', '''')) > 0 THEN CONCAT(CONVERT(VARCHAR, (LEN(C2.ColorPrint02) - LEN(REPLACE(C2.ColorPrint02, '','', '''')) + 1)), N'' Màu'')
						                                                        ELSE  N''1 Màu''
																				END
						   ELSE ''''
					   END AS ColorPrint02,
	                   C2.PercentCost, C2.Cost, C2.PercentProfit, C2.Profit, C2.TotalVariableFee, C2.InvenUnitPrice, C2.SquareMetersPrice, C2.ExchangeRate, C2.CurrencyID, A3.CurrencyName,
					   CONCAT (CONVERT(INT, ISNULL(C2.FileLength, 0)), '' x '', CONVERT(INT, ISNULL(C2.FileWidth, 0)), N'' = '', CONVERT(INT, ISNULL(C2.FileSum, 0))) AS DimensionFile, C2.Include,
					   C2.ContentSampleDate, C2.ColorSampleDate, C2.MTSignedSampleDate, C2.Notes, M1.Description AS FileUnitName
                FROM CRMT2110 C1 WITH (NOLOCK) 
                    LEFT JOIN POST0011 P1 WITH (NOLOCK) ON P1.MemberID = C1.ObjectID
                    LEFT JOIN AT1302 A1 WITH (NOLOCK) ON A1.InventoryID = C1.InventoryID
                    LEFT JOIN CRMT2111 C2 WITH (NOLOCK) ON C2.APKMaster = C1.APK
                    LEFT JOIN AT1304 A2 WITH (NOLOCK) ON A2.UnitID = A1.UnitID
                    LEFT JOIN CRMT0099 C3 WITH (NOLOCK) ON C3.ID = C2.PrintTypeID AND C3.CodeMaster = ''CRMF2111.PrintTypeID''
                    LEFT JOIN CRMT0099 C4 WITH (NOLOCK) ON C4.ID = C2.FilmStatus AND C4.CodeMaster = ''CRMF2111.Status''
                    LEFT JOIN AT1004 A3 WITH (NOLOCK) ON A3.CurrencyID = C2.CurrencyID
					LEFT JOIN MT0099 M1 WITH (NOLOCK) ON M1.ID = C2.FileUnitID AND M1.CodeMaster = ''UnitSize''
                WHERE C1.DivisionID IN (''@@@'', '''+ @DivisionID +''') AND C1.APK = '''+ @APK +''''

SET @sSQL02 = N'SELECT C1.PhaseID, A1.PhaseName, CASE
                                         WHEN ISNULL(C1.Size, 0) <> 0 THEN CONCAT (CONVERT(INT, ISNULL(C1.Size, 0)), '' x '', CONVERT(INT, ISNULL(C1.Cut, 0)), '' = '', CONVERT(INT, ISNULL(C1.Child, 0)), '' '', M1.Description)
										 WHEN ISNULL(C1.Cut, 0) <> 0 THEN CONCAT (CONVERT(INT, ISNULL(C1.Size, 0)), '' x '', CONVERT(INT, ISNULL(C1.Cut, 0)), '' = '', CONVERT(INT, ISNULL(C1.Child, 0)), '' '', M1.Description)
										 WHEN ISNULL(C1.Child, 0) <> 0 THEN CONCAT (CONVERT(INT, ISNULL(C1.Size, 0)), '' x '', CONVERT(INT, ISNULL(C1.Cut, 0)), '' = '', CONVERT(INT, ISNULL(C1.Child, 0)), '' '', M1.Description)
										 ELSE ''''
									 END AS DimensionDetail,
					   CONCAT(
					          IIF(C1.PrintTypeID <> '''', CONCAT(N''- Cách in: '', C2.Description, CHAR(13), CHAR(10)), ''''),
							  IIF(C1.SplitSheets <> 0, CONCAT(N''- Chia tờ: '', CONVERT(INT, ISNULL(C1.SplitSheets, 0)), CHAR(13), CHAR(10)), ''''),
							  IIF(C1.RunPaperID <> '''', CONCAT(N''- Chạy giấy: '', C3.Description, CHAR(13), CHAR(10)), ''''),
							  IIF(C1.RunWavePaper <> '''', CONCAT(N''- Sóng: '', C1.RunWavePaper, CHAR(13), CHAR(10)), ''''),
							  IIF(C1.QuantityRunWave <> 0, CONCAT(N''- SL tờ chạy sóng: '', CONVERT(INT, C1.QuantityRunWave), CHAR(13), CHAR(10)), ''''),
							  IIF(C1.MoldID <> '''', CONCAT(N''- Mã khuôn: '', C1.MoldID, CHAR(13), CHAR(10)), ''''),
							  IIF(C1.MoldStatusID <> '''', CONCAT(N''- Tình trạng khuôn: '', C4.Description, CHAR(13), CHAR(10)), ''''),
							  IIF(C1.MoldDate <> '''', CONCAT(N''- Ngày khuôn: '', CONVERT(VARCHAR, C1.MoldDate, 103)), '''')
							 ) AS Description,
					   CASE 
					       WHEN C1.DisplayName <> '''' THEN CONCAT(M2.Description, '': '', A2.InventoryName)
						   ELSE A2.InventoryName
					   END AS MaterialName, A3.UnitName AS UnitNameDetail,
					   CASE
					       WHEN ISNULL(C1.GSM, 0) <> 0 THEN CONCAT(CONVERT(INT, ISNULL(C1.GSM, 0)), '' x '',CONVERT(INT, ISNULL(C1.Sheets, 0)), '' x '', CONVERT(INT, ISNULL(C1.Ram, 0)), '' x '', CONVERT(INT, ISNULL(C1.Kg, 0)))
						   WHEN ISNULL(C1.Sheets, 0) <> 0 THEN CONCAT(CONVERT(INT, ISNULL(C1.GSM, 0)), '' x '',CONVERT(INT, ISNULL(C1.Sheets, 0)), '' x '', CONVERT(INT, ISNULL(C1.Ram, 0)), '' x '', CONVERT(INT, ISNULL(C1.Kg, 0)))
						   WHEN ISNULL(C1.Ram, 0) <> 0 THEN CONCAT(CONVERT(INT, ISNULL(C1.GSM, 0)), '' x '',CONVERT(INT, ISNULL(C1.Sheets, 0)), '' x '', CONVERT(INT, ISNULL(C1.Ram, 0)), '' x '', CONVERT(INT, ISNULL(C1.Kg, 0)))
						   WHEN ISNULL(C1.Kg, 0) <> 0 THEN CONCAT(CONVERT(INT, ISNULL(C1.GSM, 0)), '' x '',CONVERT(INT, ISNULL(C1.Sheets, 0)), '' x '', CONVERT(INT, ISNULL(C1.Ram, 0)), '' x '', CONVERT(INT, ISNULL(C1.Kg, 0)))
						   ELSE ''''
	                   END AS Quantitative,
	                   CASE
					       WHEN C1.Quantity <> 0 THEN C1.Quantity
						   ELSE NULL
					   END AS Quantity,
					   CASE
					       WHEN C1.UnitPrice <> 0 THEN C1.UnitPrice
						   ELSE NULL
					   END AS UnitPrice,
					   CASE
					       WHEN C1.Amount <> 0 THEN C1.Amount
						   ELSE NULL
					   END AS Amount,
					   C1.AmountLoss AS AmountLossDetail, C1.PercentLoss AS PercentLossDetail, C1.PhaseOrder'
SET @sFROM02 = N' FROM CRMT2114 C1 WITH (NOLOCK)
                     LEFT JOIN AT0126 A1 WITH (NOLOCK) ON A1.PhaseID = C1.PhaseID
                     LEFT JOIN CRMT0099 C2 WITH (NOLOCK) ON C2.ID = C1.PrintTypeID AND C2.CodeMaster = ''CRMF2111.PrintType''
                     LEFT JOIN CRMT0099 C3 WITH (NOLOCK) ON C3.ID = C1.RunPaperID AND C3.CodeMaster = ''CRMF2111.RunPaper''
                     LEFT JOIN CRMT0099 C4 WITH (NOLOCK) ON C4.ID = C1.MoldStatusID AND C4.CodeMaster = ''CRMF2111.Status''
                     LEFT JOIN AT1302 A2 WITH (NOLOCK) ON A2.InventoryID = C1.MaterialID
                     LEFT JOIN AT1304 A3 WITH (NOLOCK) ON A3.UnitID = C1.UnitID
					 LEFT JOIN MT0099 M1 WITH (NOLOCK) ON M1.ID = C1.UnitSizeID AND M1.CodeMaster = ''UnitSize''
					 LEFT JOIN MT0099 M2 WITH (NOLOCK) ON M2.ID = C1.DisplayName AND M2.CodeMaster = ''DisplayName''
                 WHERE C1.DivisionID IN (''@@@'', '''+ @DivisionID +''') AND C1.APKMaster = '''+ @APK +'''
                 ORDER BY C1.PhaseID, C1.PhaseOrder'
PRINT @sSQL02
PRINT @sFROM02
EXEC (@sSQL01 + @sSQL02 + @sFROM02)










GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
