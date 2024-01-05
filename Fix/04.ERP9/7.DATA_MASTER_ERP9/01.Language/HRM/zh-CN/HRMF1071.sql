-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1071- HRM
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


SET @Language = 'zh-CN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1071'
SET @LanguageValue  = N'员工默认档案更新'
EXEC ERP9AddLanguage @ModuleID, 'HRMF10801.title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'单位';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'省 - 直辖市';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.CityID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'国籍';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.CountryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部门';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'民族';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.EthnicID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'宗教';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.ReligionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'籍贯';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.NativeCountry' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'招聘地点';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.RecruitPlace' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'男';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.IsMale' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未婚';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.IsSingle' , @FormID, @LanguageValue, @Language;