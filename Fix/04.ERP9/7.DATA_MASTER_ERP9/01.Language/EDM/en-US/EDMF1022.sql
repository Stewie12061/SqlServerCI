
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
SET @FormID = 'EDMF1022';

SET @LanguageValue = N'Class list';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1022.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1022.Don_vi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Class code';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1022.Ma_lop' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Class name';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1022.Ten_lop' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'School';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1022.Truong' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Level';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1022.Cap' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Grade';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1022.Khoi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quota';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1022.Dinh_muc' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1022.Dung_chung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1022.Khong_hien_thi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1022.Nguoi_tao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1022.Ngay_tao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1022.Nguoi_cap_nhat' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1022.Ngay_cap_nhat' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Class information';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1022.Info' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1022.Lich_su' , @FormID, @LanguageValue, @Language;

