------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF9001 - CRM 
-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ
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
SET @Language = 'en-US';
SET @ModuleID = 'SO';
SET @FormID = 'CRMF9001';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Choose Object';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9001.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'AccountID';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9001.AccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account Name';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9001.AccountName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'VAT No';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9001.VATNo' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Address';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9001.Address' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Email';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9001.Email' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Tel';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9001.Tel' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Division';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9001.DivisionID' , @FormID, @LanguageValue, @Language;






