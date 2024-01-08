------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2007 - CRM 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2007';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Thêm nhanh liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2007.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2007.ContactID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xưng hô';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2007.Prefix' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2007.LastName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ và tên đệm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2007.FirstName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2007.ContactName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2007.HomeAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Di động';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2007.HomeMobile' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2007.HomeTel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2007.HomeEmail' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Messenger';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2007.Messenger' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Là khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2007.IsAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2007.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2007.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công ty';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2007.CompanyName' , @FormID, @LanguageValue, @Language;

-------------- 21/09/2021 - Hoài Bảo: Bổ sung ngôn ngữ cho màn hình thêm nhanh liên hệ --------------
SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2007.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức danh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2007.TitleContact', @FormID, @LanguageValue, @Language;