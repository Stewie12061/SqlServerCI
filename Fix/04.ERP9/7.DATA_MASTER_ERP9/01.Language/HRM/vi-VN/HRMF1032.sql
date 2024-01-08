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
SET @FormID = 'HRMF1032'

---------------------------------------------------------------

SET @LanguageValue  = N'Xem thông tin hồ sơ ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Năng khiếu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Aptitude',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sinh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Birthday',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi sinh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.BornPlace',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.CandidateID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định hướng nghề nghiệp'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.CareerAim',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.CompanyAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên công ty'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.CompanyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quốc gia'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.CountryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban ứng tuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Duty',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí ứng tuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên cơ sở đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EducationCenter',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian bắt đầu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EducationFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ học vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EducationLevelID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngành đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EducationMajor',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian kết thúc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EducationToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hình đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EducationTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EducationTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Email',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dân tộc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EthnicName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Fax'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Fax',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.FirstName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian bắt đầu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giới tính'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Gender',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng sức khỏe'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.HealthStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiều cao'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Height',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sở thích'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Hobby',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xem thông tin hồ sơ ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.HRMF1030.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình ảnh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.HRMF1032ImageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.IdentifyCardNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉnh/TP cấp CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.IdentifyCity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉnh/TP cấp CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.IdentifyCityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cấp CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.IdentifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi cấp CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.IdentifyPlace',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ảnh ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ImageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ tin học'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.InformaticsLevel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng hôn nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.IsSingle',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Language1ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Language2ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 3'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Language3ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ 1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.LanguageLevel1ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ 2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.LanguageLevel2ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ 3'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.LanguageLevel3ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cập nhật'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.LastName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.MiddleName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quốc tịch'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Nationality',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quốc tịch'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.NationalityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên quán'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.NativeCountry',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cấp hộ chiếu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.PassportDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn hộ chiếu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.PassportEnd',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hộ chiếu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.PassportNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ thường chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.PermanentAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mục tiêu cá nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.PersonalAim',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số điện thoại'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.PhoneNumber',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ chính trị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.PoliticsID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lý do nghỉ việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Reason',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày nhận hồ sơ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ReceiveFileDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi nhận hồ sơ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ReceiveFilePlace',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.RecPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.RecPeriodName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lý do ứng tuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.RecReason',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.RecruitStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.RecruitStatusName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tôn giáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ReligionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tôn giáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ReligionName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức lương yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.RequireSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ResourceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian có thể bắt đầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Startdate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm mạnh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Strength',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin cá nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.SubTitle01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.SubTitle02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin học vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.SubTitle03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kinh nghiệm làm việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.SubTitle04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.SubTitle05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lịch sử'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.SubTitle06',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ tạm chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.TemporaryAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xem thông tin hồ sơ tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian kết thúc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm yếu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Weakness',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cân nặng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Weight',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức làm việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.WorkType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình ảnh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032ImageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dân tộc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EthnicID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ chính trị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.PoliticsID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EnglishSkill',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đánh giá'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EvaluationDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách D'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Nature_D',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách I'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Nature_I',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách S'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Nature_S',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách C'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Nature_C',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Nature',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách D'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Adaptive_D',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách I'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Adaptive_I',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách S'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Adaptive_S',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách C'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Adaptive_C',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Adaptive',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'D.I.S.C'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.SubTitle08',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.SubTitle07',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách D'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Nature_D',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách I'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Nature_I',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách S'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Nature_S',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách C'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Nature_C',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách D'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Adaptive_D',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách I'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Adaptive_I',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách S'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Adaptive_S',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách C'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Adaptive_C',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Nature',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Adaptive',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đánh giá'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EvaluationDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.StatusID',  @FormID, @LanguageValue, @Language;
