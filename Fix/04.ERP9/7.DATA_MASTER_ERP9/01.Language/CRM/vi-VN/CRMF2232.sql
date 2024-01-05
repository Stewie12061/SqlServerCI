-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2232 - CRM
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
SET @FormID = 'CRMF2232';

SET @LanguageValue = N'Chi tiết gói sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2232.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung gói sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2232.ThongTinGoiSanPham', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2232.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã gói';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2232.PackageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên gói';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2232.PackageName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2232.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2232.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết gói';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2232.ChiTietGoiSanPham', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2232.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2232.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cơ bản';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2232.IsStandard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2232.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2232.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2232.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2232.LastModifyDate', @FormID, @LanguageValue, @Language;