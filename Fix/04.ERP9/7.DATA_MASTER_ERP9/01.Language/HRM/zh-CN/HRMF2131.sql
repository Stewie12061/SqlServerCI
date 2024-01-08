-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2131- HRM
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
SET @FormID = 'HRMF2131';

SET @LanguageValue = N'更新費用記錄';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓形式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練場';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用記錄代碼/培訓時間表';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.SearchTxt', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.AssignedToUser', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練時間表';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingSchedule', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'實際培訓費用';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.CostAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingCourseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓夥伴';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成本記錄代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingCostID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自從';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練時間表';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.TrainingScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'AssignedToUserID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2131.APK', @FormID, @LanguageValue, @Language;

