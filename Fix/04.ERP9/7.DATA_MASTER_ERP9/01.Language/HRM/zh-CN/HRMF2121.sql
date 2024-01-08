-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2121- HRM
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
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2121';

SET @LanguageValue = N'更新結果記錄';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.TrainingCourseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓形式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.TrainingTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓形式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.TrainingType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練場';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練場';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.TrainingFieldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.SearchTxt', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練時間表';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.TrainingScheduleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地點';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'提出建議';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.Description1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.Description2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓夥伴';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練時間表';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.TrainingScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'一般評估';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.ResultTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'一般評估';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.ResultTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結果記錄代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.TrainingResultID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2121.APK', @FormID, @LanguageValue, @Language;

