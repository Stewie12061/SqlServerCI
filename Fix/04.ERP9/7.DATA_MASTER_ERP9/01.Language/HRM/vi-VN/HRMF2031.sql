
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
SET @FormID = 'HRMF2031';

SET @LanguageValue = N'Cập nhật lịch phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lịch phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.InterviewScheduleID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã ứng viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.CandidateID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên ứng viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.CandidateName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vòng phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.InterviewLevel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.InterviewFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.InterviewToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đợt tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.RecruitPeriodID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đợt tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.RecruitPeriodName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.DutyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.DutyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.DutyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.InterviewDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.Attach' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xác nhận phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.ConfirmID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.InterviewAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.AbsentTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ca làm việc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.Description.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.AssignedToUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2031.AssignedToUserName' , @FormID, @LanguageValue, @Language;