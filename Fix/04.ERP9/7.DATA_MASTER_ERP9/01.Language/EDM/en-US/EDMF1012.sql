
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
SET @FormID = 'EDMF1012';

SET @LanguageValue = N'Quota list';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Don_vi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quota code';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Ma_dinh_muc' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Dien_giai' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'School code';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Ma_truong_hoc' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'School name';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Ten_truong_hoc' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Dung_chung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Khong_hien_thi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Nguoi_tao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Ngay_tao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Nguoi_cap_nhat' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Ngay_cap_nhat' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quota information';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Master' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quota details';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Details' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Level name';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Cap' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.So_luong' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Lich_su' , @FormID, @LanguageValue, @Language;