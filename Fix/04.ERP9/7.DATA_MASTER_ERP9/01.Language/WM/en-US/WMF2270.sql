-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2270- wm
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
SET @ModuleID = 'wm';
SET @FormID = 'WMF2270';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2270.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'WMF2270.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse';
EXEC ERP9AddLanguage @ModuleID, 'WMF2270.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounting period';
EXEC ERP9AddLanguage @ModuleID, 'WMF2270.PeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voting maker';
EXEC ERP9AddLanguage @ModuleID, 'WMF2270.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'WMF2270.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue =N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'WMF2270.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'WMF2270.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2270.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2270.Transfer', @FormID, @LanguageValue, @Language;

