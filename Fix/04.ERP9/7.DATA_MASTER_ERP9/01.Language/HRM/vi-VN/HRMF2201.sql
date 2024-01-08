--Created : 18/10/2023 Phương Thảo : Ngôn ngữ màn hình cập nhật Kết quả thử việc (HRMF2201)
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
SET @FormID = 'HRMF2201';

--Title
SET @LanguageValue  = N'Cập nhật kết quả thử việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.Title',  @FormID, @LanguageValue, @Language;
---ngôn ngữ combobox Begin ADD
SET @LanguageValue  = N'Mã kết quả';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.ResultID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kết quả';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.ResultName.CB',  @FormID, @LanguageValue, @Language;
---Ngôn ngữ combobox End ADD

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kết quả thử việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.ResultNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.ResultDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.ReviewPerson' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.ReviewPersonName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.DecidePerson' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.DecidePersonName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hợp đồng thử việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.ContractNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thử việc từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.TestFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thử việc đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.TestToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả thử việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.ResultID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả thử việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.ResultName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết thúc trước ngày thử việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.IsStopBeforeEndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày  kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.EndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung kết quả';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.ApprovePersonID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.ApprovePersonName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.StatusName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ghi chú người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.ApprovalNotes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2201.ApprovalNotes' , @FormID, @LanguageValue, @Language;
