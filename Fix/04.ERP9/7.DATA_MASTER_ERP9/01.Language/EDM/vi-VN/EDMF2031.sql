-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2031- EDM
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
SET @FormID = 'EDMF2031';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phân công';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.SchoolYearName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.TeacherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.TeacherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.EDMT2031_TeacherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.EDMT2031_TeacherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo mẫu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.NannyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo mẫu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.NannyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo mẫu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.EDMT2032_NannyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo mẫu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.EDMT2032_NannyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật phân công giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.ApprovalID01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.ApprovalID02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.ApprovalID03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 4';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.ApprovalID04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 5';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.ApprovalID05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.ApprovalName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.ApprovalName02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.ApprovalName03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 4';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.ApprovalName04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 5';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.ApprovalName05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.SchoolYearID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.DateFrom.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2031.DateTo.CB', @FormID, @LanguageValue, @Language;