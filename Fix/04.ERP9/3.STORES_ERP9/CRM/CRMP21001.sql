IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP21001]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP21001]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO













-- <Summary>
---		In phiếu Yêu cầu khách hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Kiều Nga, Date: 02/03/2020
----Modified by Tấn Lộc, Date:29/12/2020 - Bổ sung thêm dữ liệu lưới detail - CRMT2104
----Modified by Trọng Kiên, Date: 08/01/2021 - Fix số mặt in và ghi chú SP
----Modified by Trọng Kiên, Date: 18/01/2021 - Fix sort bán thành phẩm và NVL
----Modified by Kiều Nga, Date: 08/11/2022 - [2022/11/IS/0068] Fix lỗi phiếu in yêu cầu khách hàng đang sắp xếp trình tự không đúng
--- Modified on ... by ...:
/* <Example>
EXEC CRMP21001 
*/
 CREATE PROCEDURE CRMP21001
(
 	@DivisionID VARCHAR(50),
	@APK VARCHAR(50)
)
AS
DECLARE @sSQL01 NVARCHAR(MAX) ='', 
		@sSQL02 NVARCHAR(MAX) ='',
		@sFROM02 NVARCHAR(MAX) ='',
		@sSQL03 NVARCHAR(MAX) ='',
		@DeliveryMethod NVARCHAR(50) = '',
		@DeliveryMethodName NVARCHAR(MAX) = '',
		@PackingMethod NVARCHAR(MAX) = '',
		@PackingMethodName NVARCHAR(MAX) = '',
		@UsedIn NVARCHAR(MAX) = '',
		@UsedInName NVARCHAR(MAX) = ''


SELECT @DeliveryMethod = STUFF((SELECT ',' + ID
FROM CRMT0099 WITH (NOLOCK)
WHERE CodeMaster = 'CRMF2101.DeliveryMethod' 
ORDER BY OrderNo
FOR XML PATH('')), 1, 1, '')

SELECT @DeliveryMethodName = STUFF((SELECT ',' + Description
FROM CRMT0099 WITH (NOLOCK)
WHERE CodeMaster = 'CRMF2101.DeliveryMethod' 
ORDER BY OrderNo
FOR XML PATH('')), 1, 1, '')

SELECT @PackingMethod = STUFF((SELECT ',' + ID
FROM CRMT0099 WITH (NOLOCK)
WHERE CodeMaster = 'CRMF2101.PackingMethod' 
ORDER BY OrderNo
FOR XML PATH('')), 1, 1, '')

SELECT @PackingMethodName = STUFF((SELECT ',' + Description
FROM CRMT0099 WITH (NOLOCK)
WHERE CodeMaster = 'CRMF2101.PackingMethod' 
ORDER BY OrderNo
FOR XML PATH('')), 1, 1, '')

SELECT @UsedIn = STUFF((SELECT ',' + ID
FROM CRMT0099 WITH (NOLOCK)
WHERE CodeMaster = 'CRMF2101.UseIn'
ORDER BY OrderNo
FOR XML PATH('')), 1, 1, '')

SELECT @UsedInName = STUFF((SELECT ',' + Description
FROM CRMT0099 WITH (NOLOCK)
WHERE CodeMaster = 'CRMF2101.UseIn'
ORDER BY OrderNo
FOR XML PATH('')), 1, 1, '')

