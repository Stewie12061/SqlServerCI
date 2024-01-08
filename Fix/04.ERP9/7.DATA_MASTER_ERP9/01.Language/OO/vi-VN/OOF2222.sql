-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2222- OO
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
SET @FormID = 'OOF2222';

SET @LanguageValue = N'Xem chi tiết email nhận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.SubjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người gửi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.From', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nhận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.To', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.Cc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bcc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.Bcc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Email';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.UIDMail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phương thức';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.TypeOfProtocol', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung mail';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.NoiDungMail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết mail';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.ThongTinChiTietMail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian nhận email';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian gửi mail';
EXEC ERP9AddLanguage @ModuleID, 'OOF2222.SendMailDate', @FormID, @LanguageValue, @Language;

