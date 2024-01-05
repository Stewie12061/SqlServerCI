-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1020- HRM
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
SET @FormID = 'HRMF1020';

SET @LanguageValue  = N'Recruitment Boundary'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Boundary ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.BoundaryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department Name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.CostBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department Name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty Name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1020.DutyName.CB',  @FormID, @LanguageValue, @Language;
