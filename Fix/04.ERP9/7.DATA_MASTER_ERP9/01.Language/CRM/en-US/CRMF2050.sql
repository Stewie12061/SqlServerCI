-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2050- CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2050';

SET @LanguageValue = N'List of opportunities';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sale stage';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.StageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Value';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.ExpectAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason for ending';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.CauseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'In-charge person ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead source';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected end date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.ExpectedCloseDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Probability of success';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.Rate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Action';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.NextActionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Action date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.NextActionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Action added to calendar';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.IsAddCalendar', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason for ending';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.CauseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Action';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.NextActionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.BusinessLinesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Key word';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.SalesTagID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.RelColumn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.RelatedToID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.TableREL', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.btnEdit_TabInventory', @FormID, @LanguageValue, @Language;

