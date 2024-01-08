-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2133- HRM
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
SET @FormID = 'HRMF2133';

SET @LanguageValue = N'選擇訓練時間表';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓時間表代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.TrainingScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.TrainingCourseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練場';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.TrainingFieldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓形式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.TrainingTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預計費用';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.ScheduleAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.TrainingTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'夥伴';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2133.ObjectName', @FormID, @LanguageValue, @Language;

