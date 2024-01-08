-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2230- OO
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
SET @FormID = 'OOF2230';

SET @LanguageValue = N'Danh mục mail đi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.SubjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người gửi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.From', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nhận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.To', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.Cc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bcc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.Bcc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung mail';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Mail';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.UIDMail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phương thức';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.TypeOfProtocol', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian gửi email';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian gửi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.SendMailDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm nhận mail';
EXEC ERP9AddLanguage @ModuleID, 'OOF2230.GroupReceiverID', @FormID, @LanguageValue, @Language;

