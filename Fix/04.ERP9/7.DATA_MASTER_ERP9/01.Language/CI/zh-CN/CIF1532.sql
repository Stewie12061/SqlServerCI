-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1532- CI
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
SET @Language = 'zh-CN' 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1532';

SET @LanguageValue = N'促銷折扣錢包詳細';
EXEC ERP9AddLanguage @ModuleID, 'CIF1532.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1532.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1532.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1532.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1532.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'對象名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1532.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'總可用價值折扣';
EXEC ERP9AddLanguage @ModuleID, 'CIF1532.SumDiscountValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'可用總折扣率';
EXEC ERP9AddLanguage @ModuleID, 'CIF1532.SumDiscountRate', @FormID, @LanguageValue, @Language;

