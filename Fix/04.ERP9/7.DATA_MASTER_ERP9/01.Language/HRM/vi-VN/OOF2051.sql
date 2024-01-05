
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2051- OO
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
SET @FormID = 'OOF2051';

SET @LanguageValue = N'Duyệt bảng phân ca';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bảng phân ca';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.SectionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.SubsectionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.ProcessID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.ApprovePersonID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.FullName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Phòng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.SectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.SubsectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.ProcessName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = 'Mã nhân viên';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = 'Tên nhân viên';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.EmployeeName' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = 'Mã ca';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.ShiftID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = 'Tên ca';
 EXEC ERP9AddLanguage @ModuleID,'OOF2051.ShiftName' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = 'Ghi chú';
 EXEC ERP9AddLanguage @ModuleID,'OOF2051.Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = 'Ngày 01';
 EXEC ERP9AddLanguage @ModuleID,'OOF2051.D01' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 02';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D02' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 03';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D03' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 04';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D04' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 05';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D05' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = 'Ngày 06';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D06' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 07';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D07' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 08';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D08' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 09';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D09' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 10';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D10' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = 'Ngày 11';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D11' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 12';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D12' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 13';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D13' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 14';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D14' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 15';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D15' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = 'Ngày 16';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D16' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 17';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D17' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 18';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D18' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 19';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D19' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 20';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D20' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = 'Ngày 21';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D21' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 22';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D22' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 23';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D23' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 24';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D24' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 25';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D25' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = 'Ngày 26';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D26' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 27';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D27' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 28';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D28' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 29';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D29' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = 'Ngày 30';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D30' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = 'Ngày 31';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D31' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Trạng thái';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.StatusOOT9001' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Trạng thái';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.Department',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.SectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.SubsectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.ProcessID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.SectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên ban';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.SubsectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.ProcessName.CB' , @FormID, @LanguageValue, @Language;