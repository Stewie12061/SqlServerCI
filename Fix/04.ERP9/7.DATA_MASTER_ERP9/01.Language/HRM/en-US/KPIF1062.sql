-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1062- KPI
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
SET @FormID = 'KPIF1062';

SET @LanguageValue = N'Evaluation phase view';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.EvaluationPhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation phase name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.EvaluationPhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation type';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.EvaluationTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Evaluation phase information';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.ThongTinDotDanhGia',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1062.StatusID',  @FormID, @LanguageValue, @Language;
