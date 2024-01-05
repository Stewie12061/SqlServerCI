
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF10006
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),

------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
DECLARE @KeyID VARCHAR(100)
DECLARE @Text NVARCHAR(4000)
DECLARE @CustomName NVARCHAR(4000)

SET @FormID = N'QCF10014'
SET @Language = N'vi-VN'
SET @ModuleID = N'QC'

SET @LanguageValue = N'Chọn mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10014.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10014.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10014.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị tính';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10014.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10014.InventoryName' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Loại mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10014.InventoryTypeID' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Giá bán 01';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10014.SalePrice01' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Giá mua';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10014.RecievedPrice' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Giá bán';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10014.DeliveryPrice' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Quản lý tồn kho';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10014.IsStocked' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị tính';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10014.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10014.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
 EXEC ERP9AddLanguage @ModuleID, 'QCF10014.IsCommon' , @FormID, @LanguageValue, @Language;

GO