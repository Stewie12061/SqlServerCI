-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2212- OO
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


SET @Language = 'vi-VN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2212'
---title
SET @LanguageValue  = N'Chi tiết hồ sơ nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Title',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Thông tin cá nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.GroupThongTinCaNhan',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin nghề nghiệp'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.GroupThongTinNgheNghiep',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin xã hội'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.GroupThongTinXaHoi',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu - Chỉ số'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.GroupChiTieuChiSo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.GroupDinhKem',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.GroupGhiChu',  @FormID, @LanguageValue, @Language;

--- fieldset start

--- fieldset tab01
SET @LanguageValue  = N'Cá nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Persional',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Liên lạc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Contract',  @FormID, @LanguageValue, @Language;

--- fieldset tab02
SET @LanguageValue  = N'Tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Recruitment',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hồ sơ nghề nghiệp'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.CareerProfile',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức lương'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Wage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trực thuộc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Belong',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản kết chuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Account',  @FormID, @LanguageValue, @Language;


--filedset tab03

SET @LanguageValue  = N'Trình độ ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.EnglishSkill',  @FormID, @LanguageValue, @Language;

--filedset tab04

SET @LanguageValue  = N'Bảo hiểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Insurance',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản cá nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.PersonalAccount',  @FormID, @LanguageValue, @Language;

--filedset tab05

SET @LanguageValue  = N'Chỉ tiêu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Targets',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.TargetAmount',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.FirstName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đệm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.MiddleName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Họ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.LastName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ảnh nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.ImageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ảnh nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212ImageID',  @FormID, @LanguageValue, @Language;

---tab01

--tab01 bên trái

SET @LanguageValue  = N'Ngày sinh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Birthday',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi sinh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.BornPlace',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quốc tịch'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.CountryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quốc tịch'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.CountryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dân tộc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.EthnicID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dân tộc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.EthnicName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tôn giáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.ReligionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tôn giáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.ReligionName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên quán'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.NativeCountry',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.IdentifyCardNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi cấp CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.IdentifyPlace',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉnh/TP cấp CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.IdentifyCityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cấp CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.IdentifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉnh/TP cấp CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.IdentifyCity',  @FormID, @LanguageValue, @Language;

--tab01 bên phải
SET @LanguageValue  = N'Giới tính'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.IsMale',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giới tính'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.IsMaleName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng gia đình'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.IsSingle',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độc thân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.IsSingle1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đã lập gia đình'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.IsSingle2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng sức khỏe'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.HealthStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiều cao'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Height',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cân nặng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Weight',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hộ chiếu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.PassportNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cấp hộ chiếu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.PassportDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn hộ chiếu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.PassportEnd',  @FormID, @LanguageValue, @Language;
--tab01 Liên Lạc
SET @LanguageValue  = N'Địa chỉ thường trú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.PermanentAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ tạm trú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.TemporaryAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số điện thoại'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.HomePhone',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Email',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Fax'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.HomeFax',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Notes',  @FormID, @LanguageValue, @Language;

---end ngôn ngữ tab 01
--tab02

SET @LanguageValue  = N'Tình trạng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.EmployeeStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.EmployeeStatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.RecruitPlace',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.RecruitDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kinh nghiệm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Experience',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày vào công ty'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.CompanyDate1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày vào làm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.WorkDate1',  @FormID, @LanguageValue, @Language;

--SET @LanguageValue  = N'Thử việc từ'
--EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.FromApprenticeTime',  @FormID, @LanguageValue, @Language;

--SET @LanguageValue  = N'Thử việc đến'
--EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.ToApprenticeTime',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người giới thiệu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.MidEmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.TitleName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng thuế'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.TaxObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng nghỉ phép'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.LoaCondID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quản lí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.IsManager',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương khoán'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.IsJobWage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương sản phẩm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.IsPiecework',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bậc lương'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.SalaryLevel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày nâng bậc lương'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.SalaryLevelDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số thâm niên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.TimeCoefficient',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.DutyCoefficient',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số lương'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.SalaryCoefficient',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày nghỉ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.LeaveDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.LeaveToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lý do nghỉ việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.AbsentReason',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lý do nghỉ việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.AbsentReasonName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.StatusNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương đề nghị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.SuggestSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương cơ bản'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.BaseSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương BHXH'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.InsuranceSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương 1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Salary01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương 2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Salary02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương 3'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Salary03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.DivisionID2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổ nhóm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.TeamID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Section',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công đoạn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Process',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản phải trả cho nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.PayableAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản chi phí lương'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.ExpenseAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản thuế thu nhập cá nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.PerInTaxID',  @FormID, @LanguageValue, @Language;



--endtab02

---tab03
SET @LanguageValue  = N'Trình độ học vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.EducationLevelID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ chính trị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.PoliticsID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ chuyên môn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.SpecialID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Language1ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Language2ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 3'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Language3ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.LanguageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ 1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.LanguageLevel1ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ 2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.LanguageLevel2ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ 3'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.LanguageLevel3ID',  @FormID, @LanguageValue, @Language;
-- lưới tab03

SET @LanguageValue  = N'Mã trường'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.SchoolID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên trường'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.SchoolName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngành học'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.MajorID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hình đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.TypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ tháng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.FromMonth',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ năm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.FromYear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến tháng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.ToMonth',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến năm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.ToYear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Notes',  @FormID, @LanguageValue, @Language;

---endtab03

--Tab04

SET @LanguageValue  = N'Số sổ BHXH'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.SoInsuranceNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đóng BHXH'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.SoInsurBeginDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số phiếu KCB'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.HeInsuranceNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.HFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.HToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bệnh viện KCB'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.HospitalID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bệnh viện KCB'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.HospitalName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.BankID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.BankName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.BankAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tài khoản'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.BankAccountNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã số thuế TNCN'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.PersonalTaxID',  @FormID, @LanguageValue, @Language;

--endtab04
---Tab05

SET @LanguageValue  = N'Chỉ tiêu 01'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Target01ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu 02'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Target02ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu 03'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Target03ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu 04'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Target04ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu 05'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Target05ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu 06'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Target06ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu 07'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Target07ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu 08'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Target08ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu 09'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Target09ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu 10'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Target10ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 01'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.TargetAmount01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 02'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.TargetAmount02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 03'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.TargetAmount03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 04'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.TargetAmount04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 05'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.TargetAmount05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 06'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.TargetAmount06',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 07'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.TargetAmount07',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 08'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.TargetAmount08',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 09'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.TargetAmount09',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 10'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.TargetAmount10',  @FormID, @LanguageValue, @Language;
--Lưới tab05

SET @LanguageValue  = N'STT'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.STT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.Caption',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.ValueOfConstant',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người chỉnh sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày chỉnh sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2212.LastModifyDate',  @FormID, @LanguageValue, @Language;
