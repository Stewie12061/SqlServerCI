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
SET @Language = 'zh-CN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2050';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機會代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機會名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售階段';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.StageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'戰略代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'價值';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.ExpectAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束的原因';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.CauseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備註';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索來源';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預計結束日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.ExpectedCloseDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成功的概率';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.Rate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'行動';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.NextActionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'行動日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.NextActionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.IsAddCalendar', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶姓名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.CauseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'行動名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.NextActionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.BusinessLinesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.SalesTagID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
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

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.OldTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.IsComfirmOpportunity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.APKRel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2050.ImageID', @FormID, @LanguageValue, @Language;

