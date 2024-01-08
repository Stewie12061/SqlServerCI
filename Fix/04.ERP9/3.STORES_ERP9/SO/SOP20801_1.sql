IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[SOP20801_1]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[SOP20801_1]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







-- <Summary>
---		In phiếu quyết định làm bản/trục in
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Trọng Kiên, Date: 21/12/2020
--- Modified by : Kiều Nga, Date: 22/05/2021 - Fix lỗi không load loại sản phẩm
--- Modified by : Viết Toàn, Date: 01/08/2023 - Bổ sung Param APK của Bán thành phẩm 
/* <Example>
EXEC SOP20801_1 
*/
 CREATE PROCEDURE SOP20801_1
(
 	@DivisionID VARCHAR(50),
	@APK VARCHAR(50),
	@APKSemiProduct VARCHAR(50)
)
AS
DECLARE @sSQL01 NVARCHAR(MAX) ='', 
		@sSQL02 NVARCHAR(MAX) ='',
		@sSQL03 NVARCHAR(MAX) ='',
		@PhasePrint VARCHAR(50),
		@PhaseWave VARCHAR(50)

SET @PhasePrint = (SELECT PrintPhaseID FROM CRMT00000 WHERE DivisionID = ''+ @DivisionID +'')
SET @PhaseWave = (SELECT WavePhaseID FROM CRMT00000 WHERE DivisionID = ''+ @DivisionID +'')

SET @sSQL01 = N'SELECT S1.VoucherNo ,S1.ObjectID, P1.MemberName AS ObjectName, S1.DeliveryTime, S2.SemiProduct AS InventoryID, A1.InventoryName, S2.Length, S2.Width, S2.Height, S2.PaperTypeID, C1.Description AS PaperTypeName, S1.DeliveryNotes,
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
					   S2.Include, CONVERT(VARCHAR, S2.ContentSampleDate, 103) AS ContentSampleDate, CONVERT(VARCHAR, S2.ColorSampleDate, 103) AS ColorSampleDate, S2.MTSignedSampleDate,
					   CONCAT(CONVERT(INT, ISNULL(S2.FileLength, 0)), '' x '', CONVERT(INT, ISNULL(S2.FileWidth, 0)), N'' = '', CONVERT(INT, ISNULL(S2.FileSum, 0))) AS DimensionFile, M1.Description AS FileUnitName
                FROM SOT2080 S1 WITH (NOLOCK) 
                    LEFT JOIN POST0011 P1 WITH (NOLOCK) ON P1.MemberID = S1.ObjectID
                    LEFT JOIN SOT2081 S2 WITH (NOLOCK) ON S2.APKMaster = S1.APK
                    LEFT JOIN AT1302 A1 WITH (NOLOCK) ON A1.InventoryID = S2.SemiProduct
                    LEFT JOIN AT1304 A2 WITH (NOLOCK) ON A2.UnitID = A1.UnitID
					LEFT JOIN CRMT0099 C1 WITH (NOLOCK) ON S2.PrintTypeID = C1.ID AND C1.CodeMaster = ''CRMF2111.PrintType''
					LEFT JOIN MT0099 M1 WITH (NOLOCK) ON M1.ID = S2.FileUnitID AND M1.CodeMaster = ''UnitSize''
                WHERE S1.DivisionID IN (''@@@'', '''+ @DivisionID +''') AND S1.APK = '''+ @APK +''' AND S2.APK =''' + @APKSemiProduct + ''''

SET @sSQL02 = N'SELECT S1.MaterialID, A2.InventoryName AS MaterialName, S1.UnitID, CONCAT(CONVERT(INT, S1.Quantity), '' '', A3.UnitName) AS Quantity, S1.PhaseID, A1.PhaseName, CONVERT(INT,S1.Size) AS Size, CONVERT(INT,S1.Cut) AS Cut, CONVERT(INT,S1.Child) AS Child, S1.PrintTypeID, C2.Description AS PrintTypeName,
                              S1.RunPaperID, C3.Description AS RunPaperName, S1.RunWavePaper, S1.SplitSheets, S1.MoldID, S1.MoldStatusID, C4.Description AS MoldStatusName, S1.MoldDate, S1.DisplayName AS DisplayID, CONCAT(M2.Description, '': '') AS DisplayName, S1.UnitSizeID, M1.Description AS UnitSizeName, 
				              S1.PhaseOrder
					 
					 INTO #TempSOP20801_1
					 FROM SOT2082 S1 WITH (NOLOCK)
                     LEFT JOIN AT0126 A1 WITH (NOLOCK) ON A1.PhaseID = S1.PhaseID
                     LEFT JOIN CRMT0099 C2 WITH (NOLOCK) ON C2.ID = S1.PrintTypeID AND C2.CodeMaster = ''CRMF2111.PrintType''
                     LEFT JOIN CRMT0099 C3 WITH (NOLOCK) ON C3.ID = S1.RunPaperID AND C2.CodeMaster = ''CRMF2111.RunPaper''
                     LEFT JOIN CRMT0099 C4 WITH (NOLOCK) ON C4.ID = S1.MoldStatusID AND C2.CodeMaster = ''CRMF2111.Status''
                     LEFT JOIN AT1302 A2 WITH (NOLOCK) ON A2.InventoryID = S1.MaterialID
                     LEFT JOIN AT1304 A3 WITH (NOLOCK) ON A3.UnitID = S1.UnitID
					 LEFT JOIN MT0099 M1 WITH (NOLOCK) ON M1.ID = S1.UnitSizeID AND M1.CodeMaster = ''UnitSize''
					 LEFT JOIN MT0099 M2 WITH (NOLOCK) ON M2.ID = S1.DisplayName AND M2.CodeMaster = ''DisplayName''
                     WHERE S1.DivisionID IN (''@@@'', '''+ @DivisionID +''') AND S1.APKMaster = '''+ @APK +''' AND S1.APK_SOT2081 = ''' + @APKSemiProduct +''''

