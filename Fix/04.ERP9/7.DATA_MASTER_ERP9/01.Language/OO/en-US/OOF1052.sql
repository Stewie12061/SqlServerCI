-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1052- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF1052';

SET @LanguageValue = N'Project /task group sample view';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sample ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.ProjectSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sample name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.ProjectSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.LastModifyDate', @FormID, @LanguageValue, @Language;

EXEC ERP9AddLanguage @ModuleID, 'OOF1052.ProcessName', @FormID, @LanguageValue, @Language;SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Step Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.DescriptionS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project/Task group sample information';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.ChiTietMauDuAn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Working process';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.QuyTrinhLamViec', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF1052.ThongTinMoTa', @FormID, @LanguageValue, @Language;

