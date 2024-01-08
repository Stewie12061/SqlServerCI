-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2151- OO
-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ
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
SET @FormID = 'CRMF2151';

SET @LanguageValue = N'Call History';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Call Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.CallDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Source';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Source', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Destination';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duration';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Duration', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.DID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Call';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.TypeOfCall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Extend';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Extend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Download';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Download', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Play';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Play', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.Add', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Extend';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.ExtendName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request Support';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.RequestSupportID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request Support';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.RequestSupportName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Call';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2151.TypeOfCallName', @FormID, @LanguageValue, @Language;

