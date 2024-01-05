------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2008 - CRM 
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
SET @FormID = 'CRMF2008';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Xem nhanh công nợ';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2008.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2008.O01ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhóm khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2008.O01Name' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Vật dụng cho mượn';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2008.InventoryName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Nhãn hiệu';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2008.InventoryID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Công nợ phải thu';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2008.ConvertedAmount' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Công nợ cọc, vỏ';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2008.DepositAmount' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Số lượng (vỏ) phải thu';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2008.BottleQuantity' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Số lượng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2008.BorrowQuantity' , @FormID, @LanguageValue, @Language;






