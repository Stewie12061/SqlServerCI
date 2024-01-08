------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF9024 - CRM 
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
SET @FormID = 'CRMF9024';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Chọn khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9024.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9024.AccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9024.AccountName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Mã số thuế';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9024.VATNo' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Địa chỉ';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9024.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9024.Email' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9024.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng VAT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9024.VATAccountID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9024.DivisionID' , @FormID, @LanguageValue, @Language;





