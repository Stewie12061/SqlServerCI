------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2001 - CRM 
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
SET @FormID = 'SOF2005';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Chọn mẫu in đơn hàng bán sỉ (Sell In)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2005.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu in';
EXEC ERP9AddLanguage @ModuleID, 'SOF2005.IsPrint' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mẫu in';
EXEC ERP9AddLanguage @ModuleID, 'SOF2005.Description.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mẫu in';
EXEC ERP9AddLanguage @ModuleID, 'SOF2005.IsPrint.CB' , @FormID, @LanguageValue, @Language;