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
SET @FormID = 'EDMF2141';

SET @LanguageValue = N'Số điều chuyển';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.TranferStudentNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày điều chuyển';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.DateTranfer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.SchoolNameFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.GradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.ClassName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.StudentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.StudentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu lực từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.FromEffectiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu lực đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.ToEffectiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.ProponentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đề nghị';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.ProponentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.SchoolIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.GradeIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lớp';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.ClassIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lý do';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.Reason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 1';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.Approver1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 2';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.Approver2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 3';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.Approver3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 4';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.Approver4ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt 5';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.Approver5ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường chuyển đi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.SchoolFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường chuyển đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.SchoolTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật điều chuyển học sinh';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.CreateUserID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.CreateUserName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.GradeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.GradeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.ClassID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.ClassName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.EmployeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.EmployeeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xếp lớp đi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.ArrangeClassNameFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xếp lớp đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.ArrangeClassNameTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xếp lớp đi';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.ArrangeClassIDFrom', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xếp lớp đến';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.ArrangeClassIDTo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.DivisionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trường';
EXEC ERP9AddLanguage @ModuleID, 'EDMF2141.DivisionName.CB', @FormID, @LanguageValue, @Language;