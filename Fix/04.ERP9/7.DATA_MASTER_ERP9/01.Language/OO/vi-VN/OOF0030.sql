-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF0030- OO
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
SET @FormID = 'OOF0030';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.YearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Áp dụng từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thiết lập thời gian làm việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền phạt đi trễ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0030.PunishLate', @FormID, @LanguageValue, @Language;
