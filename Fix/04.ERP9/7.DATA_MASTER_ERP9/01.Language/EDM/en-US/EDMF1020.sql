
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
SET @FormID = 'EDMF1020';

SET @LanguageValue = N'Class list';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1020.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1020.Don_vi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Class code';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1020.Ma_lop' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Class name';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1020.Ten_lop' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'School';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1020.Truong' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Level';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1020.Cap' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Grade';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1020.Khoi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quota';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1020.Dinh_muc' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1020.Dung_chung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1020.Khong_hien_thi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1020.Nguoi_tao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Created date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1020.Ngay_tao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Modifier';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1020.Nguoi_cap_nhat' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Modified date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1020.Ngay_cap_nhat' , @FormID, @LanguageValue, @Language;

