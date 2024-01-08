-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2024- WM
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
SET @ModuleID = 'WM';
SET @FormID = 'WMF2024';

SET @LanguageValue = N'Order number';
EXEC ERP9AddLanguage @ModuleID, 'WMF2024.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2024.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2024.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object code';
EXEC ERP9AddLanguage @ModuleID, 'WMF2024.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order date';
EXEC ERP9AddLanguage @ModuleID, 'WMF2024.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'WMF2024.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'WMF2024.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order number';
EXEC ERP9AddLanguage @ModuleID, 'WMF2024.OrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'WMF2024.DivisionID', @FormID, @LanguageValue, @Language;

