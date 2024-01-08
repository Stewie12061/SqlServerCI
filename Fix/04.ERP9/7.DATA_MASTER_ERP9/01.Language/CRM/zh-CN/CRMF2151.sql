-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2151- CRM
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
SET @FormID = 'CRMF2151';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分配';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通話日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.CallDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'來電號碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Source', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通話時長';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Duration', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'呼叫中心';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.DID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.TypeOfCall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Extend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'加載';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Download', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聽';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Play', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Add', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯繫';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'延長機';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.ExtendName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.RequestSupportID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支持請求';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.RequestSupportName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通話狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'通話類型';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.TypeOfCallName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.APKContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.APKAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.APKSupportRequiredID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'線索/聯繫';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.ContactOrLead', @FormID, @LanguageValue, @Language;

