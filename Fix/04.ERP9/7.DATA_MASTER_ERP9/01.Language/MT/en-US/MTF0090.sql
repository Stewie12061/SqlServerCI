-----------------------------------------------------------------------------------------------------
-- Script tạo message - MT
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(5),
@FormID VARCHAR(50),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),
@LanguageCustomValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT

/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'vi-VN'; 
SET @ModuleID = 'MT';
SET @FormID = 'MTF0090';

SET @LanguageValue = N'Mã lớp';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0090.ClassID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Tên lớp';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0090.ClassName' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Danh sách lớp hiện tại';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0090.Grid1Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Danh sách lớp của giáo viên phụ trách';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0090.Grid2Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Nhóm người dùng';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0090.GroupID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Admin';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0090.IsAdmin' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Cập nhật kết quả giữa khóa và cuối khóa';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0090.IsExamResult' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Cập nhật thông tin học viên';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0090.IsStudentInfo' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Cập nhật kết quả thi đầu vào';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0090.IsStudentResult' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Cập nhật thông tin chung QT học tập';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0090.IsStudyInfo' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Thiết lập phân quyền trên TAB';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0090.MTF0090Tab01' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Thiết lập phân quyền giáo viên theo lớp';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0090.MTF0090Tab02' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Thiết lập phân quyền chức năng';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0090.MTF0090Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Lưu ý: Thiết lập chỉ sử dụng được sau khi đăng xuất và đăng nhập lại hệ thống';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0090.Notification' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;

SET @LanguageValue = N'Người dùng';
SET @LanguageCustomValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MTF0090.UserID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;
