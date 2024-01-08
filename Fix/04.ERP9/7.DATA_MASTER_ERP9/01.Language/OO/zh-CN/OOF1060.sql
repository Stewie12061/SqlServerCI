-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1060- OO
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
SET @FormID = 'OOF1060';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作模板代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作模板名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'描述';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'所用時間（小時）';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.ExecutionTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'進步 （％）';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附件';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'目標類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'塞子類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.TaskBlockTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1060.TaskTypeName', @FormID, @LanguageValue, @Language;

