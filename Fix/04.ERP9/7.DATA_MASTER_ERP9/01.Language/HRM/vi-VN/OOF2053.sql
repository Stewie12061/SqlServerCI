
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2053- OO
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
SET @FormID = 'OOF2053';
------- phần master
SET @LanguageValue = N'Duyệt đơn xin phép ra ngoài';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn xin phép ra ngoài';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.SectionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.SubsectionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.ProcessID' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Yêu cầu xe';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.AskForVehicle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiều dùng xe';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.UseVehicleName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ăn trưa tại nhà máy';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.HaveLunch' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.ApprovePersonID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái người duyệt ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.ApprovePersonStatus' , @FormID, @LanguageValue, @Language;

------- phần detail
SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lý do';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.Reason' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.Place' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian đi dự kiến';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.GoFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đi thẳng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.GoStraight' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian về dự kiến';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.GoToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Về thẳng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.ComeStraight' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.FullName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Khối';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Phòng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.SectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.SubsectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.ProcessName' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Trạng thái';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2053.StatusOOT9001' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Trạng thái';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2053.Status' , @FormID, @LanguageValue, @Language;

