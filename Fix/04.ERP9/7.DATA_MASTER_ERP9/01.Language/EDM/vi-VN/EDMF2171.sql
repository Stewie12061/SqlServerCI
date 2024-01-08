-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2171- EDM
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
SET @FormID = 'EDMF2171';

SET @LanguageValue = N'Cập nhật tin tức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đăng tin';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.NewsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tin tức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.NewTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tin tức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.NewTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày Public';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.PublicDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình ảnh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.Image', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tóm tắt';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.Summary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.Content', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.FromCreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.ToCreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày Public';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.FromPulicDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.ToPublicDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.NewTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tin tức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2171.NewTypeName.CB', @FormID, @LanguageValue, @Language;


