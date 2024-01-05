
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2058- OO
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
SET @FormID = 'OOF2058';
------- phần master
SET @LanguageValue = N'Điều chuyển tạm thời';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn điều chuyển';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.SectionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.SubsectionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.ProcessID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.ApprovePersonID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái người duyệt ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.ApprovePersonStatus' , @FormID, @LanguageValue, @Language;

------- phần detail
SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ca làm việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.ShiftID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.ChangeFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.ChangeToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.FullName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Khối';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.SectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.SubsectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.ProcessName' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Trạng thái';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2058.StatusOOT9001' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Trạng thái';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2058.Status' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Mã ca';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.ShiftID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên ca';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.ShiftName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.Department',  @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã khối';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.DepartmentID.CB', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên khối';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.DepartmentName.CB', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.SectionID.CB', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.SectionName.CB', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.SubsectionID.CB', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tên bộ phận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.SubsectionName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.ApproveID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2058.FullName.CB', @FormID, @LanguageValue, @Language;