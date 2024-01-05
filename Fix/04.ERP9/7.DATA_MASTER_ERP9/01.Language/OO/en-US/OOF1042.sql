-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1042- OO
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
SET @FormID = 'OOF1042';

SET @LanguageValue = N'Status view';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status name in English';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.StatusNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Display order';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Color';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.Color', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.StatusType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'System status';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.SystemStatus', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'Lịch sử', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status information';
EXEC ERP9AddLanguage @ModuleID, 'Thông tin chung', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status Name English';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.StatusNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status detail';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.XemChiTietTrangThai', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF1042.GhiChu', @FormID, @LanguageValue, @Language;								


																					 