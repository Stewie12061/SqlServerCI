
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
SET @FormID = 'HRMF2030';

SET @LanguageValue = N'Danh mục lịch phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lịch phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.InterviewScheduleID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.InterviewScheduleName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã ứng viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.CandidateID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên ứng viên';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.CandidateName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.DutyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vòng phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.InterviewLevel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.InterviewFromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.InterviewToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đợt tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.RecruitPeriodID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đợt tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.RecruitPeriodName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.DutyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.DutyID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên vị trí tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.DutyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.AssignedToUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phỏng vấn';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2030.AssignedToUserName' , @FormID, @LanguageValue, @Language;