SET @sSQL03 = N'-- Màu
				SELECT DisplayName, MaterialName
				FROM #TempSOP20801_1
				WHERE PhaseID = '''+ @PhasePrint +''' AND DisplayID <> ''8''
				ORDER BY DisplayName

				-- NVL In
				SELECT DisplayName AS DisplayNamePrint, MaterialName AS MaterialNamePrint
				FROM #TempSOP20801_1
				WHERE PhaseID = '''+ @PhasePrint +''' AND DisplayID = ''8'' 
				ORDER BY DisplayName

				-- Sóng
				SELECT top 1
				RunWavePaper--Song
				FROM #TempSOP20801_1
				WHERE PhaseID != '''+ @PhasePrint +'''
				ORDER BY RunWavePaper desc

				-- Cách in
				SELECT top 1
				PrintTypeName--Cach in
				FROM #TempSOP20801_1 
				WHERE PhaseID = '''+ @PhasePrint +''' AND PrintTypeID <> ''''


				-- Khổ khuôn, mã khuôn, tình trạng khuôn, ngày khuôn
				SELECT 
				DisplayName
				, CONCAT(Size , '' x '' , Cut) AS SizeCutMold, CONCAT(''= '', Child, '' '',UnitSizeName) AS ChildMold
				, CONCAT(N''- Mã khuôn: '', MoldID, CHAR(13), CHAR(10), N''- Tình trang khuôn: '', MoldStatusName, CHAR(13), CHAR(10), ''- Ngày khuôn: '', CONVERT(VARCHAR, MoldDate, 103)) AS DesMold,
				Quantity
				FROM #TempSOP20801_1 
				WHERE  PhaseID NOT IN ('''+ @PhasePrint +''', '''+ @PhaseWave +''') AND ISNULL(MoldDate, '''') <> ''''

				--NVL: Loại giấy, Tráng phủ, Bồi
				SELECT
				MaterialName, PhaseOrder, ROW_NUMBER() OVER(ORDER BY PhaseOrder) AS Row_Number
				into #TempMaterialName   
				FROM #TempSOP20801_1
				WHERE PhaseID NOT IN ('''+ @PhasePrint +''', '''+ @PhaseWave +''') AND ISNULL(MoldDate, '''') = '''' AND DisplayID NOT IN (''23'', ''24'')
				ORDER BY PhaseOrder

				DECLARE @TempMaterialName TABLE (
					CATCUON NVARCHAR(MAX) NULL,
					TRANGPHU NVARCHAR(MAX) NULL,
					BOI NVARCHAR(MAX) NULL)

				INSERT INTO @TempMaterialName (CATCUON, TRANGPHU, BOI) VALUES ((SELECT MaterialName FROM #TempMaterialName WHERE Row_Number = 1),(SELECT MaterialName FROM #TempMaterialName WHERE Row_Number = 2), (SELECT MaterialName FROM #TempMaterialName WHERE Row_Number = 3))
				SELECT * FROM @TempMaterialName
				DROP TABLE #TempMaterialName


				--Kho giấy
				SELECT Size AS SizeRoll, Cut AS CutRoll, CONCAT(''= '', Child, '' '', UnitSizeName) AS ChildRoll
				FROM #TempSOP20801_1
				WHERE PhaseID NOT IN ('''+ @PhasePrint +''', '''+ @PhaseWave +''') AND ISNULL(MoldDate, '''') = '''' AND DisplayID  = ''0''

				DROP TABLE #TempSOP20801_1'
PRINT @sSQL01
PRINT @sSQL02
PRINT @sSQL03
EXEC (@sSQL01 + @sSQL02 + @sSQL03)






GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
