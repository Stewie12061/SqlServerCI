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
SET @FormID = 'HRMF3013';

SET @LanguageValue = N'Employee following-up report';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3013.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3013.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ReportID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3013.ReportID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report Name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3013.ReportName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3013.ReportTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3013.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3013.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Team';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3013.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty Group';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3013.DutyGroupList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Filtering condition';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3013.GroupFilter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3013.GroupReport' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Male - Female employee conditons';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3013.chartTitle1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Male';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3013.Male' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Female';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3013.Female' , @FormID, @LanguageValue, @Language;