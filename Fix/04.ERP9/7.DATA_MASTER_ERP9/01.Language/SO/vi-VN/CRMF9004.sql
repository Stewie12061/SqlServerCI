------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF9004 - CRM 
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
SET @ModuleID = 'SO';
SET @FormID = 'CRMF9004';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Chọn khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9004.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9004.MemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9004.MemberName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Số điện thoại';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF9004.Phone' , @FormID, @LanguageValue, @Language;







