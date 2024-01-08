-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF0090- S
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
SET @ModuleID = 'S';
SET @FormID = 'SF0090';

SET @LanguageValue = N'移交工作';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交接人';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.HandoverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交接接受者';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.ReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作狀態';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.TaskStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'問題狀態';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.IssueStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'主要的';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.ListBusiness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.HandoverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.ReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'里程碑狀態';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.MilestoneStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統代碼';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'領先狀態';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.LeadStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機會狀態';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.OpportunityStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'活動狀態';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.CampaignStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求狀態';
EXEC ERP9AddLanguage @ModuleID, 'SF0090.RequestStatus', @FormID, @LanguageValue, @Language;

