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

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase ID';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase name';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase order';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.PhaseOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'MF1812.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
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
