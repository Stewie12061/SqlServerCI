IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[POSP0061]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[POSP0061]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
---- Load edit màn hình cập nhật cửa hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created on 15/06/2018 by Khả Vi
----Modify on 
-- <Example>
/*   
POSP0061 @DivisionID = 'AT', @UserID = 'ASOFTADMIN', @ShopID = 'CH001', @Mode = 1

POSP0061 @DivisionID, @UserID, @ShopID, @Mode
*/
----
CREATE PROCEDURE POSP0061
( 
	@DivisionID NVARCHAR(50),
	@UserID NVARCHAR(50),
	@ShopID VARCHAR(50), 
	@Mode INT ---- 0: Load tab thông tin cửa hàng, thông tin hàng hóa 
			  ---- 1: Load tab thông tin người dùng
			  ---- 2: Load tab thông tin hóa đơn
			  ---- 3: Load tab thông tin phiếu chứng từ
					
) 
AS 
DECLARE @sSQL NVARCHAR (MAX),
		@LanguageID VARCHAR(50)

SELECT TOP 1 @LanguageID = ISNULL(LanguageID,'') FROM AT14051 WITH (NOLOCK) WHERE UserID = @UserID

IF @Mode = 0 ----- Tab thông tin cửa hàng, thông tin hàng hóa
BEGIN 
	SET @sSQL =  N'
	SELECT T1.APK, T1.DivisionID, T1.ShopID, T1.ShopName, T1.ShopNameE, T1.ObjectID, T1.ShortName, T1.Address, T1.AddressE, T1.Tel, T1.Fax, T1.Email, T1.Website, T1.ImageLogo, 
	T1.InventoryTypeID, T3.InventoryTypeName, T1.IsColumn, T1.PriceColumn, 
	'+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T4.Description' ELSE 'T4.DescriptionE' END+' AS PriceColumnName, 
	T1.IsTable, T1.PriceTable, T5.Description AS PriceTableName, T1.IsPromote, T1.PromoteID, T7.PromoteName, T1.DivisionName, T1.ObjectName, T1.Disabled, 
	T1.PayDebitAccountID, T1.PayCreditAccountID, T1.CostDebitAccountID, T1.CostCreditAccountID, T1.TaxDebitAccountID, T1.TaxCreditAccountID, T1.DebitAccountID, 
	T1.CreditAccountID, T1.InventoryTypeID1, T1.InventoryTypeID2, T1.IsTableAll, T1.IsTableOfTime, T1.DefaultPrinter1, T1.DefaultPrinter2, T1.DefaultPrinter3, 
	T1.CreateUserID, T1.CreateDate, T1.LastModifyUserID, T1.LastModifyDate, T1.WarehouseID, T1.WarehouseName, T1.IPPrinter, T1.IsPromote1, T1.PromoteID1, T1.ComWarehouseID, 
	T1.ComWarehouseName, T1.PromotePriceTable, T1.BusinessArea, '+CASE WHEN ISNULL(@LanguageID,'') = 'vi-VN' THEN 'T2.Description' ELSE 'T2.DescriptionE' END+' AS BusinessAreaName, 
	T1.IsUsedCA, T1.PromoteIDCA, T1.PackagePriceID, T6.PackagePriceName, T1.IsPackage, T1.IsEvents, T1.EventBeginDate, T1.EventEndDate, T1.RelatedToTypeID, T1.IsDisplay, 
	T1.DisplayWareHouseID, T9.WareHouseName AS DisplayWareHouseName, T1.IsBroken, T1.BrokenWareHouseID, T10.WareHouseName AS BrokenWareHouseName, 
	T1.IsInvoicePromotionID, T1.InvoicePromotionID, T8.PromoteName AS InvoicePromotionName, T1.IsPromoteID1, T1.IsInvoiceAccumulate, T1.IsSimilar, T1.SimilarListID,
	T11.Description AS SimilarListName
	FROM POST0010 T1 WITH (NOLOCK)
	LEFT JOIN AT0099 T2 WITH (NOLOCK) ON T1.BusinessArea = T2.ID AND T2.CodeMaster = ''AT00000035''
	LEFT JOIN AT1301 T3 WITH (NOLOCK) ON T3.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.InventoryTypeID = T3.InventoryTypeID 
	LEFT JOIN POST0099 T4 WITH (NOLOCK) ON T1.PriceColumn = T4.ID AND T4.CodeMaster = ''POS000003''
	LEFT JOIN OT1301 T5 WITH (NOLOCK) ON T1.DivisionID = T5.DivisionID AND T1.PriceTable = T5.ID AND T5.IsSimilar <> 1 
	LEFT JOIN CT0146 T6 WITH (NOLOCK) ON T6.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.PackagePriceID = T6.PackagePriceID
	LEFT JOIN CT0149 T7 WITH (NOLOCK) ON T7.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.PromoteID = T7.PromoteID
	LEFT JOIN CIT0108 T8 WITH (NOLOCK) ON T8.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.InvoicePromotionID = T8.PromoteName
	LEFT JOIN AT1303 T9 WITH (NOLOCK) ON T9.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.DisplayWareHouseID = T9.WareHouseID
	LEFT JOIN AT1303 T10 WITH (NOLOCK) ON T10.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.BrokenWareHouseID = T10.WareHouseID
	LEFT JOIN OT1301 T11 WITH (NOLOCK) ON T11.DivisionID = T1.DivisionID AND T11.ID = T1.SimilarListID AND T11.IsSimilar = 1
	WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.ShopID = '''+@ShopID+''''
