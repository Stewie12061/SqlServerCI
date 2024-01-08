-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1061- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF1061';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作模板代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作模板名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'描述';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'所用時間（小時）';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.ExecutionTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'進步 （％）';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附件';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'目標類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'塞子類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.TaskBlockTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1061.TaskTypeName', @FormID, @LanguageValue, @Language;

