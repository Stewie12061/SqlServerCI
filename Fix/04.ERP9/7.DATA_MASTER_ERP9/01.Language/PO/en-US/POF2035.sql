-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2035- PO
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
SET @ModuleID = 'PO';
SET @FormID = 'POF2035';

SET @LanguageValue = N'Title';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.RequestSubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Recording time';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deadline ends';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request content';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.RequestDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity code';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project Code';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of project';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request code';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.RequestCustomerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.RequestStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request status';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.RequestStatus', @FormID, @LanguageValue, @Language;

