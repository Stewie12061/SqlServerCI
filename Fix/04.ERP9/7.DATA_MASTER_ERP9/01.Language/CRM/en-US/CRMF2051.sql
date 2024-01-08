-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2051- CRM
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
SET @FormID = 'CRMF2051';

SET @LanguageValue = N'Update opportunity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Opportunity name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sale stage';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.StageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Value';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.ExpectAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason for ending';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.CauseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'In-charge person ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lead source';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expected end date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.ExpectedCloseDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Probability of success';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.Rate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Action';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.NextActionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Action date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.NextActionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Action added to calendar';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.IsAddCalendar', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason for ending';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.CauseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Action';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.NextActionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business Lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.BusinessLinesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Key word';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.SalesTagID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Campaign';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.RelColumn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.RelatedToID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.TableREL', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.btnEdit_TabInventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.StageID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Next action ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.NextActionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cause ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.CauseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Source';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.SourceID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Stage name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.StageName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Action name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.NextActionName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cause name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.CauseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Source name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.SourceName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.AreaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Area name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.AreaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.BusinessLinesID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business lines name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2051.BusinessLinesName.CB', @FormID, @LanguageValue, @Language;

