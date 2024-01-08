--Created : 08/08/2023 Phương Thảo : Ngôn ngữ màn hình cập nhật Hợp đồng lao đồng (HRMF2181)
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
SET @FormID = 'HRMF2181';

--Title
SET @LanguageValue  = N'Cập nhật hợp đồng lao động'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Title',  @FormID, @LanguageValue, @Language;

---Ngôn ngữ tab
SET @LanguageValue  = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ThongTinChung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.CongViec',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương và phụ cấp';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.LuongVaPhuCap',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin khác 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ThongTinKhac1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin khác 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ThongTinKhac2',  @FormID, @LanguageValue, @Language;

---ngôn ngữ combobox Begin ADD

SET @LanguageValue  = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.TeamID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.TeamName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ContractTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ContractTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.StatusRecieve.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.StatusRecieveName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SalaryRegulation.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chế độ tăng lương';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SalaryRegulationName.CB',  @FormID, @LanguageValue, @Language;

---Ngôn ngữ combobox End ADD





SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.TeamID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ContractNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày ký';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SignDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ lục hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SubContract' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ContractTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ContractTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người ký';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SignPersonName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.StatusRecieve' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.StatusRecieveName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.DutyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.DutyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc phải làm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Works' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Làm việc từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.WorkDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.WorkEndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương cơ bản';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.BaseSalary' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương thử việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.ProbationSalary' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary03' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 4';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary04' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 5';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary05' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 6';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary06' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 7';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary07' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 8';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary08' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 9';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary09' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp 10';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Salary10' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ cấp gồm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Allowance' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm làm việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.WorkAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian làm việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.WorkTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công cụ cấp phát';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.IssueTool' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương tiện đi lại';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Conveyance' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức trả lương';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.PayForm' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Được trả lương hàng tháng ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.PayDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền thưởng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Bonus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chế độ tăng lương';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SalaryRegulation' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chế độ nghỉ ngơi';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.RestRegulation' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Được trang bị bảo hộ tai nạn lao động gồm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SafetyEquiment' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'BHXH và BHYT';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.SI' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chế độ đào tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.TrainingRegulation' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Những thỏa thuận khác';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.OtherAgreement' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bồi thường vi phạm khác';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Compensation' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2181.Notes' , @FormID, @LanguageValue, @Language;



