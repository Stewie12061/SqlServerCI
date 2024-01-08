-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2172- HRM
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
SET @FormID = 'HRMF2172';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date founded';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.WorkToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.WorkFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Block';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Part';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Month';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Block';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Factory';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.SubSectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.MonthYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.LableName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approved by';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.ApprovePersonName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reviewer notes';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.ApprovePersonNote', @FormID, @LanguageValue, @Language;

