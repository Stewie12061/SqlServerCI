-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF3029- OO
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
SET @FormID = 'OOF3029';

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.DepartmentID_UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.GroupReport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report Data';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.GroupReport1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.ReportID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report name';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.ReportName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report subject';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.ReportTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report by employee';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Problem Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.StatusIS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.StatusMT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Support request status';
EXEC ERP9AddLanguage @ModuleID, 'OOF3029.StatusHD', @FormID, @LanguageValue, @Language;
