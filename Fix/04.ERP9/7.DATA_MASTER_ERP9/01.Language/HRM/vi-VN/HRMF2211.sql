-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2211- OO
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
SET @FormID = 'HRMF2211'
---title
SET @LanguageValue  = N'Cập nhật hồ sơ nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Title',  @FormID, @LanguageValue, @Language;

--các tab
SET @LanguageValue  = N'Thông tin cá nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TabHRMT2211',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin nghề nghiệp'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TabHRMT2212',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin học tâp'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TabHRMT2213',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin xã hội'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TabHRMT2214',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu - Chỉ số'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TabHRMT2215',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin DISC'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TabHRMT2216',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin lưu trú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TabHRMT2217',  @FormID, @LanguageValue, @Language;

--- fieldset start

--- fieldset tab01
SET @LanguageValue  = N'Cá nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Persional',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Liên lạc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Contract',  @FormID, @LanguageValue, @Language;

--- fieldset tab02
SET @LanguageValue  = N'Tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Recruitment',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hồ sơ nghề nghiệp'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.CareerProfile',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức lương'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Wage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trực thuộc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Belong',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản kết chuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Account',  @FormID, @LanguageValue, @Language;


--filedset tab03

SET @LanguageValue  = N'Trình độ ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.EnglishSkill',  @FormID, @LanguageValue, @Language;

--filedset tab04

SET @LanguageValue  = N'Bảo hiểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Insurance',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản cá nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.PersonalAccount',  @FormID, @LanguageValue, @Language;

--filedset tab05

SET @LanguageValue  = N'Chỉ tiêu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Targets',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TargetAmount',  @FormID, @LanguageValue, @Language;

--- fieldset end

----Combobox
SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.EthnicID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dân tộc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.EthnicName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.ReligionID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tôn giáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.ReligionName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.CityID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉnh/TP'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.CityName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.ContentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.ContentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.CountryID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quốc gia'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.CountryName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức làm việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.WorkType.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại đánh giá'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.EvaluationKitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại đánh giá'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.EvaluationKitName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.InformaticsLevelID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ tin học'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.InformaticsLevelName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.LanguageLevelID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.LanguageLevelName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí ứng tuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.EducationLevelID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ học vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.EducationLevelName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng hôn nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.IsSingle.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.LanguageID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.LanguageName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.PoliticsID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ chính trị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.PoliticsName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.ResourceID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.ResourceName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nói'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.SpeakingName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Value.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.HospitalID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bệnh viện'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.HospitalName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.BankID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.BankName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TitleID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên chức danh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TitleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TargetID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TargetName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.AbsentTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.EmployeeStatus.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.EmployeeStatusName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.EmployeeStatus.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.EmployeeStatusName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.DivisionID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.DivisionName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TeamID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tổ nhóm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TeamName.CB',  @FormID, @LanguageValue, @Language;

---end combobox

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.FirstName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đệm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.MiddleName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Họ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.LastName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ảnh nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.ImageID',  @FormID, @LanguageValue, @Language;

---tab01

--tab01 bên trái

SET @LanguageValue  = N'Ngày sinh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Birthday',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi sinh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.BornPlace',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quốc tịch'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.CountryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dân tộc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.EthnicID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dân tộc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.EthnicName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tôn giáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.ReligionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tôn giáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.ReligionName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên quán'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.NativeCountry',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.IdentifyCardNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi cấp CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.IdentifyPlace',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉnh/TP cấp CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.IdentifyCityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cấp CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.IdentifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉnh/TP cấp CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.IdentifyCity',  @FormID, @LanguageValue, @Language;

--tab01 bên phải
SET @LanguageValue  = N'Giới tính'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.IsMale',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng gia đình'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.IsSingle',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độc thân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.IsSingle1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đã lập gia đình'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.IsSingle2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng sức khỏe'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.HealthStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiều cao'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Height',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cân nặng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Weight',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hộ chiếu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.PassportNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cấp hộ chiếu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.PassportDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn hộ chiếu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.PassportEnd',  @FormID, @LanguageValue, @Language;
--tab01 Liên Lạc
SET @LanguageValue  = N'Địa chỉ thường trú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.PermanentAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ tạm trú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TemporaryAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số điện thoại'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.HomePhone',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Email',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Fax'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.HomeFax',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Notes',  @FormID, @LanguageValue, @Language;

