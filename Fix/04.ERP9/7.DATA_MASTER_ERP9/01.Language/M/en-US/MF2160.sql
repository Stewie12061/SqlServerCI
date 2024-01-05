-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2160- M
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US ' 
SET @ModuleID = 'M';
SET @FormID = 'MF2160';

SET @LanguageValue = N'List production order';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VoucherNo';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product name';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.ProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product quantity';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.ProductQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine name';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase name';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2160.ProductID', @FormID, @LanguageValue, @Language;