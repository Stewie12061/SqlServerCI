-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1481- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1481';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1481.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1481.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1481.AnaTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gửi ý kiến phản hồi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1481.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Các bản dịch đã thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1481.UserNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Original name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1481.SystemName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Translations done';
EXEC ERP9AddLanguage @ModuleID, 'CIF1481.SystemNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Use';
EXEC ERP9AddLanguage @ModuleID, 'CIF1481.IsUsed', @FormID, @LanguageValue, @Language;

