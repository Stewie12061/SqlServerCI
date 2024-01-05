-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2112- HRM
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
SET @FormID = 'HRMF2112';

SET @LanguageValue = N'D.I.S.C Personality Trait view';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.TitleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.EvaluationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nature D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Nature_D', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nature I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Nature_I', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nature S';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Nature_S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nature C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Nature_C', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nature';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Nature', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Adaptive D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Adaptive_D', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Adaptive I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Adaptive_I', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Adaptive S';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Adaptive_S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Adaptive C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Adaptive_C', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Adaptive';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Adaptive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Descriptions';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.Descriptions', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Personal character group';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.NhomTinhCachCaNhan',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nature character group';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.NhomTinhCachTuNhien',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Adaptive character group';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.NhomTinhCachThichUng',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2112.StatusID',  @FormID, @LanguageValue, @Language;