-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2032- EDM
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
SET @FormID = 'EDMF2032';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.DivisionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phân công';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.SchoolYearName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.TeacherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.TeacherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.EDMT2032_TeacherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.EDMT2032_TeacherName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo mẫu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.NannyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo mẫu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.NannyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo mẫu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.EDMT2032_NannyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bảo mẫu';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.EDMT2032_NannyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem phân công giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin phân công giáo viên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.Lich_su', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.ApprovalID01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.ApprovalID02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.ApprovalID03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 4';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.ApprovalID04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 5';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.ApprovalID05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.ApprovalName01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.ApprovalName02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.ApprovalName03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 4';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.ApprovalName04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 5';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.ApprovalName05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.Attach.GR' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2032.Notes.GR' , @FormID, @LanguageValue, @Language;