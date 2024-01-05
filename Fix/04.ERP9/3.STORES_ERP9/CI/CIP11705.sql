IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CIP11705]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CIP11705]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Load chi tiết mặt hàng
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Đình Hòa, Date: 29/12/2020
----Modified by Lê Hoàng on 21/05/2021 : Bổ sung thông tin CreateUserID, CreateDate, LastModifyUserID, LastModifyDate
----Modified by Hồng Thắm on 06/12/2023 : Bổ sung lấy thông tin Varchar06, Varchar07, Varchar08, Varchar09, Varchar10
-- <Example>
----
CREATE PROCEDURE CIP11705 ( 
        @DivisionID VARCHAR(50),  --Biến môi trường
        @UserID  VARCHAR(50),
		@APK VARCHAR(50),
		@LanguageID VARCHAR(50)		
) 
AS 
DECLARE @sSQL01 NVARCHAR (MAX),
		@sWhere NVARCHAR(MAX)
		
	SET @sWhere = ''

	--Check DivisionIDList null then get DivisionID 
	IF Isnull(@APK, '') != ''
		SET @sWhere = @sWhere + 'M.APK = '''+@APK+''''

	IF Isnull(@DivisionID, '') != ''
		SET @sWhere = @sWhere + ' AND M.DivisionID IN ('''+ @DivisionID+''',''@@@'')'
	
	DECLARE @Method1 NVARCHAR(100),
			@Method2 NVARCHAR(100),
			@Method3 NVARCHAR(100),
			@Method4 NVARCHAR(100)

	SET @Method1 = N'Nhập trước xuất trước (FIFO)'
	SET @Method2 = N'Bình quân gia quyền'
	SET @Method3 = N'Thực tế đích danh'
	SET @Method4 = N'Bình quân gia quyền liên hoàn'

SET @sSQL01 = 'SELECT M.APK, M.DivisionID, M.S1, M.S2, M.S3, M.InventoryID, M.InventoryName, D1.UnitName AS UnitID, D2.InventoryTypeName AS InventoryTypeID
, D3.AccountName AS ReSalesAccountID, D4.AccountName AS PrimeCostAccountID, D5.AccountName AS PurchaseAccountID, D6.VATGroupName AS VATGroupID
, D7.VATGroupName AS VATImGroupID, M.RecievedPrice, M.DeliveryPrice, M.PurchasePrice01, M.PurchasePrice02, M.PurchasePrice03, M.PurchasePrice04
, M.PurchasePrice05, M.SalePrice01, M.SalePrice02, M.SalePrice03, M.SalePrice04, M.SalePrice05, ISNULL(M.IsDiscount,0) AS IsDiscount, ISNULL(M.IsExpense,0) AS IsExpense
, ISNULL(M.IsLimitDate,0) AS IsLimitDate, ISNULL(M.IsStocked,0) AS IsStocked, ISNULL(M.IsMinQuantity,0) AS IsMinQuantity
, ISNULL(M.IsGiftVoucher,0) AS IsGiftVoucher, ISNULL(M.IsArea,0) AS IsArea, M.IsCommon, M.Disabled
, CASE WHEN M.MethodID = 1 THEN N''' + @Method1 +''' WHEN M.MethodID = 4 THEN N''' + @Method2 +''' WHEN M.MethodID = 3 THEN N''' + @Method3 +''' WHEN M.MethodID = 5 THEN N''' + @Method4 +''' END AS MethodID
, D8.AnaName AS	I01ID, D9.AnaName AS I02ID,	D10.AnaName AS I03ID, D11.AnaName AS I04ID, D12.AnaName AS	I05ID, D13.AnaName AS I06ID
, D14.AnaName AS I07ID, D15.AnaName AS I08ID, D16.AnaName AS I09ID, D17.AnaName AS I10ID, M.Barcode
, M.Specification, M.RefInventoryID, D18.ETaxName AS ETaxID, M.ETaxConvertedUnit, D19.NRTClassifyName AS NRTClassifyID
, D20.SETName AS SETID, M.Notes01, M.Notes02, M.Notes03, M.Varchar01, M.Varchar02, M.Varchar03, M.Varchar04, M.Varchar05 
, M.Varchar06, M.Varchar07, M.Varchar08, M.Varchar09, M.Varchar10 
, M.CreateUserID, M.CreateDate, M.LastModifyUserID, M.LastModifyDate			
FROM AT1302 M WITH(NOLOCK)
LEFT JOIN AT1304 D1 WITH(NOLOCK) ON M.UnitID = D1.UnitID 
LEFT JOIN AT1301 D2 WITH(NOLOCK) ON M.InventoryTypeID = D2.InventoryTypeID
LEFT JOIN AT1005 D3 WITH(NOLOCK) ON M.ReSalesAccountID = D3.AccountID
LEFT JOIN AT1005 D4 WITH(NOLOCK) ON M.PrimeCostAccountID = D4.AccountID
LEFT JOIN AT1005 D5 WITH(NOLOCK) ON M.PurchaseAccountID = D5.AccountID
LEFT JOIN AT1010 D6 WITH(NOLOCK) ON M.VATGroupID = D6.VATGroupID
LEFT JOIN AT1010 D7 WITH(NOLOCK) ON M.VATImGroupID = D7.VATGroupID
LEFT JOIN AT1015 D8 WITH(NOLOCK) ON M.I01ID = D8.AnaID 
LEFT JOIN AT1015 D9 WITH(NOLOCK) ON M.I02ID = D9.AnaID 
LEFT JOIN AT1015 D10 WITH(NOLOCK) ON M.I03ID = D10.AnaID
LEFT JOIN AT1015 D11 WITH(NOLOCK) ON M.I04ID = D11.AnaID
LEFT JOIN AT1015 D12 WITH(NOLOCK) ON M.I05ID = D12.AnaID
LEFT JOIN AT1015 D13 WITH(NOLOCK) ON M.I06ID = D13.AnaID
LEFT JOIN AT1015 D14 WITH(NOLOCK) ON M.I07ID = D14.AnaID
LEFT JOIN AT1015 D15 WITH(NOLOCK) ON M.I08ID = D15.AnaID
LEFT JOIN AT1015 D16 WITH(NOLOCK) ON M.I09ID = D16.AnaID
LEFT JOIN AT1015 D17 WITH(NOLOCK) ON M.I10ID = D17.AnaID
LEFT JOIN AT0293 D18 WITH(NOLOCK) ON M.ETaxID = D18.ETaxID
LEFT JOIN AT0134 D19 WITH(NOLOCK) ON M.NRTClassifyID = D19.NRTClassifyID
LEFT JOIN AT0136 D20 WITH(NOLOCK) ON M.SETID = D20.SETID
WHERE '+@sWhere+''	
	
PRINT(@sSQL01)	
EXEC (@sSQL01)

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

