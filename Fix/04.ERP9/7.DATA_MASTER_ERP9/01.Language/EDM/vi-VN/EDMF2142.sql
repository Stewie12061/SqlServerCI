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
SET @FormID = 'EDMF2142';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.DivisionID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Số điều chuyển';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.TranferStudentNo', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ngày điều chuyển';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.DateTranfer', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.ProponentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.ProponentName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.Description', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Lý do';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.Reason', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người duyệt 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.Approver1ID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người duyệt 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.Approver2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.Approver1Name', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người duyệt 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.Approver2Name', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người duyệt 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.Approver3ID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người duyệt 4';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.Approver4ID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người duyệt 5';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.Approver5ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.SchoolNameFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xếp lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.ArrangeClassIDFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xếp lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.ArrangeClassIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu lực từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.FromEffectiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu lực đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.ToEffectiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.SchoolIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.GradeIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.ClassIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.SchoolNameTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.GradeNameTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.ClassNameTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin điều chuyển học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin điều chuyển học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.Lich_su', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường chuyển đi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.SchoolFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường chuyển đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.SchoolTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.Attach.GR' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2142.Notes.GR' , @FormID, @LanguageValue, @Language;