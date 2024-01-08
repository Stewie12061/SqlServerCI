
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2052- OO
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
SET @FormID = 'OOF2052';
------- phần master
SET @LanguageValue = N'Duyệt đơn xin phép nghỉ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn xin phép nghỉ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.Description' , @FormID, @LanguageValue, @Language;

--SET @LanguageValue = N'Khối';
--EXEC ERP9AddLanguage @ModuleID, 'OOF2052.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.SectionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.SubsectionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.ProcessID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.ApprovePersonID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.ApprovePersonStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.NoteOOT9001' , @FormID, @LanguageValue, @Language;


------- phần detail
SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.EmployeeID' , @FormID, @LanguageValue, @Language;

--SET @LanguageValue = N'Họ tên';
--EXEC ERP9AddLanguage @ModuleID, 'OOF2052.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lý do nghỉ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.Reason' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phép';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.AbsentTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại phép';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.AbsentTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghỉ từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.LeaveFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.LeaveToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng cộng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.TotalTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.Note' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Thời gian phép (Giờ)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.TimeAllowance' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian bù (Giờ) ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.OffsetTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.FullName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Khối';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Phòng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.SectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.SubsectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.ProcessName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.StatusOOT9001' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.Status' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Ca làm việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.OldShiftID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ca thay đổi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.ShiftID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tồn phép năm (ngày)';
EXEC ERP9AddLanguage @ModuleID,  'OOF2052.DaysRemained' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Tồn phép bù (ngày)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.OTDaysRemained' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Là ngày kế';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.IsNextDay' , @FormID, @LanguageValue, @Language;     

SET @LanguageValue = N'Ca thay đổi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.ShiftID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tồn phép năm (ngày)';
EXEC ERP9AddLanguage @ModuleID,  'OOF2052.DaysRemained' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Tồn phép bù (ngày)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.OTDaysRemained' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Là ngày kế';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.IsNextDay' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.Department',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.SectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.SubsectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.ProcessID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.SectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.SubsectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.ProcessName.CB' , @FormID, @LanguageValue, @Language;