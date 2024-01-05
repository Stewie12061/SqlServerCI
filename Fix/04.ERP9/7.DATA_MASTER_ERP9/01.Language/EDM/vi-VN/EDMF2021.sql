-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2021- EDM
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
SET @FormID = 'EDMF2021';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã xếp lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.ArrangeClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.IsInherit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.DateOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giới tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.Sex', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.TransferName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.IsTransfer', @FormID, @LanguageValue, @Language; 

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật thông tin xếp lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.btnChosseStudent', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người duyệt 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.ApproverID1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.ApproverID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.ApproverID3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 4';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.ApproverID4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 5';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.ApproverID5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.DateFrom.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.DateTo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2021.GradeName.CB', @FormID, @LanguageValue, @Language;