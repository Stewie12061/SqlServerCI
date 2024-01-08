-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2016- EDM
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
SET @ModuleID = 'EDM';
SET @FormID = 'EDMF2016';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2016.TxtSearch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2016.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tư vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2016.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2016.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2016.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2016.DateOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa từ kết quả truy vấn';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2016.Title', @FormID, @LanguageValue, @Language;

