-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2162- CRM
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
SET @FormID = 'CRMF2162';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.SupportRequiredID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.SupportRequiredName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發生時間';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束時間';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯繫';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發行版本';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.ReleaseVerion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'描述';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'修理人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更正日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯繫';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求類型';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.TypeOfRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.LastPriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.LastStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.HomeMobile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.HomeTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.BusinessTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.BusinessFax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.ActualStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.ActualEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.ActualTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.SupportDictionaryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支持詞典';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.SupportDictionaryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'質量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.StatusQualityOfWork', @FormID, @LanguageValue, @Language;

