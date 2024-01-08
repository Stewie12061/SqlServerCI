IF EXISTS (SELECT TOP 1 1 FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[DBO].[CP0056]') AND  OBJECTPROPERTY(ID, N'IsProcedure') = 1)			
DROP PROCEDURE [DBO].[CP0056]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- <Summary>
---- Bắn qua danh mục mặt hàng khi thêm mới danh mục kho hàng (EIMSKIP)
-- <Param>
---- 
-- <Return>
---- 
-- <Reference>
---- 
-- <History>
----Created by: Bảo Thy, Date: 27/11/2015
---- Modified by Bảo Thy on 06/09/2016: Lấy Khối, Phòng từ danh mục phòng ban, tổ nhóm
---- Modified by Bảo Thy on 25/05/2017: Sửa danh mục dùng chung
/*-- <Example>
	CP0056 @DivisionID='MK',@UserID='001429',@InventoryID = 'ADM01'
----*/

CREATE PROCEDURE CP0056
( 
	@DivisionID VARCHAR(50),
	@UserID VARCHAR(50),
	@InventoryID VARCHAR(50)
)
AS 

IF NOT EXISTS (SELECT TOP 1 1 FROM AT1302 WITH (NOLOCK) WHERE InventoryID = @InventoryID)
BEGIN
	INSERT AT1302 (DivisionID, InventoryID, S1,	S2, S3,InventoryName,	InventoryTypeID,	UnitID,	Image01ID,	Image02ID,	Varchar01,	
	Varchar02,	Varchar03,	Varchar04,	Varchar05,	Amount01,	Amount02,	Amount03,	Amount04,	Amount05,	SalePrice01,	
	SalePrice02,	SalePrice03,	SalePrice04,	SalePrice05,	PriceDate01,	PriceDate02,	PriceDate03,	PriceDate04,	
	PriceDate05,	RecievedPrice,	DeliveryPrice,	Disabled,	CreateDate,	CreateUserID,	LastModifyDate,	LastModifyUserID,	
	Classify01ID,	Classify02ID,	Classify03ID,	Classify04ID,	Classify05ID,	Classify06ID,	Classify07ID,	Classify08ID,	
	MethodID,	IsSource,	AccountID,	SalesAccountID,	PurchaseAccountID,	PrimeCostAccountID,	IsLimitDate,	IsLocation,	
	IsStocked,	VATGroupID,	VATPercent,	NormMethod,	I01ID,	I02ID,	I03ID,	I04ID,	I05ID,	Notes01,	Notes02,	Notes03,	
	IsTools,	IsKIT,	KITID,	RefInventoryID,	Specification,	VATImGroupID,	VATImPercent,	PurchasePrice01,	PurchasePrice02,	
	PurchasePrice03,	PurchasePrice04,	PurchasePrice05,	Barcode,	IsDiscount,	AutoSerial,	SS1,	SS2,	SS3,	OutputOrder,	
	OutputLength,	Separated,	Separator,	S1Type,	S2Type,	S3Type,	Enabled1,	Enabled2,	Enabled3,	IsCommon,	ETaxID,	
	ETaxConvertedUnit,	ProductTypeID,	NRTClassifyID,	SETID,	IsToHRM,	ReSalesAccountID,	IsMinQuantity,	QCList,	
	IsBottle,	I06ID,	I07ID,	I08ID,	I09ID,	I10ID)
	
	SELECT DivisionID, WarehouseID,NULL,NULL,NULL,WarehouseName,'KHO','CA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,
	NULL,NULL,NULL,NULL,NULL,0,0,0,0,0,NULL,NULL,NULL,NULL,NULL,0,0,0,GETDATE(),@UserID,GETDATE(),@UserID,NULL,NULL,
	NULL,NULL,NULL,NULL,NULL,NULL,4,0,'1561',NULL,NULL,NULL,0,0,1,N'T00',0,2,NULL,NULL,NULL,NULL,NULL,NULL,
	NULL,NULL,0,0,NULL,NULL,NULL,N'T00',0,0,0,0,0,0,NULL,0,0,NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL,NULL,
	NULL,NULL,NULL,0,NULL,1.00,1,NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
	FROM AT1303 WITH (NOLOCK)
	WHERE DivisionID IN (@DivisionID,'@@@')
	AND WareHouseID = @InventoryID


	INSERT INTO A00003 (DivisionID,InventoryID,Image01ID,Image02ID)
    SELECT DivisionID, InventoryID, NULL, NULL
	FROM AT1302 WITH (NOLOCK)
	WHERE DivisionID IN (@DivisionID,'@@@')
	AND InventoryID = @InventoryID

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO