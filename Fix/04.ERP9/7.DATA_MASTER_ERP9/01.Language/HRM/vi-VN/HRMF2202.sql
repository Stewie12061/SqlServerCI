--Created : 18/10/2023 Phương Thảo : Ngôn ngữ màn hình chi tiết Kết quả thử việc (HRMF2202)
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
SET @FormID = 'HRMF2202';
--Title
SET @LanguageValue  = N'Chi tiết kết quả thử việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.Title',  @FormID, @LanguageValue, @Language;
--Tab Begin ADD
SET @LanguageValue  = N'Thông tin kết quả thử việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.TabProbationResult',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.TabCRMT90031',  @FormID, @LanguageValue, @Language;
--Tab END ADD

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kết quả thử việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.ResultNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.ResultDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.ReviewPerson' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.ReviewPersonName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.DecidePerson' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.DecidePersonName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hợp đồng thử việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.ContractNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thử việc từ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.TestFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thử việc đến';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.TestToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả thử việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.ResultID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết quả thử việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.ResultName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết thúc trước ngày thử việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.IsStopBeforeEndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày  kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.EndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung kết quả';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.StatusName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ghi chú người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.ApprovalNotes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2202.Description' , @FormID, @LanguageValue, @Language;

