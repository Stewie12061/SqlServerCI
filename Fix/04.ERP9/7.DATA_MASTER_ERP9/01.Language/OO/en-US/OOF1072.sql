-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1072- OO
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
SET @FormID = 'OOF1072';

SET @LanguageValue = N'Common list view';
EXEC ERP9AddLanguage @ModuleID, 'OOF1072.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF1072.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'List ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1072.CategoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'List name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1072.CategoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF1072.AttachID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF1072.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1072.AttachName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1072.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'OOF1072.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1072.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1072.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1072.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1072.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information on common list';
EXEC ERP9AddLanguage @ModuleID, 'OOF1072.ThongTinDanhMuc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'List data';
EXEC ERP9AddLanguage @ModuleID, 'OOF1072.DuLieuDanhMuc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'OOF1072.LichSu', @FormID, @LanguageValue, @Language;

