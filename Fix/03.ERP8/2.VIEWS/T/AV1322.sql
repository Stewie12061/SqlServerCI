IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[AV1322]') AND OBJECTPROPERTY(ID, N'IsView') = 1)
DROP VIEW [DBO].[AV1322]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--View chet
-- Creater by: Nguyen Quoc Huy
--Date: 14/03/2006
---- Modified on 01/02/2016 by Bảo Anh: Bổ sung cột TK doanh thu hàng trả lại
---- Modified on 30/03/2016 by Hoàng Vũ: Load danh sách không cần lấy hình ảnh, tốc độ chậm, khi xem chi tiết load hình ảnh sau
---- Modified by Tiểu Mai on 16/05/2016: Bổ sung 5MPT mặt hàng I06ID -->I10ID
---- Modified on 24/05/2016 by Bảo Anh: Bổ sung With (Nolock)
---- Modified by Phương Thảo on 15/05/2017: Sửa danh mục dùng chung
---- Modified by Bảo Thy on 27/09/2017: Bổ sung IsExpense
---- Modified on 02/10/2020 by Nhựt Trường: (Sửa danh mục dùng chung)Bổ sung điều kiện DivisionID IN cho bảng AT1302.
---- Modified on 11/01/2021 by Lê Hoàng : Lỗi Ambiguous column name 'Notes01' vì thêm trường Notes01 ở AT1015
---- Modified on 01/12/2023 by Nhựt Trường: 2023/12/IS/0002, Fix lỗi vị trí điều kiện DivisonID theo bảng chưa hợp lý khi join bảng.

CREATE VIEW [dbo].[AV1322] AS 	
Select 
	AT1302.InventoryID, 
	AT1302.S1, AT1310_S1.SName as SName1,
  	AT1302.S2, AT1310_S2.SName as SName2,
	AT1302.S3, AT1310_S3.SName as SName3,
	AT1302.InventoryName, 
	AT1302.InventoryTypeID, AT1301.InventoryTypeName ,
	AT1302.UnitID, AT1304.UnitName ,
	Varchar01, Varchar02, Varchar03, Varchar04, Varchar05, 
	Amount01, Amount02, Amount03, Amount04, Amount05, 
	SalePrice01, SalePrice02, SalePrice03, SalePrice04, SalePrice05, 
	PriceDate01, PriceDate02, PriceDate03, PriceDate04, PriceDate05, 
	RecievedPrice, DeliveryPrice, PurchasePrice01, PurchasePrice02, PurchasePrice03, PurchasePrice04, PurchasePrice05,
	AT1302.Disabled, AT1302.CreateDate, AT1302.CreateUserID, AT1302.LastModifyDate, AT1302.LastModifyUserID, 
	Classify01ID, Classify02ID, Classify03ID, Classify04ID, Classify05ID, Classify06ID, Classify07ID, Classify08ID, 
	MethodID, IsSource, 
	AccountID, SalesAccountID, PurchaseAccountID, PrimeCostAccountID, 
	IsLimitDate, IsLocation, IsStocked, VATGroupID, VATPercent, NormMethod, 
	I01ID,  AT1015_I01.AnaName  as AnaName1,
	I02ID, AT1015_I02.AnaName  as AnaName2,
	I03ID, AT1015_I03.AnaName  as AnaName3,
	I04ID, AT1015_I04.AnaName  as AnaName4,
	I05ID, AT1015_I05.AnaName  as AnaName5,
	AT1302.I06ID, AT1015_I06.AnaName  as AnaName6, 
	AT1302.I07ID, AT1015_I07.AnaName  as AnaName7, 
	AT1302.I08ID, AT1015_I08.AnaName  as AnaName8, 
	AT1302.I09ID, AT1015_I09.AnaName  as AnaName9, 
	AT1302.I10ID, AT1015_I10.AnaName  as AnaName10,
	AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, 
	Specification, Barcode,
	IsTools, IsKIT, KITID, RefInventoryID, AT1302.DivisionID 
	,AT1302.IsCommon
	, Cast(null as Image) as Image01ID, Cast(null as Image) as Image02ID
	, AT1302.ReSalesAccountID, AT1302.IsExpense
