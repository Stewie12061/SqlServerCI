-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2003- PO
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
SET @Language = 'en-US' 
SET @ModuleID = 'PO';
SET @FormID = 'POF2003';

SET @LanguageValue = N'Select print type';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.ChooseTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name items';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.IsPrint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print Skid Label';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.Skid', @FormID, @LanguageValue, @Language;

