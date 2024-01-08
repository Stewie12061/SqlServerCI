-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2130- HRM
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
SET @FormID = 'HRMF2130';

SET @LanguageValue = N'費用記錄清單';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓形式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練場';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用記錄代碼/培訓時間表';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.SearchTxt', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.AssignedToUser', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練時間表';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingSchedule', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'費用';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.CostAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingCourseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓夥伴';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成本記錄代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingCostID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自從';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練時間表';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.TrainingScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2130.APK', @FormID, @LanguageValue, @Language;

