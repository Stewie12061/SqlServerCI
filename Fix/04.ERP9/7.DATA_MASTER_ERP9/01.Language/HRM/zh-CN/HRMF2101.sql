-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2101- HRM
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
SET @FormID = 'HRMF2101';

SET @LanguageValue = N'操更新培訓時間表作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最後修改的用戶';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最後修改日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分配';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓計劃/課程 ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.SearchTxt', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練場';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練場';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingFieldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓形式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓時間表代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingScheduleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingCourseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練課程';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingCourseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預計的培訓費用';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.ScheduleAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建議的培訓費用';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.ProposeAmount_MT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'目标';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Description1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Description2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Description3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓夥伴';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地點';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預計培訓時間自';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到達';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'全公司培訓';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.IsAll', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓形式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.TrainingProposeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2101.SpecificHours', @FormID, @LanguageValue, @Language;

