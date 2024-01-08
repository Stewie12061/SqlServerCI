------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2002 - CRM 
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
SET @FormID = 'CRMF2002';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'CRMF2002-Chuyển hướng cuộc gọi';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2002.CRMF2002Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn số line';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2002.SipID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2002.FullName' , @FormID, @LanguageValue, @Language;



