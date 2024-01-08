------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2003 - CRM
-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'en-US';
SET @ModuleID = 'HRM';
SET @FormID = 'OOF2003';

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Update Staff On Shift';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.Title' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'EmployeeID';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee Name';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.EmployeeName' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'ShiftID';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.ShiftID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Shift Name';
 EXEC ERP9AddLanguage @ModuleID,'OOF2003.ShiftName' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Note';
 EXEC ERP9AddLanguage @ModuleID,'OOF2003.Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Date 01';
 EXEC ERP9AddLanguage @ModuleID,'OOF2003.D01' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 02';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D02' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 03';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D03' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 04';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D04' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 05';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D05' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date 06';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D06' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 07';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D07' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 08';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D08' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 09';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D09' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 10';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D10' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'Date 11';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D11' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 12';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D12' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 13';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D13' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 14';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D14' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 15';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D15' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date 16';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D16' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 17';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D17' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 18';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D18' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 19';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D19' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 20';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D20' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Date 21';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D21' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 22';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D22' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 23';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D23' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 24';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D24' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 25';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D25' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date 26';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D26' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 27';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D27' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 28';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D28' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 29';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D29' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Date 30';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D30' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = N'Date 31';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D31' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.EmployeeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.EmployeeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.ShiftID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.ShiftName.CB' , @FormID, @LanguageValue, @Language;