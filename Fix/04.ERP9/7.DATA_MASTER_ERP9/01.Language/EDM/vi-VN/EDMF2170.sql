-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2170- EDM
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
SET @FormID = 'EDMF2170';

SET @LanguageValue = N'Quản lý tin tức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.DivisionID.CB', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.DivisionName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đăng tin';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.NewsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tin tức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.NewTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tin tức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.NewTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày Public';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.PublicDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình ảnh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.Image', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tóm tắt';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.Summary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.Content', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.FromCreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.ToCreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày Public';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.FromPulicDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.ToPublicDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.NewTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tin tức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2170.NewTypeName.CB', @FormID, @LanguageValue, @Language;


