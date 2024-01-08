--- Modify on 05/09/2023 by Phương Thảo : Cập nhật ngôn ngữ tab yêu cầu công việc bổ sung đuôi _HRMT2024
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2021- OO
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
SET @FormID = 'HRMF2021'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitCircle',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'APK'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.APK',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại hình'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Appearance_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khả năng giao tiếp'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Communication_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí (VND)'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Cost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí dự kiến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Costs',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khả năng sáng tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Creativeness_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ học vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.EducationLevelID_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kinh nghiệm làm việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Experience_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.FromAge_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.FromSalary_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giới tính'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Gender_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng sức khỏe'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.HealthStatus_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiều cao'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Height_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ tin học'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.InformaticsLevel_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'InheritRecruitPeriodID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.InheritRecruitPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khả năng giao tiếp'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.IsCommunication_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khả năng sáng tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.IsCreativeness_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ tin học'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.IsInformatics_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khả năng giải quyết công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.IsProblemSolving_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khả năng trình bày, thuyết phục'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.IsPrsentation_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Language1ID_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Language2ID_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 3'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Language3ID_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LanguageLevel1ID_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LanguageLevel2ID_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LanguageLevel3ID_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày thay đổi'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người thay đổi'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Notes_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian thực hiện từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.PeriodFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.PeriodToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ProblemSolving'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ProblemSolving_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Prsentation_HRMT2024'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Prsentation_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian nhận hồ sơ từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ReceiveFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ReceiveToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitCircle',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitPeriodName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã kế hoạch tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitPlanID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kế hoạch tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitPlanName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian cần nhân sự'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RequireDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cập nhật đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ToAge_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ToSalary_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số vòng phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.TotalLevel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cân nặng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Weight_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.WorkDescription_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi làm việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.WorkPlace',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức làm việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.WorkType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức làm việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.WorkType.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.TabThongTinTuyenDung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.TabYeuCauTuyenDung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.TabVongPhongVan',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.TabChiPhi',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitRequirement',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số vòng phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.NumberInterviews',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Content',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chưa chọn vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.NotChoosenDutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa điểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành viên HĐTD'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.InterviewMember',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.EducationLevelID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.EducationLevelName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ngôn ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LanguageID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ngôn ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LanguageName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã cấp độ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LanguageLevelID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên cấp độ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.LanguageLevelName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Time',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitRequirement',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu chung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.CommonRequirement',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu kỹ năng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.SkillRequirement',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu sức khỏe'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.HealthRequirement',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số vòng phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.NumberInterviews',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Content',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chưa chọn vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.NotChoosenDutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitRequirement',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu kỹ năng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.SkillRequirement',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu chung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.CommonRequirement',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu sức khỏe'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.HealthRequirement',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số vòng phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.NumberInterviews',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Content',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chưa chọn vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.NotChoosenDutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số thành viên HĐTD'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.NumberInterviewers',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.InterviewType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa điểm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành viên HĐTD'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.InterviewMember',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ tuổi'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Age',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức lương'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Salary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí hiện có (VND)'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ActualCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí định biên (VND)'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.CostBoundary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'SLKH theo đợt'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.ActualQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng định biên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.QuantityBoundary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Attach',  @FormID, @LanguageValue, @Language;

---Modify on 06/09/2023 by Phương Thảo  bổ sung ngôn ngữ : Số vòng phỏng vấn và Yêu cầu tuyển dụng
 
SET @LanguageValue  = N'Số vòng phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.NumberInterviews_HRMT2021',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.RecruitRequirement_HRMT2024',  @FormID, @LanguageValue, @Language;

---Modify on 06/09/2023 by Phương Thảo  bổ sung ngôn ngữ : các tab
 
SET @LanguageValue  = N'Vòng phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.TabHRMT2021',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hội đồng tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.TabHRMT2022',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.TabHRMT2023',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.TabHRMT2024',  @FormID, @LanguageValue, @Language;

--Modifify on 13/09/2023 by Phương Thảo bổ sung ngôn ngữ cho fieldset
SET @LanguageValue  = N'Thông tin tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.InformationRecruit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin số lượng và chi phí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.InformationSalaryCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin khác'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2021.Informationdifferent',  @FormID, @LanguageValue, @Language;

