-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2012- KPI
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
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF2012';

SET @LanguageValue = N'Bonus view';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deparment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total bonus amount';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.TotalBonusAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.EvaluationPhaseName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Deparment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bonus information';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.ThongTinTinhThuong',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bonus details';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.ThongTinChiTietTinhThuong',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.EvaluationSetID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'KPI evaluation set';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.EvaluationSetName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Position';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.TitleName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Total unified point';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.TotalUnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.ClassificationUnifiedPoint',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Revenue';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.Revenue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bonus rate';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.BonusRate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bonus amount';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.BonusAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2012.StatusID',  @FormID, @LanguageValue, @Language;