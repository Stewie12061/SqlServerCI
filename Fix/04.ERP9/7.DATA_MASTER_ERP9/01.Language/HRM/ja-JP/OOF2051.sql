
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
SET @Language = 'ja-JP' 
SET @ModuleID = 'HRM';
SET @FormID = 'OOF2051';

SET @LanguageValue = N'シフト表の承認';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'シフト表コード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解釈';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'課';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.SectionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'係り';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.SubsectionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.ProcessID' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'承認者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.ApprovePersonID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'社員コード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者の名前';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.FullName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'課名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.SectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'係り名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.SubsectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.ProcessName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = '社員コード';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = '社員の名前';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.EmployeeName' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = 'スフとコード';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.ShiftID' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = 'シフト名';
 EXEC ERP9AddLanguage @ModuleID,'OOF2051.ShiftName' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = '備考';
 EXEC ERP9AddLanguage @ModuleID,'OOF2051.Note' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = '１日';
 EXEC ERP9AddLanguage @ModuleID,'OOF2051.D01' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '２日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D02' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '３日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D03' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '４日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D04' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '５日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D05' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = '６日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D06' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '７日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D07' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '８日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D08' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '９日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D09' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '１０日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D10' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = '１１日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D11' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '１２日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D12' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '１３日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D13' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '１４日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D14' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '１５日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D15' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = '１６日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D16' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '１７日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D17' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '１８日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D18' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '１９日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D19' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '２０日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D20' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = '２１日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D21' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '２２日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D22' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '２３日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D23' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '２４日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D24' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '２５日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D25' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = '２６日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D26' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '２７日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D27' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '２８日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D28' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '２９日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D29' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = '３０日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D30' , @FormID, @LanguageValue, @Language;
 
  SET @LanguageValue = '３１日';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.D31' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'状態';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.StatusOOT9001' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'状態';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2051.Status' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'部コード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'課のコード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.SectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'係りコード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.SubsectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程コード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.ProcessID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'課名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.SectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'係り名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.SubsectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2051.ProcessName.CB' , @FormID, @LanguageValue, @Language;