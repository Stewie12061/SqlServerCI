
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
SET @FormID = 'EDMF1012';

SET @LanguageValue = N'Danh mục định mức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Don_vi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã định mức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Ma_dinh_muc' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Dien_giai' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trường học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Ma_truong_hoc' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên trường học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Ten_truong_hoc' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Dung_chung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Khong_hien_thi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Nguoi_tao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Ngay_tao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Nguoi_cap_nhat' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Ngay_cap_nhat' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin định mức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Master' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết định mức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Details' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Cap' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định mức Học sinh/Giáo viên, Bảo mẫu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.So_luong' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lich sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Lich_su' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Attach.GR' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1012.Notes.GR' , @FormID, @LanguageValue, @Language;