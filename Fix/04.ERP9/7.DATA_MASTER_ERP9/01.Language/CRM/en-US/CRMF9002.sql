------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF9002 - CRM 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9002';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Choose the route map';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9002.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Route ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9002.RouteID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Route Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9002.RouteName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9002.EmployeeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9002.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9002.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Station Order';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9002.StationOrder' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Station ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9002.StationID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Station Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9002.StationName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9002.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Street';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9002.Street' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ward';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9002.Ward' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'District';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9002.District' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9002.Notes' , @FormID, @LanguageValue, @Language;








