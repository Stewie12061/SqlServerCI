--Created : 17/08/2023 Phương Thảo : Ngôn ngữ màn hình cập nhật Hồ sơ bảo hiểm (HRMF2191)
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
SET @FormID = 'HRMF2191';

--Title
SET @LanguageValue  = N'Cập nhật hồ sơ bảo hiểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.Title',  @FormID, @LanguageValue, @Language;

---Ngôn ngữ tab
--SET @LanguageValue  = N'Thông tin chung';
--EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.ThongTinChung',  @FormID, @LanguageValue, @Language;

--SET @LanguageValue  = N'Công việc';
--EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.CongViec',  @FormID, @LanguageValue, @Language;

--SET @LanguageValue  = N'Lương và phụ cấp';
--EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.LuongVaPhuCap',  @FormID, @LanguageValue, @Language;

--SET @LanguageValue  = N'Thông tin khác 1';
--EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.ThongTinKhac1',  @FormID, @LanguageValue, @Language;

--SET @LanguageValue  = N'Thông tin khác 2';
--EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.ThongTinKhac2',  @FormID, @LanguageValue, @Language;

---ngôn ngữ combobox Begin ADD

SET @LanguageValue  = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.TeamID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.TeamName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bệnh viện';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.HospitalID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bệnh viện';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.HospitalName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.DutyName.CB',  @FormID, @LanguageValue, @Language;


---Ngôn ngữ combobox End ADD



---Ngôn ngữ các trường HRMT2190 Begin ADD

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.InsurFileID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.TeamID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.TeamName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.DutyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.DutyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số sổ BHXH';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.SNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đóng BHXH ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.SBeginDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số sổ BHYT';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.HNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.HFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.HToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu KCB';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.CNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Có giá trị từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.CFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.CToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Bệnh viện KCB';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.HospitalID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bệnh viện KCB';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.HospitalName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương cơ bản';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.Basesalary' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương BHXH';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.InsuranceSalary' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương phụ cấp 01';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.Salary01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương phụ cấp 02';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.Salary02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương phụ cấp 03';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.Salary03' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tính BHXH';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.IsS' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tính BHYT';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.IsH' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tính KPCĐ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.IsT' , @FormID, @LanguageValue, @Language;

---Ngôn ngữ fieldset
SET @LanguageValue = N'Thông tin nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.InformationEmployee' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin lương';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.InformationSalary' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin BHXH';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.InformationBHXH' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin BHYT';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.InformationBHYT' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tùy chọn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2191.InformationOption' , @FormID, @LanguageValue, @Language;



