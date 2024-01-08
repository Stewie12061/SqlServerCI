-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1312- CI
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
SET @FormID = 'CIF1312';

SET @LanguageValue = N'產品組詳細信息之查看';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼之设立';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.AnaTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.AnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工姓名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.AnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'食譜';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'参考日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.RefDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第1金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第2金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第3金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第4金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第5金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第6金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第7金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第8金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第9金額 ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'金额 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Amount10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.Note10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'取決於PT 代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.ReAnaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'取決於PT 代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.ReAnaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1312.GroupID', @FormID, @LanguageValue, @Language;

