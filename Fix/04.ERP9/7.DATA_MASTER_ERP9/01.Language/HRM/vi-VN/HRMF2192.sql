--Created : 17/08/2023 Phương Thảo : Ngôn ngữ màn hình chi tiết Hồ sơ bảo hiểm (HRMF2192)
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
SET @FormID = 'HRMF2192';

--Title
SET @LanguageValue  = N'Chi tiết hồ sơ bảo hiểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.Title',  @FormID, @LanguageValue, @Language;

--Ngôn ngữ các Group Begin ADD
SET @LanguageValue  = N'Thông tin hồ sơ bảo hiểm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.ThongTinHoSoBaoHiem',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.Attach',  @FormID, @LanguageValue, @Language;
--Ngôn ngữ các Group End ADD

---Ngôn ngữ group hệ thống
SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.CreateDate',  @FormID, @LanguageValue, @Language;
---Ngôn ngữ group hệ thống

---Ngôn ngữ các trường HRMT2190 Begin ADD

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.InsurFileID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.TeamID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.TeamName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.DutyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.DutyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số sổ BHXH';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.SNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đóng BHXH';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.SBeginDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số sổ BHYT';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.HNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.HFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.HToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu khám chữa bệnh';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.CNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Có giá trị từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.CFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.CToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Bệnh viện KCB';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.HospitalID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bệnh viện KCB';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.HospitalName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương cơ bản';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.Basesalary' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương BHXH';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.InsuranceSalary' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương 01';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.Salary01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương 02';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.Salary02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lương 03';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.Salary03' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tính BHXH';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.IsS' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tính BHYT';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.IsH' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tính KPCĐ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.IsT' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2192.Description' , @FormID, @LanguageValue, @Language;