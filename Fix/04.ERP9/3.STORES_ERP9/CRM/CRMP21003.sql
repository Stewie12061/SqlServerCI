IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP21003]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP21003]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






-- <Summary>
---		Load dữ liệu màn hình Xem chi tiết Phiếu yêu cầu + Màn hình Cập nhật Phiếu yêu cầu
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Tấn Lộc, Date: 30/12/2020
--- Modified on ... by ...:
--- Moddifed on 17/10/2023: Add Return APK_Bomversion in CRMT2101
/* <Example>
EXEC CRMP21003 
*/
 CREATE PROCEDURE CRMP21003
(
 	@DivisionID VARCHAR(50),
	@APK VARCHAR(50)
)
AS
DECLARE @Ssql Nvarchar(max) =''

SET @Ssql = @Ssql + N' 
SELECT C0.APK, C0.DivisionID, C0.CreateUserID, C0.CreateDate, C0.LastModifyUserID, C0.LastModifyDate,
	C0.TranMonth, C0.TranYear, C0.VoucherTypeID, C0.VoucherNo, C0.VoucherDate,
	C0.EmployeeID, A3.EmployeeName, C0.ObjectID, A20.ObjectName, C0.DeliveryAddress, 
	C0.Address, C0.ContactID, C994.ContactName, C0.Tel, C0.Email, C0.BusinessLinesID, C0.DeliveryMethod, C0.PackingMethod, C0.PalletRequest,
	C0.DeliveryMethod AS FieldDeliveryMethod, C0.PackingMethod AS FieldPackingMethod, C995.BusinessLinesName,
    STUFF((SELECT '','' + '' '' + C996.Description 
			FROM CRMT0088 C997 
			LEFT JOIN CRMT0099 C996 WITH (NOLOCK) ON C997.DataRefer01 = C996.ID AND C996.CodeMaster = ''CRMF2101.DeliveryMethod''
			WHERE C997.APKParent = C0.APK AND C997.DataRefer02 = ''DeliveryMethod''
			FOR XML PATH('''')), 1, 1, '''') AS DeliveryMethodName,
    STUFF((SELECT '','' + '' '' + C996.Description 
			FROM CRMT0088 C997 
			LEFT JOIN CRMT0099 C996 WITH (NOLOCK) ON C997.DataRefer01 = C996.ID AND C996.CodeMaster =  ''CRMF2101.PackingMethod''
			WHERE C997.APKParent = C0.APK AND C997.DataRefer02 = ''PackingMethod''
			FOR XML PATH('''')), 1, 1, '''') AS PackingMethodName,
    STUFF((SELECT '','' + '' '' + C996.Description 
			FROM CRMT0088 C997 
			LEFT JOIN CRMT0099 C996 WITH (NOLOCK) ON C997.DataRefer01 = C996.ID AND C996.CodeMaster = ''CRMF2101.UseIn''
			WHERE C997.APKParent = C0.APK AND C997.DataRefer02 = ''UsedIn''
			FOR XML PATH('''')), 1, 1, '''') AS UsedInName,
	C1.APKDInherited, C1.APKMInherited, C1.InventoryID, A21.InventoryName,
	C1.PaperTypeID, C991.Description PaperTypeName,
	C1.MarketID, C1.ProductQuality,
	C1.Length, C1.Width, C1.Height, C1.PrintSize, C1.CutSize,
	C1.LengthPaper, C1.WidthPaper, C1.ActualQuantity,
	C1.SideColor1, C1.ColorPrint01, STUFF((
			SELECT '', ''  +  A2.InventoryName
			FROM AT1302 A2 WITH (NOLOCK)
			    INNER JOIN AT1015 A5 WITH (NOLOCK) ON A5.AnaID = A2.I02ID AND A5.AnaTypeID = ''I02''
				INNER JOIN CRMT00000 C1 WITH (NOLOCK) ON C1.ClassifyID = A5.AnaID
			    INNER JOIN (SELECT VALUE AnaID FROM dbo.StringSplit(C1.ColorPrint01, '','')) AS T
					ON A2.InventoryID = T.AnaID
			FOR XML PATH ('''')
        ), 1, 1, '''')  AS ColorPrint01Name,
	C1.SideColor2, C1.ColorPrint02, STUFF((
			SELECT '', ''  + A2.InventoryName
			FROM AT1302 A2 WITH (NOLOCK)
			    INNER JOIN AT1015 A5 WITH (NOLOCK) ON A5.AnaID = A2.I02ID AND A5.AnaTypeID = ''I02''
				INNER JOIN CRMT00000 C1 WITH (NOLOCK) ON C1.ClassifyID = A5.AnaID
			    INNER JOIN (SELECT VALUE AnaID FROM dbo.StringSplit(C1.ColorPrint02, '','')) AS T
					ON A2.InventoryID = T.AnaID
			FOR XML PATH ('''')
        ), 1, 1, '''')  AS ColorPrint02Name,
	C1.DeliveryTime, C1.FromDeliveryTime, C1.PaymentTime,
	C1.TransportAmount, C1.PaymentID, A23.PaymentName, C1.IsContract, C1.Percentage, C1.Description,
	C1.IsDiscCD, C1.IsSampleInventoryID, C1.IsSampleEmail, C1.IsFilm,
	C1.InvenPrintSheet, C1.InvenMold, C1.Pack,
	C1.OffsetPaper, A22.InventoryName OffsetPaperName,
	C1.PrintNumber, C1.OtherProcessing, C1.FilmDate,
	C1.LengthFilm, C1.WidthFilm,
	C1.StatusFilm, C992.Description StatusFilmName,
	C1.StatusMold, C993.Description StatusMoldName,
	C1.Design, NULL AS AttachFile,
	C1.UsedIn, C1.PrintTypeID, C998.Description AS PrintTypeName, C1.QuantityInBox, C1.Weight, C1.Bearingstrength, C1.Humidity, C1.Podium, C1.BearingBCT, C1.EdgeCompressionECT, C1.PreferredValue,
	C1.FileName, C1.BoxType, C1.SampleContent, C1.ColorSample, C1.UsedIn AS FieldUsedIn,
	C1.APK_BomVersion,
    C2.LengthZenSuppo, C2.WidthZenSuppo, CASE WHEN C2.LengthZenSuppo IS NOT NULL THEN 1 ELSE 0 END AS IsZenSuppo
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
	LEFT JOIN CRMT10001 C994 WITH (NOLOCK) ON C0.ContactID = C994.ContactID
	LEFT JOIN CRMT10701 C995 WITH (NOLOCK) ON C0.BusinessLinesID = C995.BusinessLinesID
	LEFT JOIN AT1205 A23 WITH (NOLOCK) ON A23.PaymentID = C1.PaymentID
	LEFT JOIN CRMT0099 C998 WITH (NOLOCK) ON C998.ID = C1.PrintTypeID AND C998.CodeMaster = ''CRMF2111.PrintTypeID''
WHERE C0.DivisionID = '''+@DivisionID+'''
	AND C0.APK = '''+@APK+'''
	AND C0.DeleteFlg = 0'

EXEC (@Ssql )
PRINT (@Ssql)





GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
