-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1031- HRM
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
SET @Language = 'en-US' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1031';

SET @LanguageValue = N'Candidate Profile Update';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Candidate ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CandidateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Candidate Name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LastName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Middle Name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.MiddleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'First Name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.FirstName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Avatar';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ImageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.RecruitStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sex';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Gender', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sex'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Birthday';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Birthday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Place of birth';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.BornPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nationality';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.NationalityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Religion';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ReligionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ReligionID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Religion'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ReligionName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CountryID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Country'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CountryName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Native Country';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.NativeCountry', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Identify Card No';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IdentifyCardNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Identify Place';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IdentifyPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Identify City ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IdentifyCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Identify Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IdentifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Health Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.HealthStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Height';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Weight';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Passport No';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PassportNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Passport Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PassportDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Passport expiration date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PassportEnd', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Permanent Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PermanentAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Temporary Address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.TemporaryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ethnic';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EthnicID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EthnicID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ethnic'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EthnicName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PhoneNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CandidateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Educating Level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationLevelID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationLevelID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Education level'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationLevelName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty Name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department Name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruit Period';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.RecPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationLevelName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Is single';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IsSingle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruit Period ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.RecPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receive File Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ReceiveFileDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Receive File Place';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ReceiveFilePlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment Resource';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ResourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ResourceID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Resource'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ResourceID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Language1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Language'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Language2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Language3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language Level 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageLevel1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageLevelID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Language'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageLevelName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language Level 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageLevel2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language Level 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageLevel3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Work Type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.WorkType', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Work type'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.WorkType.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Startdate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Require Salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.RequireSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruit Reason';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.RecReason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Strength';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Strength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Weakness';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Weakness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Career Aim';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CareerAim', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personal Aim';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PersonalAim', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Aptitude';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Aptitude', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hobby';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Hobby', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Politics';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PoliticsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PoliticsID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Politics'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PoliticsName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language Proficiency';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageProficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Informatics Level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.InformaticsLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.InformaticsLevelID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Informatics level'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.InformaticsLevelName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.AttachID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment Resource';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ResourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EvaluationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nature D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Nature_D', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nature I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Nature_I', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nature S';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Nature_S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nature C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Nature_C', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nature';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Nature', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Adaptive D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Adaptive_D', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Adaptive I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Adaptive_I', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Adaptive S';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Adaptive_S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Adaptive C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Adaptive_C', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Adaptive';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Adaptive', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Personal Information'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.TabHRMT1030Tab01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Recruitment Information'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.TabHRMT1030Tab02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Educational information'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.TabHRMT1033',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Education Center'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationCenter',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Begin time'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Major'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationMajor',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'End time'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Educating Type'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Educating Type'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Work experience'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.TabHRMT1034',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Address'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CompanyAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Company Name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CompanyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Country'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CountryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Begin Time'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'End time'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Duty',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Reason'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Reason',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'D.I.S.C'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.TabHRMT10341',  @FormID, @LanguageValue, @Language;

