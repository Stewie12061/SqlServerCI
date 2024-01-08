-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2003- OO
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
SET @Language = 'en-US' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF2003';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Staff is name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 01';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 02';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 03';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 04';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 05';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 06';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 07';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 08';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 09';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'10th';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 11';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'12nd';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'13th';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 14';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'15th';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The 16th';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 17';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'18th';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 19';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 20';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 21';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D21', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'22th';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D22', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 23';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D23', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'24th';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D24', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'25th';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D25', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'26th';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D26', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'27th';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D27', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'28th';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D28', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'29th';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D29', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'30th';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D30', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day 31';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.D31', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2003.APKMaster', @FormID, @LanguageValue, @Language;

