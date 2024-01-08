--Created : 08/08/2023 Phương Thảo : Ngôn ngữ màn hình danh mục Hợp đồng lao đồng (HRMF2180)
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
SET @FormID = 'HRMF2180';

SET @LanguageValue  = N'Danh mục hợp đồng lao động'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.Title',  @FormID, @LanguageValue, @Language;

---ngôn ngữ combobox Begin ADD

SET @LanguageValue  = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.TeamID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.TeamName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.ContractTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.ContractTypeName.CB',  @FormID, @LanguageValue, @Language;



---Ngôn ngữ combobox End ADD

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.DivisionID' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Loại hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.ContractTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.ContractNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.ContractTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.TeamID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.TeamName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày ký';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.SignDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người ký';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.SignPersonName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.DutyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.StatusRecieveName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lảm việc từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.WorkDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Làm đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2180.WorkEndDate' , @FormID, @LanguageValue, @Language;

