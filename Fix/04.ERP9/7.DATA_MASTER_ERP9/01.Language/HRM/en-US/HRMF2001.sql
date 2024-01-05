-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2001- HRM
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
SET @FormID = 'HRMF2001';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment plan';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.RecruitPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total cost estimate';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.TotalCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Available cost';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.ActualCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixing recruitment cost';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.CostBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workplace';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Available quantity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixed number of employees';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.QuantityBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total cost estimate';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.TotalCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.WorkTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected cost';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.RecruitCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time need employees';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.RequireDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.DutyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.DutyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work type ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.ID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work type name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2001.WorkType.CB' , @FormID, @LanguageValue, @Language;



