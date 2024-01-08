
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HF0405- OO
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
SET @ModuleID = 'EDM';
SET @FormID = 'EDMF1041';

SET @LanguageValue = N'School year list';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1041.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1041.Don_vi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'School year code';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1041.Ma_nam_hoc' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1041.Tu_ngay' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1041.Den_ngay' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1041.Dung_chung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1041.Khong_hien_thi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1041.Nguoi_tao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Created date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1041.Ngay_tao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Modifier';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1041.Nguoi_cap_nhat' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Modified date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1041.Ngay_cap_nhat' , @FormID, @LanguageValue, @Language;

