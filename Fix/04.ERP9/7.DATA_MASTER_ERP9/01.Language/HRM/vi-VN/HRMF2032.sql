
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
SET @FormID = 'HRMF2032';

SET @LanguageValue = N'Xem thông tin lịch phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lịch phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.InterviewScheduleID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã ứng viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.CandidateID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên ứng viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.CandidateName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vòng phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.InterviewLevel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.InterviewFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.InterviewToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đợt tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.RecruitPeriodID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đợt tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.RecruitPeriodName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.DutyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.DutyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.DutyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.InterviewDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin lịch phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.TabThongTinLichPhongVan' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết lịch phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.TabChiTietLichPhongVan' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xác nhận phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.ConfirmID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.InterviewAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.DutyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.TabCRMT00002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.TabCMNT90051' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.TabCRMT00003' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.TabCRMT90031' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.AssignedToUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2032.AssignedToUserName' , @FormID, @LanguageValue, @Language;
