-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1032- HRM
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
SET @FormID = 'HRMF1032';

SET @LanguageValue = N'Candidate Profile View';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Candidate code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.CandidateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of applicant';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.LastName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of applicant';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.MiddleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of applicant';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.FirstName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Avatar';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ImageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.RecruitStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sex';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Gender', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sex'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of birth';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Birthday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Place of birth';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.BornPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nationality';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.NationalityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Religion';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ReligionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ReligionID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Religion'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ReligionName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.CountryID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Country'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.CountryName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Domicile';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.NativeCountry', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID number';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.IdentifyCardNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Place of issuance of ID card';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.IdentifyPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City issues ID card';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.IdentifyCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of issue of ID card';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.IdentifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Health condition';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.HealthStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Height';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Weight';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Passport';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.PassportNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Passport date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.PassportDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Passport expiration date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.PassportEnd', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Regular address note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.PermanentAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Temporary address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.TemporaryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nation';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EthnicID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EthnicID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ethnic'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EthnicName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone number';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.PhoneNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.CandidateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.DutyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Academic level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EducationLevelID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EducationLevelID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Education level'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EducationLevelName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nominee';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Application department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of recruitment period';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.RecPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EducationLevelName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Marital status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.IsSingle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.RecPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of receipt of application';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ReceiveFileDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Where to receive documents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ReceiveFilePlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment Resource';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ResourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ResourceID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Resource'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ResourceID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Language1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.LanguageID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Language'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.LanguageName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Language2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Language3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language level 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.LanguageLevel1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.LanguageLevelID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Language'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.LanguageLevelName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language level 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.LanguageLevel2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language level 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.LanguageLevel3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Form of work';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.WorkType', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Work type'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.WorkType.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time to start work';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Startdate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.RequireSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason for applying';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.RecReason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Strength';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Strength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Weakness';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Weakness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Career orientation';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.CareerAim', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personal is goal';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.PersonalAim', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gifted';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Aptitude', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interest';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Hobby', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Political level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.PoliticsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.PoliticsID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Politics'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.PoliticsName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue =  N'Language Proficiency';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.LanguageProficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.InformaticsLevelID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Informatics level'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.InformaticsLevelName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Computer skill';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.InformaticsLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.AttachID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment source';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ResourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Evaluation date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EvaluationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personality D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Nature_D', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personality I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Nature_I', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'S is personality';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Nature_S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personality C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Nature_C', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Character';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Nature', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personality D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Adaptive_D', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personality I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Adaptive_I', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'S is personality';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Adaptive_S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personality C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Adaptive_C', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Character';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Adaptive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sex';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.GenderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.IdentifyCityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'End time'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EducationToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Educating Type'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EducationTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Educating Type'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EducationTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Note',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Address'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.CompanyAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Company Name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.CompanyName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Country'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.CountryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Begin Time'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.FromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'End time'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.ToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Duty',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Reason'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Reason',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Note'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Personal Information'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.SubTitle01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Recruitment Information'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.SubTitle02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Educational information'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.SubTitle03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Work experience'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.SubTitle04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.SubTitle05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hítory'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.SubTitle06',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Educational information'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.SubTitle07',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'D.I.S.C'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.SubTitle08',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Education Center'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EducationCenter',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Begin time'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EducationFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Major'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1032.EducationMajor',  @FormID, @LanguageValue, @Language;
