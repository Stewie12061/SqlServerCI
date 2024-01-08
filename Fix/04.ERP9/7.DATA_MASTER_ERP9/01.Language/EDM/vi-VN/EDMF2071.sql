-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2071- EDM
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
SET @FormID = 'EDMF2071';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.DecisionDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.DecisionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.PromoterID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.PromoterName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường chuyển đi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.SchoolIDFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường chuyển đi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.SchoolNameFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường chuyển đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.SchoolIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường chuyển đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.SchoolNameTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.DeciderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.DeciderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.TeacherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối điều chuyển đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.GradeIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối điều chuyển đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.GradeNameTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp điều chuyển đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.ClassIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp điều chuyển đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.ClassNameTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối điều chuyển';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.GradeNameFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp điều chuyển';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.ClassNameFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.TeacherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.lblDicisionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều chuyển giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật thông tin chuyển giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.Danh_sach_giao_vien', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.DivisionIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.DivisionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2071.DivisionName.CB', @FormID, @LanguageValue, @Language;