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
SET @FormID = 'HRMF2012'

SET @LanguageValue  = N'Xem chi tiết yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.RecruitRequireID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.RecruitRequireName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giới tính'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Gender',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.FromAge',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.ToAge',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ học vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.EducationLevelID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại hình'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Appearance',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kinh nghiệm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Experience',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.FromSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.ToSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả yêu cầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.WorkDescription',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Language1ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Language2ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 3'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Language3ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ 1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.LanguageLevel1ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ 2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.LanguageLevel2ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ 3'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.LanguageLevel3ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ tin học'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.IsInformatics',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khả năng sáng tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.IsCreativeness',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khả năng giải quyết công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.IsProblemSolving',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khả năng trình bày, thuyết phục'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.IsPrsentation',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khả năng giao tiếp'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.IsCommunication',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.InformaticsLevel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Creativeness',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.ProblemSolving',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Prsentation',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Communication',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiều cao'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Height',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cân nặng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Weight',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng sức khỏe'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.HealthStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu chung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.GroupRequireCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu kỹ năng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.GroupRequire',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.GroupRequireLanguage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Yêu cầu sức khỏe'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.GroupRequireHealth',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ tuổi'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.GroupAge',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức lương'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.GroupSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.TabInfo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại phép'
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.AbsentTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Là ngày kế'
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.IsNextDay',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ĐTVS Hợp lệ'
EXEC ERP9AddLanguage @ModuleID, 'OOF2012.IsValid',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.TabCRMT00001',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2012.StatusID',  @FormID, @LanguageValue, @Language;