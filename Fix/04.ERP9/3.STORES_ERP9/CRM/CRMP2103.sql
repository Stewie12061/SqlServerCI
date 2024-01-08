IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CRMP2103]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CRMP2103]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





-- <Summary>
---	Load màn hình chọn Kế thừa mẫu in cũ (CRMF2103)
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Học Huy, Date: 06/01/2020
--- Modified on 21/09/2020 by Kiều Nga: Bổ sung điều kiện lọc theo loại sản phẩm
/* <Example>
EXEC CRMP2103 @DivisionID=N'MTH',@UserID=N'HOCHUY',
	@PageNumber=1,@PageSize=25,@IsDate=0,
	@FromDate='2020-01-06 00:00:00',@ToDate='2020-01-06 00:00:00',
	@FromTranMonth=9,@FromTranYear=2019,
	@ToTranMonth=9,@ToTranYear=2019
	,@VoucherNo=NULL,@InventoryID=N'0000000010'
*/

 CREATE PROCEDURE CRMP2103
( 
	 @DivisionID VARCHAR(50),
	 @DivisionList NVARCHAR(MAX),
	 @UserID VARCHAR(50),
     @IsDate TINYINT,
	 @PageNumber INT,
	 @PageSize INT,	 
	 @Periods NVARCHAR(MAX),
	 @FromDate DATETIME,
	 @ToDate DATETIME,
	 @ObjectName NVARCHAR(250),
	 @VoucherNo VARCHAR(50),
	 @InventoryID NVARCHAR(250),
	 @InventoryTypeID NVARCHAR(250)
)
AS 
DECLARE @sSQL NVARCHAR(MAX) = N'',	
		@sSQL1 NVARCHAR(MAX) = N'',
		@sWhere NVARCHAR(MAX) = N'',
		@TotalRow NVARCHAR(50) = N'',
        @OrderBy NVARCHAR(500) = N''

SET @OrderBy = 'T1.VoucherDate DESC'

IF  @PageNumber = 1 SET @TotalRow = 'COUNT(*) OVER ()' ELSE SET @TotalRow = 'NULL'

SET @sWhere = @sWhere + N' C0.DivisionID  ='''+@DivisionID+''' AND C0.DeleteFlg = 0 '

IF ISNULL(@VoucherNo,'') <> ''
	SET @sWhere = @sWhere + N'AND C0.VoucherNo LIKE ''%' +@VoucherNo+'%'''

IF ISNULL(@ObjectName,'') <> ''
	SET @sWhere = @sWhere + N'AND (C0.ObjectID LIKE N''%' +@ObjectName+'%'' OR A20.ObjectName LIKE N''%' +@ObjectName+'%'')'

IF ISNULL(@InventoryID,'') <> ''
	SET @sWhere = @sWhere + N'AND (C1.InventoryID LIKE N''%' +@InventoryID+'%'' OR A21.InventoryName LIKE N''%' +@InventoryID+'%'')'

IF ISNULL(@InventoryTypeID,'') <> ''
	SET @sWhere = @sWhere + N'AND C1.PaperTypeID LIKE N''%' +@InventoryTypeID+'%'''

IF @IsDate = 0 
	SET @sWhere = @sWhere + ' AND CONVERT(VARCHAR(10), C0.VoucherDate,112) BETWEEN '+CONVERT(VARCHAR(10),@FromDate,112)+' AND '+CONVERT(VARCHAR(10),@ToDate,112)+' '
	
ELSE 
	SET @sWhere = @sWhere + ' AND (CASE WHEN C0.TranMonth <10 then ''0''+rtrim(ltrim(str(C0.TranMonth)))+''/''+ltrim(Rtrim(str(C0.TranYear))) 
								ELSE rtrim(ltrim(str(C0.TranMonth)))+''/''+ltrim(Rtrim(str(C0.TranYear))) END) IN ('''+@Periods+''')'

BEGIN
	SET @sSQL = @sSQL + N'
		SELECT C0.APK, C1.APK_BomVersion, C0.DivisionID, C0.CreateUserID, C0.CreateDate, C0.LastModifyUserID, C0.LastModifyDate
			, C0.TranMonth, C0.TranYear, C0.VoucherTypeID, C0.VoucherNo, C0.VoucherDate
			, C0.EmployeeID, A3.EmployeeName, C0.ObjectID, A20.ObjectName, C0.DeliveryAddress, C0.ContactID, C0.Tel, C0.Email, C0.BusinessLinesID, C0.Address
			, C0.DeliveryMethod, C0.PackingMethod, C0.PalletRequest, C994.ContactName
			, C1.APKDInherited, C1.APKMInherited, C1.InventoryID, A21.InventoryName
			, C1.PaperTypeID, C99.Description PaperTypeName, C1.MarketID, C1.ProductQuality
			, C1.Length, C1.Width, C1.Height, C1.PrintSize, C1.CutSize, C1.LengthPaper, C1.WidthPaper, C1.ActualQuantity,
			C1.SideColor1, C1.ColorPrint01, 
				STUFF((
					SELECT '' 
					- ''  + A5.AnaName
					FROM AT1015 A5 WITH (NOLOCK)
						INNER JOIN (SELECT VALUE AnaID FROM dbo.StringSplit(C1.ColorPrint01, '','')) AS T
							ON A5.AnaID = T.AnaID
					FOR XML PATH ('''')
				), 1, 1, '''')  AS ColorPrint01Name,
			C1.SideColor2, C1.ColorPrint02, 
				STUFF((
					SELECT '' 
					- ''  + A5.AnaName
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
			C1.LengthFilm, C1.WidthFilm, C1.StatusFilm, C1.StatusMold, C1.Design,
			C1.UsedIn, C1.PrintTypeID, C1.QuantityInBox, C1.Weight, C1.Bearingstrength, C1.Humidity, C1.Podium, C1.BearingBCT, 
	        C1.EdgeCompressionECT, C1.PreferredValue, A23.PaymentName, C1.BoxType, C1.SampleContent, C1.ColorSample, C1.FileName,
			C2.LengthZenSuppo, C2.WidthZenSuppo, CASE WHEN C2.LengthZenSuppo IS NOT NULL THEN 1 ELSE 0 END AS IsZenSuppo INTO #OT2001
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
			LEFT JOIN CRMT0099 C99 WITH (NOLOCK) ON C1.PaperTypeID = C99.ID AND C99.Codemaster = ''CRMT00000022'' AND C99.Disabled = 0
			LEFT JOIN CRMT10001 C994 WITH (NOLOCK) ON C0.ContactID = C994.ContactID
			LEFT JOIN AT1205 A23 WITH (NOLOCK) ON A23.PaymentID = C1.PaymentID
		WHERE '+@sWhere + ' AND C0.DeleteFlg = 0'
END

SET @sSQL1 = @sSQL1 + ' 
	SELECT ROW_NUMBER() OVER (ORDER BY T1.VoucherDate DESC, T1.VoucherNo) AS RowNum
	, COUNT(*) OVER () As TotalRow, T1.*
	FROM #OT2001 T1
	ORDER BY '+@OrderBy+' 
	OFFSET ' + STR((@PageNumber-1) * @PageSize) + ' ROWS
	FETCH NEXT ' + STR(@PageSize) + ' ROWS ONLY'

PRINT (@sSQL + @sSQL1)
EXEC (@sSQL + @sSQL1)




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO
