-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2220- OO
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
SET @FormID = 'OOF2220';

SET @LanguageValue = N'Danh mục email nhận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.SubjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người gửi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.From', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người nhận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.To', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.Cc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bcc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.Bcc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung mail';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Mail';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.UIDMail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phương thức';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.TypeOfProtocol', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian nhận email';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian gửi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2220.SendMailDate', @FormID, @LanguageValue, @Language;

