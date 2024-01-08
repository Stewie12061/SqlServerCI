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
SET @Language = 'vi-VN' 
SET @ModuleID = 'S';
SET @FormID = 'SF0102';

SET @LanguageValue = N'Xem chi tiết danh mục dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết dữ liệu ngầm';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.ChiTietDuLieuNgam', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin khác';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.ThongTinKhac', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.CodeMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chi tiết 01';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.ID1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số thứ tự';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã ngôn ngữ';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.LanguageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.DescriptionE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.CategoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm file';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.AttachID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm file';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên file đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.AttachName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin dữ liệu ngầm';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.ThongTinDanhMuc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dữ liệu danh mục';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.DuLieuDanhMuc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'SF0102.LichSu', @FormID, @LanguageValue, @Language;

