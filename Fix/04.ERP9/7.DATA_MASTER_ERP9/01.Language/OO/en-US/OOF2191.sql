-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2191- OO
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
SET @Language = 'en-US' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF2191';

SET @LanguageValue = N'Update milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.MilestoneID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.MilestoneName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deadline';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release version';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.ReleaseVerion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue =  N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.TypeOfMilestone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2191.VoucherTypeID', @FormID, @LanguageValue, @Language;

