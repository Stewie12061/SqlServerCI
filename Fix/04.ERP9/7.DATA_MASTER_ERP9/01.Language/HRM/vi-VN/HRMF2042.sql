-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1032- OO
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


SET @Language = 'vi-VN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2042'

SET @LanguageValue  = N'Xem chi tiết kết quả phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng 1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TabInfoRound1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.RecruitPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.RecruitPeriodName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức lương đề xuất'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.RequireSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin ứng tuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.GroupInfo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tháng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Month',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức lương thỏa thuận'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DealSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian có thể nhận việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Startdate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian thử việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TrialTime',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TrialFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TrialToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên vị trí ứng tuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TabInfo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.CandidateName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vị trí ứng tuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TabInfoInterview',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.RecruitStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewDate01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewDate02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewDate03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewDate04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewDate05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa điểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa điểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewAddress01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa điểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewAddress02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa điểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewAddress03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa điểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewAddress04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa điểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewAddress05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeID01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeID02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeID03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeID04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeID05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeName01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeName02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeName03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeName04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewTypeName05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kết quả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewStatus01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kết quả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewStatus02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kết quả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewStatus03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kết quả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewStatus04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kết quả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.InterviewStatus05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhận xét'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Comment01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhận xét'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Comment02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhận xét'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Comment03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhận xét'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Comment04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhận xét'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.Comment05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng 2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TabInfoRound2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng 3'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TabInfoRound3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng 4'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TabInfoRound4',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng 5'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TabInfoRound5',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.CandidateID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.GhiChu',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.DinhKem',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TabCMNT90051' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái' 
EXEC ERP9AddLanguage @ModuleID, 'HRMF2042.StatusID',  @FormID, @LanguageValue, @Language;