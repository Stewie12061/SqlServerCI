-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1012- KPI
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
SET @FormID = 'KPIF1012';

SET @LanguageValue = N'Targets group View';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets group ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.TargetsGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets group name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.TargetsGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets type';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.TargetsTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order group';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Percentage';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.Percentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Goal';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.Goal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Target group information';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.ThongTinNhomChiTieu',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.EvaluationPhaseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Target group details';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.ChiTietThongTinNhomChiTieu',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1012.StatusID',  @FormID, @LanguageValue, @Language;