END 
ELSE IF @Mode = 1 ---- Tab thông tin người dùng
BEGIN
	SET @sSQL = N'
	SELECT DivisionID, EmployeeID, EmployeeName, CreateUserID, CreateDate, LastModifyUserID, LastModifyDate, 1 AS Selected 
	FROM POST0026 WITH (NOLOCK) 
	WHERE DivisionID = '''+@DivisionID+''' AND ShopID = '''+@ShopID+'''
	UNION ALL
	SELECT DivisionID, UserID AS EmployeeID, UserName AS EmployeeName, NULL AS CreateUserID, NULL AS CreateDate, NULL AS LastModifyUserID, NULL AS LastModifyDate, 
	0 AS Selected 
	FROM AT1405 WITH (NOLOCK)
	WHERE DivisionID = '''+@DivisionID+''' 
	AND NOT EXISTS (SELECT TOP 1 1 FROM POST0026 WITH (NOLOCK) WHERE POST0026.DivisionID = '''+@DivisionID+''' AND POST0026.ShopID = '''+@ShopID+''' 
					AND AT1405.UserID = POST0026.EmployeeID)'
END 

ELSE IF @Mode = 3 ---- Tab thông tin phiếu chứng từ 
BEGIN
	SET @sSQL = N'
	SELECT T1.APK, T1.DivisionID, T1.VoucherType01, T2.VoucherTypeName AS VoucherType01Name, T1.VoucherType02, T3.VoucherTypeName AS VoucherType02Name, 
	T1.VoucherType03, T4.VoucherTypeName AS VoucherType03Name, T1.VoucherType04, T5.VoucherTypeName AS VoucherType04Name, 
	T1.VoucherType05, T6.VoucherTypeName AS VoucherType05Name, T1.VoucherType06, T7.VoucherTypeName AS VoucherType06Name, 
	T1.VoucherType07, T8.VoucherTypeName AS VoucherType07Name, T1.VoucherType08, T9.VoucherTypeName AS VoucherType08Name,  
	T1.VoucherType09, T10.VoucherTypeName AS VoucherType09Name, T1.VoucherType10, T11.VoucherTypeName AS VoucherType10Name,
	T1.VoucherType11, T12.VoucherTypeName AS VoucherType11Name, T1.CreateUserID, T1.CreateDate, T1.LastModifyUserID, T1.LastModifyDate, 
	T1.VoucherType12, T13.VoucherTypeName AS VoucherType12Name, T1.VoucherType13, T14.VoucherTypeName AS VoucherType13Name, 
	T1.VoucherType14, T15.VoucherTypeName AS VoucherType14Name, T1.VoucherType15, T16.VoucherTypeName AS VoucherType15Name,
	T1.VoucherType16, T17.VoucherTypeName AS VoucherType16Name, T1.VoucherType17, T18.VoucherTypeName AS VoucherType17Name, 
	T1.VoucherType18, T19.VoucherTypeName AS VoucherType18Name, T1.VoucherType19, T20.VoucherTypeName AS VoucherType19Name,
	T1.VoucherType20, T21.VoucherTypeName AS VoucherType20Name
	FROM POST0004 T1 WITH (NOLOCK) 
	LEFT JOIN AT1007 T2 WITH (NOLOCK) ON T2.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType01 = T2.VoucherTypeID
	LEFT JOIN AT1007 T3 WITH (NOLOCK) ON T3.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType02 = T3.VoucherTypeID
	LEFT JOIN AT1007 T4 WITH (NOLOCK) ON T4.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType03 = T4.VoucherTypeID
	LEFT JOIN AT1007 T5 WITH (NOLOCK) ON T5.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType04 = T5.VoucherTypeID
	LEFT JOIN AT1007 T6 WITH (NOLOCK) ON T6.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType05 = T6.VoucherTypeID
	LEFT JOIN AT1007 T7 WITH (NOLOCK) ON T7.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType06 = T7.VoucherTypeID
	LEFT JOIN AT1007 T8 WITH (NOLOCK) ON T8.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType07 = T8.VoucherTypeID
	LEFT JOIN AT1007 T9 WITH (NOLOCK) ON T9.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType08 = T9.VoucherTypeID
	LEFT JOIN AT1007 T10 WITH (NOLOCK) ON T10.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType09 = T10.VoucherTypeID
	LEFT JOIN AT1007 T11 WITH (NOLOCK) ON T11.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType10 = T11.VoucherTypeID
	LEFT JOIN AT1007 T12 WITH (NOLOCK) ON T12.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType11 = T12.VoucherTypeID
	LEFT JOIN AT1007 T13 WITH (NOLOCK) ON T13.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType12 = T13.VoucherTypeID
	LEFT JOIN AT1007 T14 WITH (NOLOCK) ON T14.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType13 = T14.VoucherTypeID
	LEFT JOIN AT1007 T15 WITH (NOLOCK) ON T15.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType14 = T15.VoucherTypeID
	LEFT JOIN AT1007 T16 WITH (NOLOCK) ON T16.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType15 = T16.VoucherTypeID
	LEFT JOIN AT1007 T17 WITH (NOLOCK) ON T17.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType16 = T17.VoucherTypeID
	LEFT JOIN AT1007 T18 WITH (NOLOCK) ON T18.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType17 = T18.VoucherTypeID
	LEFT JOIN AT1007 T19 WITH (NOLOCK) ON T19.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType18 = T19.VoucherTypeID
	LEFT JOIN AT1007 T20 WITH (NOLOCK) ON T20.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType19 = T20.VoucherTypeID
	LEFT JOIN AT1007 T21 WITH (NOLOCK) ON T21.DivisionID IN (T1.DivisionID, ''@@@'') AND T1.VoucherType20 = T21.VoucherTypeID
	WHERE T1.DivisionID = '''+@DivisionID+''' AND T1.ShopID = '''+@ShopID+''''
END 

PRINT @sSQL 
EXEC (@sSQL)


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

