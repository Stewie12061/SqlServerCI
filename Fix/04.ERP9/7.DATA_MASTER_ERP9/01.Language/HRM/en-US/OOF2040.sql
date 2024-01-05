-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2040- HRM
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
SET @ModuleID = 'HRM';
SET @FormID = 'OOF2040';

SET @LanguageValue = N'Application for card scanning addition/cancellation';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Application ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.ProcessID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.ProcessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.SectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SubsectionID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.SubsectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.ProcessID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Section';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.SectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subsection';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.SubsectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.ProcessName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.UserID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Proposer';
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.UserName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department'
EXEC ERP9AddLanguage @ModuleID, 'OOF2040.Department',  @FormID, @LanguageValue, @Language;
