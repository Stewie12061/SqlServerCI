-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2190- OO
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
SET @FormID = 'OOF2190';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'里程碑代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.MilestoneID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'里程碑名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.MilestoneName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始時間';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'截止日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發行版本';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.ReleaseVerion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'里程碑說明';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創立日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最後修改用戶';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最後修改日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'里程碑類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.TypeOfMilestone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.VoucherTypeID', @FormID, @LanguageValue, @Language;

