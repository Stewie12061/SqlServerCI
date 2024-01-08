IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20801]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20801]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










-- <Summary>
---		In phiếu thông tin sản xuất 
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Kiều Nga, Date: 16/03/2020
----Modified by: Trọng Kiên, Date: 17/12/2020: Fix phiếu in thông tin sản xuất
----Modified by: Viết Toàn, Date: 01/02/2023: Bổ sung Param APK của bán thành phẩm
--- Modified on ... by ...:
/* <Example>
EXEC SOP20801 
*/
 CREATE PROCEDURE SOP20801
(
 	@DivisionID VARCHAR(50),
	@APK VARCHAR(50),
	@APKSemiProduct VARCHAR(50)
)
AS
DECLARE @sSQL01 NVARCHAR(MAX) ='', 
		@sSQL02 NVARCHAR(MAX) ='',
		@sFROM02 NVARCHAR(MAX) ='',
		@sSQL01_1 NVARCHAR(MAX) =''


SET @sSQL01 = N'SELECT S1.VoucherNo ,S1.ObjectID, P1.MemberName AS ObjectName, S1.DeliveryTime, S1.DeliveryAddressName, S2.SemiProduct AS InventoryID, A1.InventoryName, S2.ActualQuantity, A2.UnitName, CONCAT(S2.Length, '' x '', S2.Width, '' x '', S2.Height) AS Dimension,
                       C3.Description AS PaperTypeName, S2.FileName, S2.FilmDate, C4.Description AS FilmStatus, S2.OffsetQuantity, S2.AmountLoss, S2.PercentLoss,
					   CASE
					       WHEN ISNULL(S2.ColorPrint01, '''') <> '''' THEN CASE WHEN LEN(S2.ColorPrint01) - LEN(REPLACE(S2.ColorPrint01, '','', '''')) > 0 THEN CONCAT(CONVERT(VARCHAR, (LEN(S2.ColorPrint01) - LEN(REPLACE(S2.ColorPrint01, '','', '''')) + 1)), N'' Màu'')
						                                                        ELSE  N''1 Màu''
																				END
						   ELSE ''''
					   END AS ColorPrint01,
					   CASE
					       WHEN ISNULL(S2.ColorPrint02, '''') <> '''' THEN CASE WHEN LEN(S2.ColorPrint02) - LEN(REPLACE(S2.ColorPrint02, '','', '''')) > 0 THEN CONCAT(CONVERT(VARCHAR, (LEN(S2.ColorPrint02) - LEN(REPLACE(S2.ColorPrint02, '','', '''')) + 1)), N'' Màu'')
						                                                        ELSE  N''1 Màu''
																				END
						   ELSE ''''
					   END AS ColorPrint02,	                   
					   CONCAT (CONVERT(INT, ISNULL(S2.FileLength, 0)), '' x '', CONVERT(INT, ISNULL(S2.FileWidth, 0)), N'' = '', CONVERT(INT, ISNULL(S2.FileSum, 0))) AS DimensionFile, S2.Include,
					   S2.ContentSampleDate, S2.ColorSampleDate, S2.MTSignedSampleDate, S2.Notes, S1.DeliveryNotes, M1.Description AS FileUnitName
                FROM SOT2080 S1 WITH (NOLOCK) 
                    LEFT JOIN POST0011 P1 WITH (NOLOCK) ON P1.MemberID = S1.ObjectID
                    LEFT JOIN SOT2081 S2 WITH (NOLOCK) ON S2.APKMaster = S1.APK
                    LEFT JOIN AT1302 A1 WITH (NOLOCK) ON A1.InventoryID = S2.SemiProduct
                    LEFT JOIN AT1304 A2 WITH (NOLOCK) ON A2.UnitID = A1.UnitID
                    LEFT JOIN CRMT0099 C3 WITH (NOLOCK) ON C3.ID = S2.PrintTypeID AND C3.CodeMaster = ''CRMF2111.PrintTypeID''
                    LEFT JOIN CRMT0099 C4 WITH (NOLOCK) ON C4.ID = S2.FilmStatus AND C4.CodeMaster = ''CRMF2111.Status''
					LEFT JOIN MT0099 M1 WITH (NOLOCK) ON M1.ID = S2.FileUnitID AND M1.CodeMaster = ''UnitSize''
                WHERE S1.DivisionID IN (''@@@'', '''+ @DivisionID +''') AND S1.APK = '''+ @APK +''' AND S2.APK = ''' + @APKSemiProduct + ''''

SET @sSQL02 = N'SELECT S1.PhaseID, A1.PhaseName, CASE
                                         WHEN ISNULL(S1.Size, 0) <> 0 THEN CONCAT (CONVERT(INT, ISNULL(S1.Size, 0)), '' x '', CONVERT(INT, ISNULL(S1.Cut, 0)), '' = '', CONVERT(INT, ISNULL(S1.Child, 0)), '' '', M1.Description)
										 WHEN ISNULL(S1.Cut, 0) <> 0 THEN CONCAT (CONVERT(INT, ISNULL(S1.Size, 0)), '' x '', CONVERT(INT, ISNULL(S1.Cut, 0)), '' = '', CONVERT(INT, ISNULL(S1.Child, 0)), '' '', M1.Description)
										 WHEN ISNULL(S1.Child, 0) <> 0 THEN CONCAT (CONVERT(INT, ISNULL(S1.Size, 0)), '' x '', CONVERT(INT, ISNULL(S1.Cut, 0)), '' = '', CONVERT(INT, ISNULL(S1.Child, 0)), '' '', M1.Description)
										 ELSE ''''
									 END AS DimensionDetail,
					   CONCAT(
					          IIF(S1.PrintTypeID <> '''', CONCAT(N''- Cách in: '', C2.Description, CHAR(13), CHAR(10)), ''''),
							  IIF(S1.SplitSheets <> 0, CONCAT(N''- Chia tờ: '', CONVERT(INT, ISNULL(S1.SplitSheets, 0)), CHAR(13), CHAR(10)), ''''),
							  IIF(S1.RunPaperID <> '''', CONCAT(N''- Chạy giấy: '', C3.Description, CHAR(13), CHAR(10)), ''''),
							  IIF(S1.RunWavePaper <> '''', CONCAT(N''- Sóng: '', S1.RunWavePaper, CHAR(13), CHAR(10)), ''''),
							  IIF(S1.QuantityRunWave <> 0, CONCAT(N''- SL tờ chạy sóng: '', CONVERT(INT, S1.QuantityRunWave), CHAR(13), CHAR(10)), ''''),
							  IIF(S1.MoldID <> '''', CONCAT(N''- Mã khuôn: '', S1.MoldID, CHAR(13), CHAR(10)), ''''),
							  IIF(S1.MoldStatusID <> '''', CONCAT(N''- Tình trạng khuôn: '', C4.Description, CHAR(13), CHAR(10)), ''''),
							  IIF(S1.MoldDate <> '''', CONCAT(N''- Ngày khuôn: '', CONVERT(VARCHAR, S1.MoldDate, 103), CHAR(13), CHAR(10)), ''''),
							  IIF(S1.PhaseID = ''005'', CONCAT(CASE
																   WHEN S2.ApproveWaveStatusID = ''0'' THEN N''- Tình trạng duyệt: Chờ duyệt''
																   WHEN S2.ApproveWaveStatusID = ''1'' THEN N''- Tình trạng duyệt: Duyệt''
																   WHEN S2.ApproveWaveStatusID = ''2'' THEN N''- Tình trạng duyệt: Từ chối''
															   END, CHAR(13), CHAR(10)), ''''),
							  IIF(S1.PhaseID = ''001'', CASE
															WHEN S2.ApproveCutRollStatusID = ''0'' THEN N''- Tình trạng duyệt: Chờ duyệt''
															WHEN S2.ApproveCutRollStatusID = ''1'' THEN N''- Tình trạng duyệt: Duyệt''
															WHEN S2.ApproveCutRollStatusID = ''2'' THEN N''- Tình trạng duyệt: Từ chối''
														END, '''')
							 ) AS Description,
					   CASE 
					       WHEN S1.DisplayName <> '''' THEN CONCAT(M2.Description, '': '', A2.InventoryName)
						   ELSE A2.InventoryName
					   END AS MaterialName, A3.UnitName AS UnitNameDetail,
					   CASE
					       WHEN ISNULL(S1.GSM, 0) <> 0 THEN CONCAT(CONVERT(INT, ISNULL(S1.GSM, 0)), '' x '',CONVERT(INT, ISNULL(S1.Sheets, 0)), '' x '', CONVERT(INT, ISNULL(S1.Ram, 0)), '' x '', CONVERT(INT, ISNULL(S1.Kg, 0)))
						   WHEN ISNULL(S1.Sheets, 0) <> 0 THEN CONCAT(CONVERT(INT, ISNULL(S1.GSM, 0)), '' x '',CONVERT(INT, ISNULL(S1.Sheets, 0)), '' x '', CONVERT(INT, ISNULL(S1.Ram, 0)), '' x '', CONVERT(INT, ISNULL(S1.Kg, 0)))
						   WHEN ISNULL(S1.Ram, 0) <> 0 THEN CONCAT(CONVERT(INT, ISNULL(S1.GSM, 0)), '' x '',CONVERT(INT, ISNULL(S1.Sheets, 0)), '' x '', CONVERT(INT, ISNULL(S1.Ram, 0)), '' x '', CONVERT(INT, ISNULL(S1.Kg, 0)))
						   WHEN ISNULL(S1.Kg, 0) <> 0 THEN CONCAT(CONVERT(INT, ISNULL(S1.GSM, 0)), '' x '',CONVERT(INT, ISNULL(S1.Sheets, 0)), '' x '', CONVERT(INT, ISNULL(S1.Ram, 0)), '' x '', CONVERT(INT, ISNULL(S1.Kg, 0)))
						   ELSE ''''
	                   END AS Quantitative,
	                   CASE
					       WHEN S1.Quantity <> 0 THEN S1.Quantity
						   ELSE NULL
					   END AS Quantity,
					   S1.AmountLoss AS AmountLossDetail, S1.PercentLoss AS PercentLossDetail, S1.PhaseOrder'
SET @sFROM02 = N' FROM SOT2082 S1 WITH (NOLOCK)
                     LEFT JOIN AT0126 A1 WITH (NOLOCK) ON A1.PhaseID = S1.PhaseID
                     LEFT JOIN CRMT0099 C2 WITH (NOLOCK) ON C2.ID = S1.PrintTypeID AND C2.CodeMaster = ''CRMF2111.PrintType''
                     LEFT JOIN CRMT0099 C3 WITH (NOLOCK) ON C3.ID = S1.RunPaperID AND C3.CodeMaster = ''CRMF2111.RunPaper''
                     LEFT JOIN CRMT0099 C4 WITH (NOLOCK) ON C4.ID = S1.MoldStatusID AND C4.CodeMaster = ''CRMF2111.Status''
                     LEFT JOIN AT1302 A2 WITH (NOLOCK) ON A2.InventoryID = S1.MaterialID
                     LEFT JOIN AT1304 A3 WITH (NOLOCK) ON A3.UnitID = S1.UnitID
					 LEFT JOIN MT0099 M1 WITH (NOLOCK) ON M1.ID = S1.UnitSizeID AND M1.CodeMaster = ''UnitSize''
					 LEFT JOIN MT0099 M2 WITH (NOLOCK) ON M2.ID = S1.DisplayName AND M2.CodeMaster = ''DisplayName''
					 LEFT JOIN SOT2080 S2 WITH (NOLOCK) ON S2.APK = S1.APKMaster
                 WHERE S1.DivisionID IN (''@@@'', '''+ @DivisionID +''') AND S1.APKMaster = '''+ @APK +''' AND S1.APK_SOT2081 = ''' + @APKSemiProduct + '''
                 ORDER BY S1.PhaseID, S1.PhaseOrder'

PRINT @sSQL01
PRINT @sSQL02
PRINT @sFROM02
EXEC (@sSQL01 + @sSQL02 + @sFROM02)









GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
