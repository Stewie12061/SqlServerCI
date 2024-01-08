IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CP0051]') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [DBO].[CP0051]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- <Summary>
--- In danh sách mặt hàng
-- <Param>
----
-- <Return>
----
-- <Reference>
----
-- <History>
----Created by: Phan thanh hoang vu: Chuyển từ view AV1322 sang CP0051
----Create date: 30/03/2016
---- Modified by Phương Thảo on 15/05/2017: Sửa danh mục dùng chung
---- Modified by Lê Hoàng on 11/01/2021: Lỗi Ambiguous column name 'Notes01' vì thêm trường Notes01 ở AT1015
/*
	exec CP0051 ''
*/
 CREATE PROCEDURE CP0051 
 (
	@DivisionID nvarchar(50)
 )
 AS
BEGIN

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
AT1302.Notes01, AT1302.Notes02, AT1302.Notes03, 
Specification, Barcode,
IsTools, IsKIT, KITID, RefInventoryID, AT1302.DivisionID 
,AT1302.IsCommon
, A00003.Image01ID, A00003.Image02ID
From AT1302 Left Join AT1304 On AT1302.UnitID = AT1304.UnitID And AT1302.DivisionID = AT1304.DivisionID
Left Join AT1301 On AT1302.InventoryTypeID = AT1301.InventoryTypeID AND AT1302.DivisionID = AT1301.DivisionID 
Left Join AT1310 AT1310_S1 On AT1302.S1= AT1310_S1.S and AT1310_S1.STypeID ='I01' AND AT1302.DivisionID= AT1310_S1.DivisionID 
Left Join AT1310 AT1310_S2 On AT1302.S2= AT1310_S2.S and AT1310_S2.STypeID ='I02' AND AT1302.DivisionID= AT1310_S2.DivisionID
Left Join AT1310 AT1310_S3 On AT1302.S3= AT1310_S3.S and AT1310_S3.STypeID ='I03' AND AT1302.DivisionID= AT1310_S3.DivisionID
Left Join AT1015 AT1015_I01 On AT1302.I01ID= AT1015_I01.AnaID and AT1015_I01.AnaTypeID ='I01' AND AT1302.DivisionID= AT1015_I01.DivisionID
Left Join AT1015 AT1015_I02 On AT1302.I02ID= AT1015_I02.AnaID and AT1015_I02.AnaTypeID ='I02' AND AT1302.DivisionID= AT1015_I02.DivisionID
Left Join AT1015 AT1015_I03 On AT1302.I03ID= AT1015_I03.AnaID and AT1015_I03.AnaTypeID ='I03' AND AT1302.DivisionID= AT1015_I03.DivisionID
Left Join AT1015 AT1015_I04 On AT1302.I04ID= AT1015_I04.AnaID and AT1015_I04.AnaTypeID ='I04' AND AT1302.DivisionID= AT1015_I04.DivisionID
Left Join AT1015 AT1015_I05 On AT1302.I05ID= AT1015_I05.AnaID and AT1015_I05.AnaTypeID ='I05' AND AT1302.DivisionID= AT1015_I05.DivisionID
Left Join A00003 on AT1302.DivisionID = A00003.DivisionID and AT1302.InventoryID = A00003.InventoryID	
Where AT1302.DivisionID in (@DivisionID,'@@@')

END
