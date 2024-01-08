-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1311- CI
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
SET @FormID = 'CIF1311';

SET @LanguageValue = N'產品組之更新';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼之设立';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.AnaTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.AnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工姓名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.AnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'食譜';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'参考日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.RefDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第1金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第2金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第3金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第4金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第5金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第6金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第7金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第8金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第9金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'金额 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Amount10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.Note10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創造人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'取決於PT 代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.ReAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.ReAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'面試類型名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1311.GroupID', @FormID, @LanguageValue, @Language;

