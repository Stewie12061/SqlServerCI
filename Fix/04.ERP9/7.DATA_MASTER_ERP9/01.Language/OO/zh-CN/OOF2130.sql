-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2130- OO
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
SET @FormID = 'OOF2130';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始日期（計劃）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'截止日期（計劃）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束日期（實際）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始日期（實際）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更正日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'修理人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.Mark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'指標組';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.TargetsGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.Reject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'指標組';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.TargetsGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.Percentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'評估員';
EXEC ERP9AddLanguage @ModuleID, 'OOF2130.AssessUserName', @FormID, @LanguageValue, @Language;

