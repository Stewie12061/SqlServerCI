-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF1812- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF1812';

SET @LanguageValue = N'Production phase view';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process code';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage name';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase order';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.PhaseOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Editor';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production phase information';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.ThongTinCongDoanSanXuat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.StatusID', @FormID, @LanguageValue, @Language;
