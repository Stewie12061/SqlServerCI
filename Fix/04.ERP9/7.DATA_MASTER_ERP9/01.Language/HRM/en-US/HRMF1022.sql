-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1022- HRM
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
SET @FormID = 'HRMF1022';

SET @LanguageValue = N'Recruitment Boundary View';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Boundary ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.BoundaryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department Name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost Boundary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.CostBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'FromDate';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ToDate';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quantity Boundary'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.QuantityBoundary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Recruitment Boundary Detail'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.TabInfo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1022.StatusID',  @FormID, @LanguageValue, @Language;