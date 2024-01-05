-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ 
-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ
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
SET @FormID = 'HRMF3015';

SET @LanguageValue = N'Recruitment following-up report';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3015.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3015.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3015.ReportID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report Name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3015.ReportName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3015.ReportTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3015.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3015.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Team';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3015.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of employed candidates';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3015.chartTitle1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Age of employed candidates';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3015.chartTitle2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Female';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3015.Female' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Male';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3015.Male' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Filtering condition';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3015.GroupFilter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3015.GroupReport' , @FormID, @LanguageValue, @Language;