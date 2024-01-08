-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2002- HRM
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
SET @FormID = 'HRMF2002';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment plan';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.RecruitPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total expected cost';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.TotalCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Existing costs';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.ActualCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixed costs';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.CostBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Workplace';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.WorkPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vacancy';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Available quantity';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fixed number of employees';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.QuantityBoundary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total cost estimate';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.TotalCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.WorkTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected cost';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.RecruitCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time need employees';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.RequireDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment plan information';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.TabThongTinKeHoachTuyenDung', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Details';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.TabThongTinChiTiet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2002.StatusID', @FormID, @LanguageValue, @Language;

