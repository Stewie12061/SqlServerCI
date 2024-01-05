
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
SET @Language = 'ja-JP' 
SET @ModuleID = 'HRM';
SET @FormID = 'OOF2052';
------- phần master
SET @LanguageValue = N'休暇申請届けの承認';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'休暇申請届けコード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解釈';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'課';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.SectionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'係り';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.SubsectionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.ProcessID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.ApprovePersonID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者の状態';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.ApprovePersonStatus' , @FormID, @LanguageValue, @Language;

------- phần detail
SET @LanguageValue = N'社員コード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'名前';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'欠勤理由';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.Reason' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'休暇種類';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.AbsentTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'から休暇とる';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.LeaveFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'まで休暇とる';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.LeaveToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合計';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.TotalTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備考';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.Note' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'休暇時間';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.TimeAllowance' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'代休時間';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.OffsetTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承認者の名前';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.FullName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'課名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.SectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'係り名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.SubsectionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.ProcessName' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'状態';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2052.StatusOOT9001' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'状態';
 EXEC ERP9AddLanguage @ModuleID, 'OOF2052.Status' , @FormID, @LanguageValue, @Language;
 
 SET @LanguageValue = N'勤務シフト';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.OldShiftID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Ca thay đổi';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.ShiftID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部コード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'課のコード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.SectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'係りコード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.SubsectionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程コード';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.ProcessID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'課名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.SectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'係り名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.SubsectionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工程名';
EXEC ERP9AddLanguage @ModuleID, 'OOF2052.ProcessName.CB' , @FormID, @LanguageValue, @Language;