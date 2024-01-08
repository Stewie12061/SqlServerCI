-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1030- HRM
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
SET @Language = 'en-US'; 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1030';

SET @LanguageValue = N'Candidate Profile';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Candidate code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.CandidateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of applicant';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.LastName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of applicant';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.MiddleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of applicant';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.FirstName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Image';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.ImageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.RecruitStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sex';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Gender', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Birthday';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Birthday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Place of birth';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.BornPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nationality';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.NationalityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Religion';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.ReligionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Domicile';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.NativeCountry', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID number';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.IdentifyCardNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Place of issuance of ID card';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.IdentifyPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Province/City issues ID card';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.IdentifyCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of issue of ID card';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.IdentifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Health status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.HealthStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Height';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Weight';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Passport';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.PassportNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Passport date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.PassportDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Passport expiration date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.PassportEnd', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Regular address note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.PermanentAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Temporary address';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.TemporaryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ethnic';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.EthnicID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone number';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.PhoneNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue =  N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue =  N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of applicant';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.CandidateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nominee';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Academic level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.EducationLevelID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nominee';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.RecPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Academic level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.EducationLevelName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Family status';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.IsSingle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recruitment code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.RecPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of receipt of application';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.ReceiveFileDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Where to receive documents';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.ReceiveFilePlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.ResourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Language1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Language2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Language3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language level 1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.LanguageLevel1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language level 2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.LanguageLevel2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Foreign language level 3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.LanguageLevel3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Working time';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.WorkType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time to start work';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Startdate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected salary';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.RequireSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason for applying';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.RecReason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Strength';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Strength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Weakness';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Weakness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Career orientation';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.CareerAim', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Personal''s goal';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.PersonalAim', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gifted';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Aptitude', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interest';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Hobby', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Political level';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.PoliticsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Language Proficiency';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.LanguageProficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Computer skill';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.InformaticsLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File attached';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.AttachID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Resource name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.ResourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.EvaluationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Nature_D', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Nature_I', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Nature_S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Nature_C', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Nature', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Adaptive_D', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Adaptive_I', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Adaptive_S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Adaptive_C', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Adaptive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sex';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.GenderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.IdentifyCityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty Name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.DutyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sex'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Departmen'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Duty ID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1030.DutyID.CB',  @FormID, @LanguageValue, @Language;
