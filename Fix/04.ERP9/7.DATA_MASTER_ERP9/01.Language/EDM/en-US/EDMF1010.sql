
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
SET @FormID = 'EDMF1010';

SET @LanguageValue = N'Quota list';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1010.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1010.Don_vi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quota ID';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1010.Ma_dinh_muc' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1010.Dien_giai' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'School';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1010.Truong' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'School';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1010.Truong' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1010.Dung_chung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1010.Khong_hien_thi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1010.Nguoi_tao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Created date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1010.Ngay_tao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Modifier';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1010.Nguoi_cap_nhat' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Modified date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1010.Ngay_cap_nhat' , @FormID, @LanguageValue, @Language;

--select * from A00001 where LanguageID = 'en-US' and ID like '%Nguoi_cap%'