---end ngôn ngữ tab 01
--tab02

SET @LanguageValue  = N'Tình trạng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.EmployeeStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.RecruitPlace',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.RecruitDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kinh nghiệm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Experience',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày vào công ty'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.CompanyDate1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày vào làm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.WorkDate1',  @FormID, @LanguageValue, @Language;

--SET @LanguageValue  = N'Thử việc từ'
--EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.FromApprenticeTime',  @FormID, @LanguageValue, @Language;

--SET @LanguageValue  = N'Thử việc đến'
--EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.ToApprenticeTime',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người giới thiệu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.MidEmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức danh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TitleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng thuế'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TaxObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng nghỉ phép'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.LoaCondID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quản lí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.IsManager',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương khoán'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.IsJobWage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương sản phẩm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.IsPiecework',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bậc lương'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.SalaryLevel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày nâng bậc lương'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.SalaryLevelDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số thâm niên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TimeCoefficient',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.DutyCoefficient',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số lương'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.SalaryCoefficient',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày nghỉ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.LeaveDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.LeaveToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lý do nghỉ việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.AbsentReason',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.StatusNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương đề nghị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.SuggestSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương cơ bản'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.BaseSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương BHXH'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.InsuranceSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương 1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Salary01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương 2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Salary02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lương 3'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Salary03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.DivisionID2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổ nhóm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TeamID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Section',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công đoạn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Process',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản phải trả cho nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.PayableAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản chi phí lương'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.ExpenseAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản thuế thu nhập cá nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.PerInTaxID',  @FormID, @LanguageValue, @Language;



--endtab02

---tab03
SET @LanguageValue  = N'Trình độ học vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.EducationLevelID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ chính trị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.PoliticsID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ chuyên môn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.SpecialID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Language1ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Language2ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 3'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Language3ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.LanguageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ 1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.LanguageLevel1ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ 2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.LanguageLevel2ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ 3'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.LanguageLevel3ID',  @FormID, @LanguageValue, @Language;
-- lưới tab03

SET @LanguageValue  = N'Mã trường'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.SchoolID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên trường'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.SchoolName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngành học'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.MajorID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hình đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ tháng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.FromMonth',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ năm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.FromYear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến tháng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.ToMonth',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến năm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.ToYear',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Notes',  @FormID, @LanguageValue, @Language;

---endtab03

--Tab04

SET @LanguageValue  = N'Số sổ BHXH'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.SoInsuranceNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đóng BHXH'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.SoInsurBeginDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số phiếu KCB'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.HeInsuranceNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.HFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.HToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bệnh viện KCB'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.HospitalID',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.BankID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ ngân hàng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.BankAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tài khoản'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.BankAccountNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã số thuế TNCN'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.PersonalTaxID',  @FormID, @LanguageValue, @Language;

--endtab04
---Tab05

SET @LanguageValue  = N'Chỉ tiêu 01'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Target01ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu 02'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Target02ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu 03'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Target03ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu 04'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Target04ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu 05'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Target05ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu 06'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Target06ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu 07'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Target07ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu 08'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Target08ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu 09'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Target09ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ tiêu 10'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Target10ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 01'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TargetAmount01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 02'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TargetAmount02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 03'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TargetAmount03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 04'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TargetAmount04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 05'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TargetAmount05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 06'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TargetAmount06',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 07'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TargetAmount07',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 08'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TargetAmount08',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 09'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TargetAmount09',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số 10'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.TargetAmount10',  @FormID, @LanguageValue, @Language;
--Lưới tab05

SET @LanguageValue  = N'STT'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.STT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.Caption',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2211.ValueOfConstant',  @FormID, @LanguageValue, @Language;


---endtab05















