-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ EDMF2082- EDM
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
SET @FormID = 'EDMF2082';


SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.Attach.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nghỉ học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.LeaveDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.DecisiveDateFromTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.VoucherLeaveSchool', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.DecisiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.ProponentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.ProponentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.SchoolID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nghỉ học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.LeaveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lý do';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.Reason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.DeciderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.DeciderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nghỉ học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.lblLeaveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày quyết định';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.lblDecisiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin quyết định nghỉ học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin quyết định nghỉ học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.Lich_su', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin quyết toán';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.InfoSettle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu phí';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.ReceiptTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.Notes.GR' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.DateOfBirth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ra trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.IsGraduate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.SchoolYearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.GradeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2082.Detail', @FormID, @LanguageValue, @Language;
