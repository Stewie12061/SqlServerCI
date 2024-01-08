-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF0002- CSM
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
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF0002';

SET @LanguageValue = N'Thiết lập tài khoản API cho người dùng theo hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0002.FirmID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người dùng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0002.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người dùng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0002.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0002.Account', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mật khẩu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0002.Password', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0002.TechnicalID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0002.FirmID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF0002.FirmName.CB', @FormID, @LanguageValue, @Language;

