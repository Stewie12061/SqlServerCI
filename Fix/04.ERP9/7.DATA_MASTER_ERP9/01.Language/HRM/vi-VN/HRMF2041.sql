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
SET @FormID = 'HRMF2041'

SET @LanguageValue  = N'Cập nhật kết quả phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.RecruitPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.RecruitPeriodName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức lương đề xuất'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.RequireSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin ứng tuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.GroupInfo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tháng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Month',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức lương thỏa thuận'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.DealSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian có thể nhận việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Startdate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian thử việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.TrialTime',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.TrialFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.TrialToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí ứng tuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.CandidateName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí ứng tuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.RecruitStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewDate01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewDate02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewDate03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewDate04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewDate05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa điểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewAddress01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa điểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewAddress02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa điểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewAddress03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa điểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewAddress04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa điểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewAddress05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeID01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeID02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeID03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeID04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeID05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeName01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeName02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeName03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeName04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewTypeName05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kết quả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewStatus01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kết quả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewStatus02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kết quả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewStatus03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kết quả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewStatus04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kết quả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.InterviewStatus05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhận xét'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Comment01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhận xét'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Comment02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhận xét'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Comment03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhận xét'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Comment04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhận xét'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Comment05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.CandidateID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.CandidateID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.CandidateName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Value.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Gửi mail'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.btnSendMail',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng 1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.TabHRMT20401',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng 2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.TabHRMT20402',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng 3'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.TabHRMT20403',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng 4'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.TabHRMT20404',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng 5'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.TabHRMT20405',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Attach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.ThongTinChung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng 1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Vong1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng 2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Vong2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng 3'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Vong3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng 4'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Vong4',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng 5'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2041.Vong5',  @FormID, @LanguageValue, @Language;