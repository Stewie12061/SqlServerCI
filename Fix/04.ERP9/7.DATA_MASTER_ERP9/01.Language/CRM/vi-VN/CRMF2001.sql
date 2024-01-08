------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2001 - CRM 
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
SET @FormID = 'CRMF2001';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'CRMF2001-Gọi đến';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2001.CRMF2001Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CRMF2001-Hỗ trợ online';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2001.AccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2001.ContactName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID người liên hệ';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2001.ContactID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2001.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2001.AccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2001.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2001.Tel' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Nhãn hiệu 01';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2001.Description02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhãn hiệu 02';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2001.Description03' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhãn hiệu 03';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2001.Description04' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhãn hiệu 04';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2001.Description05' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2001.O04ID' , @FormID, @LanguageValue, @Language;

-------------- 20/10/2021 - Hoài Bảo: Bổ sung ngôn ngữ cho màn hình gọi điện --------------
SET @LanguageValue = N'ID Đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2001.LeadID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2001.LeadName' , @FormID, @LanguageValue, @Language;