
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
SET @Language = 'ja-JP' 
SET @ModuleID = 'HRM';
SET @FormID = 'OOF2053';
------- phần master
SET @LanguageValue = N'外出申請届けの承認';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外出申請届けコード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解釈';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'課';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.SectionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'係り';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.SubsectionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.ProcessID' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Yêu cầu xe';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.AskForVehicle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'車使用';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.UseVehicleName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'会社で昼ごはん食べます';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.HaveLunch' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.ApprovePersonID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者の状態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.ApprovePersonStatus' , @FormID, @LanguageValue, @Language;

------- phần detail
SET @LanguageValue = N'社員コード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'名前';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'理由';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.Reason' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'住所';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.Place' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外出予定時間';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.GoFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'真っ直ぐ行く';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.GoStraight' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'帰り予定時間';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.GoToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'会社戻らなく帰る';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.ComeStraight' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者の名前';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.FullName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'課名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.SectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'係り名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.SubsectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2053.ProcessName' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'状態';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2053.StatusOOT9001' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'状態';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2053.Status' , @FormID, @LanguageValue, @Language;

