--Created : 18/10/2023 Phương Thảo : Ngôn ngữ màn hình danh mục Kết quả thử việc (HRMF2200)
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
SET @FormID = 'HRMF2200';

SET @LanguageValue  = N'Danh mục kết quả thử việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.Title',  @FormID, @LanguageValue, @Language;

---ngôn ngữ combobox Begin ADD

SET @LanguageValue  = N'Mã kết quả';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.ResultID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kết quả';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.ResultName.CB',  @FormID, @LanguageValue, @Language;

---Ngôn ngữ combobox End ADD

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kết quả thử việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.ResultNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.ResultDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.ReviewPerson' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.ReviewPersonName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.DecidePerson' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.DecidePersonName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hợp đồng thử việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.ContractNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thử việc từ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.TestFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thử việc đến';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.TestToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả thử việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.ResultID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả thử việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.ResultName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết thúc trước ngày thử việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.IsStopBeforeEndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày  kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.EndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung kết quả';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.StatusName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2200.ApprovalNotes' , @FormID, @LanguageValue, @Language;
