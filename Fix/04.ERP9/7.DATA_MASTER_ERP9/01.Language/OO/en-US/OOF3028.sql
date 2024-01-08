-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF3028- OO
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
SET @FormID = 'OOF3028';

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project/Task group';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.DepartmentID_ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.GroupReport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report Data';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.GroupReport1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.ReportID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report name';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.ReportName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report subject';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.ReportTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task report by project';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report by employee';
EXEC ERP9AddLanguage @ModuleID, 'AsoftOO.GRP_Employee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report by task';
EXEC ERP9AddLanguage @ModuleID, 'AsoftOO.GRP_Project', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assigned To User';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print Data';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.PrintData', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Problem Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.StatusIS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF3028.StatusMT', @FormID, @LanguageValue, @Language;