From AT1302 WITH (NOLOCK) 
Left Join AT1304 WITH (NOLOCK) On AT1304.DivisionID IN (AT1302.DivisionID,'@@@') AND AT1302.UnitID = AT1304.UnitID 
Left Join AT1301 WITH (NOLOCK) On AT1301.DivisionID IN (AT1302.DivisionID,'@@@') AND AT1302.InventoryTypeID = AT1301.InventoryTypeID
Left Join AT1310 AT1310_S1 WITH (NOLOCK) On AT1310_S1.DivisionID IN (AT1302.DivisionID,'@@@') AND AT1302.S1= AT1310_S1.S and AT1310_S1.STypeID ='I01'
Left Join AT1310 AT1310_S2 WITH (NOLOCK) On AT1310_S2.DivisionID IN (AT1302.DivisionID,'@@@') AND AT1302.S2= AT1310_S2.S and AT1310_S2.STypeID ='I02'
Left Join AT1310 AT1310_S3 WITH (NOLOCK) On AT1310_S3.DivisionID IN (AT1302.DivisionID,'@@@') AND AT1302.S3= AT1310_S3.S and AT1310_S3.STypeID ='I03'
Left Join AT1015 AT1015_I01 WITH (NOLOCK) On AT1015_I01.DivisionID IN (AT1302.DivisionID,'@@@') AND AT1302.I01ID= AT1015_I01.AnaID and AT1015_I01.AnaTypeID ='I01'
Left Join AT1015 AT1015_I02 WITH (NOLOCK) On AT1015_I02.DivisionID IN (AT1302.DivisionID,'@@@') AND AT1302.I02ID= AT1015_I02.AnaID and AT1015_I02.AnaTypeID ='I02'
Left Join AT1015 AT1015_I03 WITH (NOLOCK) On AT1015_I03.DivisionID IN (AT1302.DivisionID,'@@@') AND AT1302.I03ID= AT1015_I03.AnaID and AT1015_I03.AnaTypeID ='I03'
Left Join AT1015 AT1015_I04 WITH (NOLOCK) On AT1015_I04.DivisionID IN (AT1302.DivisionID,'@@@') AND AT1302.I04ID= AT1015_I04.AnaID and AT1015_I04.AnaTypeID ='I04'
Left Join AT1015 AT1015_I05 WITH (NOLOCK) On AT1015_I05.DivisionID IN (AT1302.DivisionID,'@@@') AND AT1302.I05ID= AT1015_I05.AnaID and AT1015_I05.AnaTypeID ='I05'
Left Join AT1015 AT1015_I06 WITH (NOLOCK) On AT1015_I06.DivisionID IN (AT1302.DivisionID,'@@@') AND AT1302.I06ID= AT1015_I06.AnaID and AT1015_I06.AnaTypeID ='I06'
Left Join AT1015 AT1015_I07 WITH (NOLOCK) On AT1015_I07.DivisionID IN (AT1302.DivisionID,'@@@') AND AT1302.I07ID= AT1015_I07.AnaID and AT1015_I07.AnaTypeID ='I07'
Left Join AT1015 AT1015_I08 WITH (NOLOCK) On AT1015_I08.DivisionID IN (AT1302.DivisionID,'@@@') AND AT1302.I08ID= AT1015_I08.AnaID and AT1015_I08.AnaTypeID ='I08'
Left Join AT1015 AT1015_I09 WITH (NOLOCK) On AT1015_I09.DivisionID IN (AT1302.DivisionID,'@@@') AND AT1302.I09ID= AT1015_I09.AnaID and AT1015_I09.AnaTypeID ='I09'
Left Join AT1015 AT1015_I10 WITH (NOLOCK) On AT1015_I10.DivisionID IN (AT1302.DivisionID,'@@@') AND AT1302.I10ID= AT1015_I10.AnaID and AT1015_I10.AnaTypeID ='I10'
GROUP BY AT1302.InventoryID, 
	AT1302.S1, AT1310_S1.SName,
  	AT1302.S2, AT1310_S2.SName,
	AT1302.S3, AT1310_S3.SName,
	AT1302.InventoryName, 
	AT1302.InventoryTypeID, AT1301.InventoryTypeName ,
	AT1302.UnitID, AT1304.UnitName ,
	Varchar01, Varchar02, Varchar03, Varchar04, Varchar05, 
	Amount01, Amount02, Amount03, Amount04, Amount05, 
	SalePrice01, SalePrice02, SalePrice03, SalePrice04, SalePrice05, 
	PriceDate01, PriceDate02, PriceDate03, PriceDate04, PriceDate05, 
	RecievedPrice, DeliveryPrice, PurchasePrice01, PurchasePrice02, PurchasePrice03, PurchasePrice04, PurchasePrice05,
	AT1302.Disabled, AT1302.CreateDate, AT1302.CreateUserID, AT1302.LastModifyDate, AT1302.LastModifyUserID, 
	Classify01ID, Classify02ID, Classify03ID, Classify04ID, Classify05ID, Classify06ID, Classify07ID, Classify08ID, 
	MethodID, IsSource, 
	AccountID, SalesAccountID, PurchaseAccountID, PrimeCostAccountID, 
	IsLimitDate, IsLocation, IsStocked, VATGroupID, VATPercent, NormMethod, 
	I01ID,  AT1015_I01.AnaName,
	I02ID, AT1015_I02.AnaName ,
	I03ID, AT1015_I03.AnaName,
	I04ID, AT1015_I04.AnaName,
	I05ID, AT1015_I05.AnaName,
	AT1302.I06ID, AT1015_I06.AnaName, 
	AT1302.I07ID, AT1015_I07.AnaName, 
	AT1302.I08ID, AT1015_I08.AnaName, 
	AT1302.I09ID, AT1015_I09.AnaName, 
	AT1302.I10ID, AT1015_I10.AnaName,
	AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, 
	Specification, Barcode,
	IsTools, IsKIT, KITID, RefInventoryID, AT1302.DivisionID 
	,AT1302.IsCommon
	, AT1302.ReSalesAccountID, AT1302.IsExpense		


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO