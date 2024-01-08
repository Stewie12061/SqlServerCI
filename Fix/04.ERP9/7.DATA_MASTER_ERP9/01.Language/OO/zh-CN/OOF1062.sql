-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1062- OO
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
SET @FormID = 'OOF1062';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作模板代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作模板名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'描述';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'所用時間（小時）';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.ExecutionTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'進步 （％）';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附件';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'目標類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'塞子類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.TaskBlockTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.TaskTypeName', @FormID, @LanguageValue, @Language;

