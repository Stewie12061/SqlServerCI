-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2150- OO
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
SET @FormID = 'OOF2150';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目負責人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.LeaderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.ProjectType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.Mark', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.TargetsGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.Reject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'指標組';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.TargetsGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.Percentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2150.StatusName', @FormID, @LanguageValue, @Language;

