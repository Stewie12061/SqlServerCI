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
SET @FormID = 'HRMF3014';

SET @LanguageValue = N'Sick leave following-up report';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3014.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3014.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3014.ReportID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report Name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3014.ReportName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3014.ReportTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3014.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3014.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Team';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3014.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duty Group';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3014.DutyGroupList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Filtering condition';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3014.GroupFilter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3014.GroupReport' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3014.totalTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ratio (%)';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3014.ratioTitle' , @FormID, @LanguageValue, @Language;