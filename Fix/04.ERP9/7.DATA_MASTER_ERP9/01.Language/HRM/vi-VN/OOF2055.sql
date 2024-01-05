
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2055- OO
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
SET @FormID = 'OOF2055';
------- phần master
SET @LanguageValue = N'Duyệt đơn xin bổ sung quẹt thẻ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn xin phép';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khối';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.SectionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.SubsectionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.ProcessID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.ApprovePersonID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái người duyệt ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.ApprovePersonStatus' , @FormID, @LanguageValue, @Language;

------- phần detail
SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ tên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lý do';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.Reason' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.EditType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.EditTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian bổ sung/hủy quẹt thẻ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.Date' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.FullName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Khối';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Phòng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.SectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.SubsectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.ProcessName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vào/ra';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.InOutID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên vào/ra';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.InOutName' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = 'Trạng thái';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2055.Status' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Trạng thái';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2055.StatusOOT9001' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Trạng thái';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2055.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.Department',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.SectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.SubsectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.ProcessID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.SectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.SubsectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2055.ProcessName.CB' , @FormID, @LanguageValue, @Language;