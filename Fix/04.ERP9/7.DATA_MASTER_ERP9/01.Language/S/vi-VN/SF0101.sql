-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF0101- S
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
SET @ModuleID = 'S';
SET @FormID = 'SF0101';

SET @LanguageValue = N'Cập nhật danh mục dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.CodeMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chi tiết 01';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.ID1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số thứ tự';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã ngôn ngữ';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.LanguageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.DescriptionE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.CategoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm file';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.AttachID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm file';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên file đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.AttachName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.ModuleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF0101.ModuleName.CB', @FormID, @LanguageValue, @Language;
