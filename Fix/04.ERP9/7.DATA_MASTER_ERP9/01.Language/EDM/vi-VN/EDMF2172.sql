-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2172- EDM
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
SET @FormID = 'EDMF2172';

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.Attach.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết tin tức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đăng tin';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.NewsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.TitleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tin tức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.NewTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tin tức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.NewTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày Public';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.PublicDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình ảnh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.Image', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tóm tắt';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.Summary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.Content', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.FromCreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.ToCreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày Public';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.FromPulicDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.ToPublicDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.NewTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tin tức';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.NewTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2172.Lich_su', @FormID, @LanguageValue, @Language;
