-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2150- CRM
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
SET @FormID = 'CRMF2150';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通話日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.CallDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'來電號碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.Source', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通話時長';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.Duration', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'呼叫中心';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.DID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通話類型';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.TypeOfCall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'延長機';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.Extend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通話狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'請求狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'加載';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.Download', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聽';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.Play', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備註';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.Add', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯繫';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯繫';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'延長機';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.ExtendName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支持請求';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.RequestSupportID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支持請求';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.RequestSupportName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通話狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通話類型';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.TypeOfCallName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.APKContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.APKAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.APKSupportRequiredID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索/聯繫';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2150.ContactOrLead', @FormID, @LanguageValue, @Language;

