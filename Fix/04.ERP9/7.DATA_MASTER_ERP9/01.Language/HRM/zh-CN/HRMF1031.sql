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
SET @Language = 'zh-CN' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1031';

SET @LanguageValue = N'更新應聘人資料';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘人代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CandidateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘人姓名';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LastName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘人姓名';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.MiddleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘人姓名';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.FirstName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘人照片';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ImageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.RecruitStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性別';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Gender', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出生日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Birthday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出生地';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.BornPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'国籍';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.NationalityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'宗教';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ReligionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'家鄉';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.NativeCountry', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'身份證號';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IdentifyCardNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'身份證簽發地';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IdentifyPlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'簽發身份證的省/市';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IdentifyCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'身份證簽發日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IdentifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'健康狀況';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.HealthStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'高度';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'重量';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'护照号';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PassportNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'護照簽發日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PassportDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'護照到期日';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PassportEnd', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'常住地址';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PermanentAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'臨時居住地址';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.TemporaryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'國家';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EthnicID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話號碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PhoneNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'傳真';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
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

SET @LanguageValue = N'應聘崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文化水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationLevelID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘崗位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DutyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘批次名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.RecPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EducationLevelName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'家庭狀況';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IsSingle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘批次代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.RecPeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'檔案接收日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ReceiveFileDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'檔案收件處';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ReceiveFilePlace', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招募來源';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ResourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Language1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Language2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外語3';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Language3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'1級外語水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageLevel1ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'2級外語水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageLevel2ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'3級外語水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageLevel3ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作形式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.WorkType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'可以開始工作的時間';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Startdate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期望的工資';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.RequireSalary', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘理由';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.RecReason', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優勢';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Strength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'缺點';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Weakness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職業定位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.CareerAim', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'個人目標';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PersonalAim', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'天才';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Aptitude', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'愛好';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Hobby', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'政治水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.PoliticsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.LanguageProficiency
', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電腦水平';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.InformaticsLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.AttachID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招募來源';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.ResourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'評估日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.EvaluationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Nature_D', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Nature_I', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格S';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Nature_S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Nature_C', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Nature', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格D';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Adaptive_D', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格I';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Adaptive_I', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格S';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Adaptive_S', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格C';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Adaptive_C', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'性格';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.Adaptive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.GenderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1031.IdentifyCityName', @FormID, @LanguageValue, @Language;

