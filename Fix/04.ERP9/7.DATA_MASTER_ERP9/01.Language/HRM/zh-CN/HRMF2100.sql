-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2100- HRM
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
SET @FormID = 'HRMF2100';

SET @LanguageValue = N'培訓時間表清單';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓時間表/培訓課程代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.SearchTxt', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓領域代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓領域名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingFieldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓形式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'{0:00}次状態';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'{0:00}次状態';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓時間表代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓課程代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingCourseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingCourseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預計費用';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.ScheduleAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.ProposeAmount_MT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.Description1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.Description2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.Description3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓夥伴';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.IsAll', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓形式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.TrainingProposeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2100.SpecificHours', @FormID, @LanguageValue, @Language;

