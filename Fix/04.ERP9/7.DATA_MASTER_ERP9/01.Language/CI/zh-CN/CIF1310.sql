-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1310- CI
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
SET @FormID = 'CIF1310';

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼之设立';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工姓名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.AnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'食譜';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'参考日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.RefDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第1金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第2金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第3金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第4金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第5金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第6金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第7金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第8金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第9金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'金额 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Amount10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.Note10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創造人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.ReAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.ReAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試類型名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1310.GroupID', @FormID, @LanguageValue, @Language;

