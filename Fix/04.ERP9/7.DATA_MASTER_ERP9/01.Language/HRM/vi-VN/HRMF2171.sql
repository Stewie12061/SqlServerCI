-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2171- HRM
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
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2171';


SET @LanguageValue = N'Cập nhập điều Chuyển tạm thời';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.APK', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.VoucherNo', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.OrderDate', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.WorkToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.WorkFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng Thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.Status', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguời tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.LastModifyUserID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã khối';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.DepartmentID.CB', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên khối';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.DepartmentName.CB', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.SectionID.CB', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.SectionName.CB', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.SubsectionID.CB', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.SubsectionName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2031.ApprovePersonID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.ApproveID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.FullName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận đến:';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2171.LableName', @FormID, @LanguageValue, @Language;





