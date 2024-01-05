
------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF00166 - CRM 
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
SET @ModuleID = 'POS';
SET @FormID = 'POSF00167';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Giá trị chiết khấu các chương trình';
EXEC ERP9AddLanguage @ModuleID, 'POSF00167.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chính sách chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'POSF00167.InventoryDiscountAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiết khấu theo thẻ thành viên';
EXEC ERP9AddLanguage @ModuleID, 'POSF00167.MemberDiscountAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chương trình sinh nhật trong tháng';
EXEC ERP9AddLanguage @ModuleID, 'POSF00167.BirthdayDiscountAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'(Áp dụng)';
EXEC ERP9AddLanguage @ModuleID, 'POSF00167.UseCount' , @FormID, @LanguageValue, @Language;