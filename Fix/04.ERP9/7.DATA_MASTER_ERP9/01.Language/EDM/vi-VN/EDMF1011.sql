
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
SET @Language = 'vi-VN' 
SET @ModuleID = 'EDM';
SET @FormID = 'EDMF1011';

SET @LanguageValue = N'Danh mục định mức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.Don_vi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã định mức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.Ma_dinh_muc' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã định mức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.APK' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.Dien_giai' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.Truong_hoc' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên trường học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.Ten_truong_hoc' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.Dung_chung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.Khong_hien_thi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.Nguoi_tao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.Ngay_tao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.Nguoi_cap_nhat' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.Ngay_cap_nhat' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.Cap' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định mức Học sinh / Giáo viên,Bảo mẫu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.So_luong' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.LevelID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.LevelName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.Disabled' , @FormID, @LanguageValue, @Language;

--SET @LanguageValue = N'Mã';
--EXEC ERP9AddLanguage @ModuleID, 'EDMF1011.APK' , @FormID, @LanguageValue, @Language;

