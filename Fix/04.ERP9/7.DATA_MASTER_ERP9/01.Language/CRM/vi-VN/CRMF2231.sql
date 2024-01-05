-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2231 - CRM
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
SET @Language = 'vi-VN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2231';

SET @LanguageValue = N'Cập nhật Gói sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2231.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2231.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã gói';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2231.PackageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên gói';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2231.PackageName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2231.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2231.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2231.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2231.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cơ bản';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2231.IsStandard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thêm nhiều sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2231.ChooseInventoryList', @FormID, @LanguageValue, @Language;