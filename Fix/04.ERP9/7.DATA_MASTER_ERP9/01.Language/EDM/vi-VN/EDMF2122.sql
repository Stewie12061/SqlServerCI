-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ 
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
SET @FormID = 'EDMF2122';

SET @LanguageValue = N'Xem thông tin chương trình học tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết chương trình';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.Detail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.Attach.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.Lich_su', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chương trình';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.ProgrammonthID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chương trình';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.MonthID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.MonthName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.SchoolName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủ đề';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.Topic', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hoạt động';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.ActivityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Môn học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.SubjectName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm học';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.TermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.ClassID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2122.ClassName', @FormID, @LanguageValue, @Language;

