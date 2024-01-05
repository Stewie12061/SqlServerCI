-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2072- EDM
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
SET @FormID = 'EDMF2072';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.DecisionDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.DecisionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.PromoterID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.PromoterName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường chuyển đi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.SchoolIDFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường chuyển đi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.SchoolNameFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường chuyển đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.SchoolIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường chuyển đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.SchoolNameTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.DeciderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.DeciderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.TeacherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối điều chuyển';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.GradeIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối điều chuyển';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.GradeNameTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp điều chuyển';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.ClassIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp điều chuyển';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.ClassNameTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.TeacherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.lblDicisionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều chuyển giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin chuyển giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.Lich_su', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2072.DivisionNameTo', @FormID, @LanguageValue, @Language;