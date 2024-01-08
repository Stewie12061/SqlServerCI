-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2153- CRM
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
SET @FormID = 'CRMF2153';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分配';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通話日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.CallDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'來電號碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.Source', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通話時長';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.Duration', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'呼叫中心';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.DID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.TypeOfCall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.Extend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'下載';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.Download', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.Play', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.Add', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯繫';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'延長機';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.ExtendName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.RequestSupportID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.RequestSupportName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通話狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通話類型';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.TypeOfCallName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.APKContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.APKAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.APKSupportRequiredID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.ContactOrLead', @FormID, @LanguageValue, @Language;

