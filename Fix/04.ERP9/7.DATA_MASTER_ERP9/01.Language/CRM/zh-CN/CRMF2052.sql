-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2052- CRM
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
SET @FormID = 'CRMF2052';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機會代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機會名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售階段';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.StageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'戰略';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CampaignID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'價值';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.ExpectAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束的原因';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CauseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備註';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索來源';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'開始日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預計結束日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.ExpectedCloseDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成功的概率';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.Rate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'行動';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.NextActionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'行動日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.NextActionDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'添加到日曆的操作';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.IsAddCalendar', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商業';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類3';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束的原因';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CauseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'行動';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.NextActionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商業';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.BusinessLinesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'關鍵詞';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.SalesTagID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'戰略';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'執行者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.RelColumn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.RelatedToID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.TableREL', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.btnEdit_TabInventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.OldTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.IsComfirmOpportunity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.APKRel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2052.ImageID', @FormID, @LanguageValue, @Language;

