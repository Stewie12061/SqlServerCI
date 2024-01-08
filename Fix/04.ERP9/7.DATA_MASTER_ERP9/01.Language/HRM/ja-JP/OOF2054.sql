
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2054- OO
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
SET @FormID = 'OOF2054';
------- phần master
SET @LanguageValue = N'残業申請届けの承認';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'休暇申請届けコード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解釈';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'課';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.SectionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'係り';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.SubsectionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.ProcessID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'残業種類';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.WorkTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.ApprovePersonID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者の状態 ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.ApprovePersonStatus' , @FormID, @LanguageValue, @Language;

------- phần detail
SET @LanguageValue = N'社員コード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'名前';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'残業時間（月当たり時間）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.OvertTime' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'法令制限時間よりオーバー時間（月当たり）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.OvertTimeNN' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'会社制限時間よりオーバー時間（月当たり）';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.OvertTimeCompany' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'理由';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.Reason' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'勤務シフト';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.ShiftName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'勤務シフト';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.ShiftID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'勤務開始予定日';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.WorkFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'勤務終了予定日';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.WorkToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者の名前';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.FullName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'課名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.SectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'係り名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.SubsectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.ProcessName' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = '状態';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2054.Status' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'状態';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2054.StatusOOT9001' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'状態';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2054.Status' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'現在シフト';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.ShiftNow' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'総残業時間';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.TotalOT' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部コード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'課のコード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.SectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'係りコード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.SubsectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程コード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.ProcessID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'課名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.SectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'係り名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.SubsectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2054.ProcessName.CB' , @FormID, @LanguageValue, @Language;