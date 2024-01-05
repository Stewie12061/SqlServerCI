-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1031- OO
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
SET @FormID = 'HRMF1031'

SET @LanguageValue  = N'Cập nhật hồ sơ ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Adaptive',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách C'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Adaptive_C',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách D'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Adaptive_D',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách I'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Adaptive_I',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách S'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Adaptive_S',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Năng khiếu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Aptitude',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.AttachID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức lương cơ bản'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.BaseSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sinh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Birthday',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi sinh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.BornPlace',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lĩnh vực kinh doanh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.BusinessSector',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CandidateID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định hướng nghề nghiệp'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CareerAim',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CityID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉnh/TP'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CityName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CompanyAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên công ty'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CompanyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ContentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ContentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ContentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ContentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Liên lạc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Contract',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CountryID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quốc gia'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CountryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quốc gia'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CountryName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban ứng tuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban ứng tuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chức vụ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Duty',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí ứng tuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DutyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí ứng tuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DutyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí ứng tuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên cơ sở đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationCenter',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian bắt đầu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ học vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationLevelID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationLevelID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ học vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationLevelName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngành đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationMajor',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian kết thúc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hình đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hình đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EnglishSkill',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dân tộc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EthnicID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EthnicID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dân tộc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EthnicName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dân tộc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EthnicName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đánh giá'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EvaluationDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Fax'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Fax',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.FirstName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian bắt đầu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giới tính'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Gender',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quá trình học tập/Quá trình tham gia các khóa đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Grid3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng sức khỏe'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.HealthStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiều cao'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Height',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sở thích'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Hobby',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IdentifyCardNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉnh/TP cấp CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IdentifyCity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉnh/TP cấp CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IdentifyCityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cấp CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IdentifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi cấp CMND'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IdentifyPlace',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ảnh ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ImageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ tin học'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.InformaticsLevel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ tin học'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.InformationTechnologySkill',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sử dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.isActived',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng gia đình'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IsSingle',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng hôn nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IsSingle.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độc thân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.IsSingle1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đã lập gia đình'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.IsSingle2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sử dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IsUsed',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Language1ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Language2ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ 3'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Language3ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ 1'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageLevel1ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ 2'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageLevel2ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ ngoại ngữ 3'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageLevel3ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngoại ngữ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LastName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tình trạng hôn nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.MaritalStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ứng viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.MiddleName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quốc tịch'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Nationality',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quốc tịch'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.NationalityID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguyên quán'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.NativeCountry',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Nature',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách C'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Nature_C',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách D'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Nature_D',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách I'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Nature_I',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính cách S'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Nature_S',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày cấp hộ chiếu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PassportDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn hộ chiếu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PassportEnd',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hộ chiếu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PassportNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ thường trú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PermanentAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cá nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Persional',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mục tiêu cá nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PersonalAim',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cá nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PersonalText',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số điện thoại'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PhoneNumber',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ chính trị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PoliticsID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PoliticsID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ chính trị'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PoliticsName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lý do nghỉ việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Reason',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày nhận hồ sơ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ReceiveFileDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nơi nhận hồ sơ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ReceiveFilePlace',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.RecPeriodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đợt tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.RecPeriodName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Lý do ứng tuyển'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.RecReason',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.RecruitStatus',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tôn giáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ReligionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ReligionID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tôn giáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ReligionName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tôn giáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ReligionName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức lương yêu cầu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.RequireSalary',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ResourceID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ResourceID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ResourceName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nguồn tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ResourceName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nói'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.SpeakingName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian có thể bắt đầu công việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Startdate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm mạnh'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Strength',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ tạm trú'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.TemporaryAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian kết thúc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số con'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.TotalChildren',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tổng số lượng nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.TotalEmployee',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng nhân viên cùng phòng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.TotalRoomMate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Value.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin cá nhân'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.TabHRMT1030Tab01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.TabHRMT1030Tab02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Kinh nghiệm làm việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.TabHRMT1033',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin học vấn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.TabHRMT1034',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'D.I.S.C'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.TabHRMT10341',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điểm yếu'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Weakness',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cân nặng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Weight',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức làm việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.WorkType',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hình thức làm việc'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.WorkType.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quá trình học tập/Quá trình tham gia các khóa đào tạo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.StudyProcess',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn từ hồ sơ nhân sự'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.HRRecords',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đánh giá tuyển dụng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EvaluationKitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại đánh giá'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EvaluationKitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại đánh giá'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EvaluationKitName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.InformaticsLevelID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trình độ tin học'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.InformaticsLevelName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageLevelID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cấp độ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageLevelName.CB',  @FormID, @LanguageValue, @Language;