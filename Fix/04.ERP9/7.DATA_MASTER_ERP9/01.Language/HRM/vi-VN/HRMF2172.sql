-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2172- HRM
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
SET @FormID = 'HRMF2172';

SET @LanguageValue = N'Thông tin';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.DetailMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.DSDCTM', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Điều chuyển tạm thời';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.APK', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.EmployeeID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.EmployeeName', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ngày lập';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.WorkToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.WorkFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.SectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.SectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.SubsectionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.SubsectionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.StatusID', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xóa';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.DeleteFlag', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh mục điều chuyển tạm thời';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.Title', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Ghi chú người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.ApprovePersonNote', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2172.ApprovePersonName', @FormID, @LanguageValue, @Language;







