-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2020- EDM
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
SET @FormID = 'EDMF2020';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã xếp lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.ArrangeClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tao';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tao';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ké thừa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.IsInherit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.DateOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giới tính';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.Sex', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.IsTransfer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tao';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tao';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xếp lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.ApproverID1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020..ApproverID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020..ApproverID3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 4';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020..ApproverID4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 5';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020..ApproverID5', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.ApproverName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.ApproverName2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.ApproverName3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 4';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.ApproverName4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 5';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.ApproverName5', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.ClassIDFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.DateFrom.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.DateTo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giấy xác nhận vào lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2020.Report', @FormID, @LanguageValue, @Language;