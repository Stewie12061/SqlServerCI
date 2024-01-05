--Created : 17/08/2023 Phương Thảo : Ngôn ngữ màn hình danh mục Hờ sơ bảo hiểm (HRMF2190)
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
SET @FormID = 'HRMF2190';

--Title
SET @LanguageValue  = N'Danh mục hồ sơ bảo hiểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.Title',  @FormID, @LanguageValue, @Language;

---Ngôn ngữ combobox Begin ADD

SET @LanguageValue  = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.TeamID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.TeamName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bệnh viện';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.HospitalID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên bệnh viện';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.HospitalName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.DutyName.CB',  @FormID, @LanguageValue, @Language;

---Ngôn ngữ combobox End ADD

---Ngôn ngữ các trường HRMT2190 Begin ADD

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.InsurFileID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.TeamID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.TeamName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.DutyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.DutyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số sổ BHXH';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.SNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đóng BHXH';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.SBeginDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số sổ BHYT';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.HNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.HFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.HToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu khám chữa bệnh';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.CNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Có giá trị từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.CFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.CToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Bệnh viện KCB';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.HospitalID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bệnh viện KCB';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.HospitalName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương cơ bản';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.Basesalary' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương BHXH';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.InsuranceSalary' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương 01';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.Salary01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương 02';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.Salary02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương 03';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.Salary03' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tính BHXH';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.IsS' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tính BHYT';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.IsH' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tính KPCĐ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2190.IsT' , @FormID, @LanguageValue, @Language;

