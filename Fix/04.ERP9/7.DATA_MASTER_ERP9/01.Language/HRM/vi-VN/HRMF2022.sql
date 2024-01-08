--- Modify on 05/09/2023 by Phương Thảo : Cập nhật ngôn ngữ tab yêu cầu công việc bổ sung đuôi _HRMT2024
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2022- OO
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
SET @FormID = 'HRMF2022'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ tuổi'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Age',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'APK'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.APK',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại hình'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Appearance_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu chung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.CommonRequirement',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khả năng giao tiếp'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Communication_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Content',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí (VND)'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Cost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí dự kiến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Costs',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khả năng sáng tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Creativeness_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ học vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.EducationLevelID_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.EducationLevelID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.EducationLevelName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kinh nghiệm làm việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Experience_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.From',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.FromAge_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.FromSalary_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giới tính'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Gender_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu sức khỏe'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.HealthRequirement',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng sức khỏe'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.HealthStatus_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiều cao'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Height_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ tin học'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.InformaticsLevel_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'InheritRecruitPeriodID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.InheritRecruitPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khả năng giao tiếp'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.IsCommunication_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khả năng sáng tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.IsCreativeness_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ tin học'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.IsInformatics_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khả năng giải quyết công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.IsProblemSolving_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khả năng trình bày, thuyết phục'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.IsPrsentation_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Language1ID_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Language2ID_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 3'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Language3ID_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ngôn ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LanguageID.CB_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LanguageLevel1ID_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LanguageLevel2ID_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LanguageLevel3ID_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã cấp độ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LanguageLevelID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên cấp độ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LanguageLevelName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ngôn ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LanguageName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LanguageSkill',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày thay đổi'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người thay đổi'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Notes_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số vòng phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.NumberInterviews',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian thực hiện từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.PeriodFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.PeriodToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khả năng giải quyết công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ProblemSolving_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Prsentation_HRMT2024'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Prsentation_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian nhận hồ sơ từ ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ReceiveFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ReceiveToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitCircle',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitPeriodName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã kế hoạch tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitPlanID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên kế hoạch tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitPlanName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RecruitRequirement',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian cần nhân sự'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.RequireDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức lương'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Salary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu kỹ năng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.SkillRequirement',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.TabAttach',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.TabChiPhi',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.TabCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.TabHistory',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.TabNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.TabInterviewTurn',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.TabRecruitInfo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.TabRecruitRequirement',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.TabThongTinTuyenDung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vòng phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.TabVongPhongVan',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành viên HĐTD'
EXEC ERP9AddLanguage @ModuleID, 'InterviewMember',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'InterviewType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu sức khỏe'
EXEC ERP9AddLanguage @ModuleID, 'HealthRequirement',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chưa chọn vị trí tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'NotChoosenDutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số thành viên HĐTD'
EXEC ERP9AddLanguage @ModuleID, 'NumberInterviewers',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa điểm'
EXEC ERP9AddLanguage @ModuleID, 'Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.TabYeuCauTuyenDung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.To',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ToAge_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ToSalary_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số vòng phỏng vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.TotalLevel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cân nặng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Weight_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.WorkDescription_HRMT2024',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi làm việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.WorkPlace',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian làm việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.WorkType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng định biên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.QuantityBoundary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'SLKH theo đợt'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ActualQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí hiện có (VND)'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.ActualCost',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí định biên (VND)'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.CostBoundary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2022.Description',  @FormID, @LanguageValue, @Language;


