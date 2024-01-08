-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2271- WM
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
SET @FormID = 'WMF2271';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2271.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'WMF2271.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse';
EXEC ERP9AddLanguage @ModuleID, 'WMF2271.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ky wants to transfer';
EXEC ERP9AddLanguage @ModuleID, 'WMF2271.PeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'WMF2271.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue =N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'WMF2271.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue =N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'WMF2271.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue =N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'WMF2271.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2271.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Forward';
EXEC ERP9AddLanguage @ModuleID, 'WMF2271.Transfer', @FormID, @LanguageValue, @Language;

