------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2004 - CRM 
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
SET @FormID = 'CRMF2004';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'CRMF2004-Xem nhanh công nợ';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2004.CRMF2004Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2004.AccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2004.AccountName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Hạn mức nợ cho phép';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2004.ReCreditLimit' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Điều khoản thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2004.PaymentTermName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Số ngày phải thanh toán';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2004.ReDueDays' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Nợ phải thu';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2004.ReceivedAmount' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Nợ quá hạn';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2004.OverDueAmount' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Nợ phải trả';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2004.PaymentAmount' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Tuổi nợ cho phép';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2004.ReDays' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Nợ vỏ/bình';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2004.ReQuantity' , @FormID, @LanguageValue, @Language;