SET @sSQL01 = N'SELECT C0.APK, C0.DivisionID, C0.CreateUserID, C0.CreateDate, C0.LastModifyUserID, C0.LastModifyDate,
	C0.TranMonth, C0.TranYear, C0.VoucherTypeID, C0.VoucherNo, C0.VoucherDate,
	C0.EmployeeID, A3.EmployeeName, C0.ObjectID, A20.ObjectName, C0.DeliveryAddress,
	C0.Address AS ObjectAddress, C0.Tel AS ObjectTel, C0.Email AS ObjectEmail, C0.DeliveryMethod, NULL AS DeliveryMethod1, C0.PackingMethod,
	C0.BusinessLinesID, C995.BusinessLinesName, C0.PalletRequest, C0.ContactID, C996.ContactName,
	C1.APKDInherited, C1.APKMInherited, C1.InventoryID, A21.InventoryName,
	C1.PaperTypeID, C991.Description PaperTypeName,
	C1.MarketID, C1.ProductQuality,
	C1.Length,C1.Width,C1.Height,C1.PrintSize, C1.CutSize,
	C1.LengthPaper,C1.WidthPaper,C1.ActualQuantity,
	C1.SideColor1,CASE
					WHEN ISNULL(C1.ColorPrint01, '''') <> '''' THEN CASE WHEN LEN(C1.ColorPrint01) - LEN(REPLACE(C1.ColorPrint01, '','', '''')) > 0 THEN CONCAT(CONVERT(VARCHAR, (LEN(C1.ColorPrint01) - LEN(REPLACE(C1.ColorPrint01, '','', '''')) + 1)), N'' Màu'')
						                                                ELSE  N''1 Màu''
																		END
					ELSE ''''
				  END AS ColorPrint01, 
	STUFF((
			SELECT '', ''  + A5.AnaName
			FROM AT1015 A5 WITH (NOLOCK)
			    INNER JOIN (SELECT VALUE AnaID FROM dbo.StringSplit(C1.ColorPrint01, '','')) AS T
					ON A5.AnaID = T.AnaID
			FOR XML PATH ('''')
        ), 1, 1, '''')  AS ColorPrint01Name,
	C1.SideColor2, CASE
					       WHEN ISNULL(C1.ColorPrint02, '''') <> '''' THEN CASE WHEN LEN(C1.ColorPrint02) - LEN(REPLACE(C1.ColorPrint02, '','', '''')) > 0 THEN CONCAT(CONVERT(VARCHAR, (LEN(C1.ColorPrint02) - LEN(REPLACE(C1.ColorPrint02, '','', '''')) + 1)), N'' Màu'')
						                                                        ELSE  N''1 Màu''
																				END
						   ELSE ''''
					   END AS ColorPrint02, 
	STUFF((
			SELECT '', ''  + A5.AnaName
			FROM AT1015 A5 WITH (NOLOCK)
			    INNER JOIN (SELECT VALUE AnaID FROM dbo.StringSplit(C1.ColorPrint02, '','')) AS T
					ON A5.AnaID = T.AnaID
			FOR XML PATH ('''')
        ), 1, 1, '''')  AS ColorPrint02Name,
	C1.DeliveryTime, C1.FromDeliveryTime, C1.PaymentTime,
	C1.TransportAmount, C1.PaymentID, C1.IsContract, C1.Percentage, C1.Description,
	C1.IsDiscCD, C1.IsSampleInventoryID, C1.IsSampleEmail, C1.IsFilm,
	C1.InvenPrintSheet, C1.InvenMold, C1.Pack,
	C1.OffsetPaper, A22.InventoryName OffsetPaperName,
	C1.PrintNumber, C1.OtherProcessing, C1.FilmDate,
	C1.LengthFilm, C1.WidthFilm,
	C1.StatusFilm, C992.Description StatusFilmName,
	C1.StatusMold, C993.Description StatusMoldName,
	C1.Design, NULL AS AttachFile,
	C1.UsedIn, C1.PrintTypeID, C1.QuantityInBox, C1.Weight, C1.Bearingstrength, C1.Humidity, C1.Podium, C1.BearingBCT, 
	C1.EdgeCompressionECT, C1.PreferredValue, A23.PaymentName, C1.BoxType, C1.SampleContent, C1.ColorSample,
    C2.LengthZenSuppo, C2.WidthZenSuppo, CASE WHEN C2.LengthZenSuppo IS NOT NULL THEN 1 ELSE 0 END AS IsZenSuppo, C1.FileName,
	N''' + @DeliveryMethod + N''' AS ListDeliveryMethod, N''' + @DeliveryMethodName + N''' AS ListDeliveryMethodName,
	N''' + @PackingMethod + N''' AS ListPackingMethod,  N''' + @PackingMethodName + N''' AS ListPackingMethodName,
	N''' + @UsedIn + N''' AS ListUsedIn, N''' + @UsedInName + N''' AS ListUsedInName
FROM CRMT2100 C0 WITH (NOLOCK)
	INNER JOIN CRMT2101 C1 WITH (NOLOCK) ON C0.DivisionID = C1.DivisionID AND C0.APK = C1.APKMaster
    LEFT JOIN CRMT2102 C2 WITH (NOLOCK) ON C0.DivisionID = C1.DivisionID AND C0.APK = C2.APKMaster AND LengthZenSuppo IS NOT NULL
    LEFT JOIN
		(
			SELECT A03.DivisionID, A03.EmployeeID, A03.FullName EmployeeName
			FROM AT1103 A03 WITH (NOLOCK)
				LEFT JOIN AT1405 A05 WITH (NOLOCK) ON A03.EmployeeID = A05.UserID AND A05.DivisionID IN (A03.DivisionID, ''@@@'')
		) A3 ON A3.DivisionID IN (C0.DivisionID, ''@@@'') AND C0.EmployeeID = A3.EmployeeID
	LEFT JOIN AT1202 A20 WITH (NOLOCK) ON C0.DivisionID = A20.DivisionID AND C0.ObjectID = A20.ObjectID
	LEFT JOIN AT1302 A21 WITH (NOLOCK) ON C1.DivisionID = A21.DivisionID AND C1.InventoryID = A21.InventoryID
	LEFT JOIN AT1302 A22 WITH (NOLOCK) ON C1.DivisionID = A22.DivisionID AND C1.OffsetPaper = A22.InventoryID
	LEFT JOIN CRMT0099 C991 WITH (NOLOCK) ON C1.PaperTypeID = C991.ID AND C991.Codemaster = ''CRMT00000022'' AND C991.Disabled = 0
	LEFT JOIN CRMT0099 C992 WITH (NOLOCK) ON C1.StatusFilm = C992.ID AND C992.Codemaster = ''CRMT00000023'' AND C992.Disabled = 0
	LEFT JOIN CRMT0099 C993 WITH (NOLOCK) ON C1.StatusMold = C993.ID AND C993.Codemaster = ''CRMT00000023'' AND C993.Disabled = 0
	LEFT JOIN CRMT10701 C995 WITH (NOLOCK) ON C0.BusinessLinesID = C995.BusinessLinesID
	LEFT JOIN AT1205 A23 WITH (NOLOCK) ON A23.PaymentID = C1.PaymentID
	LEFT JOIN CRMT10001 C996 WITH (NOLOCK) ON C996.ContactID = C0.ContactID
WHERE C0.DivisionID = '''+@DivisionID+'''
	AND C0.APK = '''+@APK+'''
	AND C0.DeleteFlg = 0 '

SET @sSQL02 = N'SELECT S1.PhaseID, A1.PhaseName, CASE
                                         WHEN ISNULL(S1.Size, 0) <> 0 THEN CONCAT (CONVERT(INT, ISNULL(S1.Size, 0)), '' x '', CONVERT(INT, ISNULL(S1.Cut, 0)), '' = '', CONVERT(INT, ISNULL(S1.Child, 0)), '' '', M1.Description)
										 WHEN ISNULL(S1.Cut, 0) <> 0 THEN CONCAT (CONVERT(INT, ISNULL(S1.Size, 0)), '' x '', CONVERT(INT, ISNULL(S1.Cut, 0)), '' = '', CONVERT(INT, ISNULL(S1.Child, 0)), '' '', M1.Description)
										 WHEN ISNULL(S1.Child, 0) <> 0 THEN CONCAT (CONVERT(INT, ISNULL(S1.Size, 0)), '' x '', CONVERT(INT, ISNULL(S1.Cut, 0)), '' = '', CONVERT(INT, ISNULL(S1.Child, 0)), '' '', M1.Description)
										 ELSE ''''
									 END AS DimensionDetail,
					   CONCAT(
					          IIF(S1.PrintTypeID <> '''', CONCAT(N''- Cách in: '', C2.Description, CHAR(13), CHAR(10)), ''''),
							  --IIF(S1.SplitSheets <> 0, CONCAT(N''- Chia tờ: '', CONVERT(INT, ISNULL(S1.SplitSheets, 0)), CHAR(13), CHAR(10)), ''''),
							  IIF(S1.RunPaperID <> '''', CONCAT(N''- Chạy giấy: '', C3.Description, CHAR(13), CHAR(10)), ''''),
							  IIF(S1.RunWavePaper <> '''', CONCAT(N''- Sóng: '', S1.RunWavePaper, CHAR(13), CHAR(10)), ''''),
							  --IIF(S1.QuantityRunWave <> 0, CONCAT(N''- SL tờ chạy sóng: '', CONVERT(INT, S1.QuantityRunWave), CHAR(13), CHAR(10)), ''''),
							  IIF(S1.MoldID <> '''', CONCAT(N''- Mã khuôn: '', S1.MoldID, CHAR(13), CHAR(10)), ''''),
							  IIF(S1.MoldStatusID <> '''', CONCAT(N''- Tình trạng khuôn: '', C4.Description, CHAR(13), CHAR(10)), ''''),
							  IIF(S1.MoldDate <> '''', CONCAT(N''- Ngày khuôn: '', CONVERT(VARCHAR, S1.MoldDate, 103), CHAR(13), CHAR(10)), ''''),
							  IIF(S1.NodeTypeID = 1, N''Bán thành phẩm'', '''')
							  ) AS Description1,
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
	                   END AS Quantitative, S1.PhaseOrder, NULL AS OrderNo
				  INTO #TempCRMT2104'
SET @sFROM02 = N' FROM CRMT2104 S1 WITH (NOLOCK)
                     LEFT JOIN AT0126 A1 WITH (NOLOCK) ON A1.PhaseID = S1.PhaseID
                     LEFT JOIN CRMT0099 C2 WITH (NOLOCK) ON C2.ID = S1.PrintTypeID AND C2.CodeMaster = ''CRMF2111.PrintType''
                     LEFT JOIN CRMT0099 C3 WITH (NOLOCK) ON C3.ID = S1.RunPaperID AND C3.CodeMaster = ''CRMF2111.RunPaper''
                     LEFT JOIN CRMT0099 C4 WITH (NOLOCK) ON C4.ID = S1.MoldStatusID AND C4.CodeMaster = ''CRMF2111.Status''
                     LEFT JOIN AT1302 A2 WITH (NOLOCK) ON A2.InventoryID = S1.MaterialID
                     LEFT JOIN AT1304 A3 WITH (NOLOCK) ON A3.UnitID = S1.UnitID
					 LEFT JOIN MT0099 M1 WITH (NOLOCK) ON M1.ID = S1.UnitSizeID AND M1.CodeMaster = ''UnitSize''
					 LEFT JOIN MT0099 M2 WITH (NOLOCK) ON M2.ID = S1.DisplayName AND M2.CodeMaster = ''DisplayName''
					 LEFT JOIN CRMT2100 S2 WITH (NOLOCK) ON S2.APK = S1.APKMaster
                 WHERE S1.DivisionID IN (''@@@'', '''+ @DivisionID +''') AND S1.APKMaster = '''+ @APK +''''

SET @sSQL03 = N'DECLARE @TempCRMT2104 TABLE (PhaseID VARCHAR(50), PhaseName NVARCHAR(MAX), DimensionDetail VARCHAR(250), Description1 NVARCHAR(MAX), MaterialName NVARCHAR(MAX), UnitNameDetail NVARCHAR(MAX), Quantitative VARCHAR(250), PhaseOrder INT,
		                           OrderNo INT)

				DECLARE @Cur CURSOR,
						@count INT = 0,
						@PhaseID VARCHAR(50) = '''', @PhaseName NVARCHAR(MAX) = N'''', @DimensionDetail VARCHAR(250) = '''', @Description1 NVARCHAR(MAX) = N'''', @MaterialName NVARCHAR(MAX) = N'''', @UnitNameDetail NVARCHAR(MAX) = N'''', @Quantitative VARCHAR(250) = '''', @PhaseOrder INT = 0,
						@OrderNo INT = 0 

				SET @Cur = CURSOR SCROLL KEYSET FOR
					SELECT PhaseID, PhaseName, DimensionDetail, Description1, MaterialName, UnitNameDetail, Quantitative, PhaseOrder, OrderNo FROM #TempCRMT2104
				OPEN @Cur
				FETCH NEXT FROM @Cur INTO @PhaseID, @PhaseName, @DimensionDetail, @Description1, @MaterialName, @UnitNameDetail, @Quantitative, @PhaseOrder, @OrderNo
				WHILE @@FETCH_STATUS = 0
				BEGIN
					IF(@PhaseID = '''')
					BEGIN
						SET @count = @count + 1
						INSERT INTO @TempCRMT2104 VALUES (@PhaseID, @PhaseName, @DimensionDetail, @Description1, @MaterialName, @UnitNameDetail, @Quantitative, @PhaseOrder, @count)
					END		      
					ELSE
					BEGIN
						INSERT INTO @TempCRMT2104 VALUES (@PhaseID, @PhaseName, @DimensionDetail, @Description1, @MaterialName, @UnitNameDetail, @Quantitative, @PhaseOrder, @count)
					END
				FETCH NEXT FROM @Cur INTO @PhaseID, @PhaseName, @DimensionDetail, @Description1, @MaterialName, @UnitNameDetail, @Quantitative, @PhaseOrder, @OrderNo
				END
				CLOSE @Cur

				DROP TABLE #TempCRMT2104

				SELECT *
				FROM @TempCRMT2104
				ORDER BY PhaseOrder'


EXEC (@sSQL01 + @sSQL02 + @sFROM02 + @sSQL03)












GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
