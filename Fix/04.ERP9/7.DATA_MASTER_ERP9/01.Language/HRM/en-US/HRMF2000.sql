-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2000- HRM
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
SET @FormID = 'HRMF2000';

SET @LanguageValue = N'Recruitment plan';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment plan';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.RecruitPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total cost estimate';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.TotalCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Available cost';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.ActualCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixing recruitment cost';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.CostBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reviewer''s notes';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.DutyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.DutyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2000.DepartmentName.CB' , @FormID, @LanguageValue, @Language;