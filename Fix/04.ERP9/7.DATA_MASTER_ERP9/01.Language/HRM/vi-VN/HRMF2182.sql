--Created : 08/08/2023 Phương Thảo : Ngôn ngữ màn hình chi tiết Hợp đồng lao đồng (HRMF2182)
-----------------------------------------------------------------------------------------------------
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
SET @FormID = 'HRMF2182';

SET @LanguageValue  = N'Chi tiết hợp đồng lao động'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.ThongTinChung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.CongViec',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương và phụ cấp';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.LuongVaPhuCap',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin khác 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.ThongTinKhac1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin khác 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.ThongTinKhac2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Attach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.TeamID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.TeamName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.ContractNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày ký';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.SignDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ lục hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.SubContract' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.ContractTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.ContractTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người ký';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.SignPersonName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.StatusRecieveName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.DutyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.DutyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc phải làm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Works' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Làm việc từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.WorkDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.WorkEndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương cơ bản';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.BaseSalary' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương thử việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.ProbationSalary' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary03' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 4';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary04' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 5';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary05' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 6';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary06' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 7';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary07' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 8';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary08' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 9';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary09' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 10';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Salary10' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp gồm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Allowance' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm làm việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.WorkAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian làm việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.WorkTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công cụ cấp phát';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.IssueTool' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương tiện đi lại';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Conveyance' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức trả lương';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.PayForm' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Được trả lương hàng tháng ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.PayDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền thưởng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Bonus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chế độ tăng lương';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.SalaryRegulation' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chế độ tăng lương';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.SalaryRegulationName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chế độ nghỉ ngơi';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.RestRegulation' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Được trang bị bảo hộ tai nạn lao động gồm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.SafetyEquiment' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'BHXH và BHYT';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.SI' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chế độ đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.TrainingRegulation' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Những thỏa thuận khác';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.OtherAgreement' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bồi thường vi phạm khác';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Compensation' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2182.Notes' , @FormID, @LanguageValue, @Language;



