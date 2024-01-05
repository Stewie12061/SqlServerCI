
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
SET @FormID = 'EDMF1021';

SET @LanguageValue = N'Cập nhật lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.Don_vi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.Ma_lop' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.Ten_lop' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.Truong' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.Cap' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.Khoi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định mức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.Dinh_muc' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.Dung_chung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.Khong_hien_thi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.Nguoi_tao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.Ngay_tao' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.Nguoi_cap_nhat' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.Ngay_cap_nhat' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.QuotaID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.QuotaName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.LevelID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.LevelName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.ClassName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.LevelID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.GradeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định mức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.QuotaID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF1021.Disabled' , @FormID, @LanguageValue, @Language;