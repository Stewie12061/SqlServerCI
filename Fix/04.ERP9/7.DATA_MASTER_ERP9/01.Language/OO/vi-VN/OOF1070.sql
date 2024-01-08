-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1070- OO
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
SET @Language = 'vi-VN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF1070';

SET @LanguageValue = N'Danh mục dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'OOF1070.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1070.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã danh mục';
EXEC ERP9AddLanguage @ModuleID, 'OOF1070.CategoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên danh mục';
EXEC ERP9AddLanguage @ModuleID, 'OOF1070.CategoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm file';
EXEC ERP9AddLanguage @ModuleID, 'OOF1070.AttachID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm file';
EXEC ERP9AddLanguage @ModuleID, 'OOF1070.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên file đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF1070.AttachName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1070.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'OOF1070.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF1070.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF1070.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF1070.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF1070.LastModifyDate', @FormID, @LanguageValue, @Language;

