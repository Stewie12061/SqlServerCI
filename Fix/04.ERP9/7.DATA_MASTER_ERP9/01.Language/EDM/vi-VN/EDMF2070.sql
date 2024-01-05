-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2070- EDM
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
SET @FormID = 'EDMF2070';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.DecisionDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.DecisionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.PromoterID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.PromoterName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.DivisionIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.DivisionNameTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trường chuyển đi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.SchoolIDFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường chuyển đi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.SchoolNameFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trường chuyển đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.SchoolIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường chuyển đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.SchoolNameTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.DeciderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.DeciderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.TeacherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khối điều chuyển';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.GradeIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối điều chuyển';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.GradeNameTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lớp điều chuyển';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.ClassIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp điều chuyển';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.ClassNameTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.TeacherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.lblDicisionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều chuyển giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.DivisionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2070.DivisionName.CB', @FormID, @LanguageValue, @Language;


