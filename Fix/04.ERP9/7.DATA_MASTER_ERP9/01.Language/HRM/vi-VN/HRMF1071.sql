
-----------------------------------------------------------------------------------------------------
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
SET @Language = 'vi-VN' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1071';

SET @LanguageValue = N'Hồ sơ nhân viên mặc định';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh - TPhố';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.CityID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc tịch';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.CountryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.DepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dân tộc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.EthnicID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tôn giáo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.ReligionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên quán';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.NativeCountry' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nơi tuyển dụng';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.RecruitPlace' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nữ';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.IsMale' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đã lập gia đình';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.IsSingle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.ReligionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tôn giáo';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.ReligionName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.EthnicID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dân tộc';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.EthnicName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.CountryID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.CountryName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.CityID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh - TPhố';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.CityName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.DepartmentID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.DepartmentName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.DivisionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.DivisionName.CB' , @FormID, @LanguageValue, @Language;