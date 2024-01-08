
-----------------------------------------------------------------------------------------------------
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
SET @FormID = 'HRMF1072';

SET @LanguageValue = N'Hồ sơ lao động mặc định';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày ký';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.SignDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người ký';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.SignPersonID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa điểm làm việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.WorkAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian làm việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.WorkTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công cụ cấp phát';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.IssueTool' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phương tiện đi lại';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.Conveyance' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức trả lương';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.PayForm' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chế độ nghỉ ngơi';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.RestRegulation' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.ContractTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.ContractTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.PaymentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hình thức trả lương';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.PaymentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.ContractTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.EmployeeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người ký';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1072.EmployeeName.CB' , @FormID, @LanguageValue, @Language;