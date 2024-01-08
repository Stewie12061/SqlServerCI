-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF0102- S
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
SET @ModuleID = 'S';
SET @FormID = 'SF0102';

SET @LanguageValue = N'View detail data';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Detail of implicit data';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.ChiTietDuLieuNgam', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other info';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.ThongTinKhac', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code master';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.CodeMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID 01';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.ID1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order no';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.LanguageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.DescriptionE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Category name';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.CategoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach ID';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.AttachID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach file';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach file name';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.AttachName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IsCommon';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Implicit data info';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.ThongTinDanhMuc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Data of list';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.DuLieuDanhMuc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.LichSu', @FormID, @LanguageValue, @Language;

