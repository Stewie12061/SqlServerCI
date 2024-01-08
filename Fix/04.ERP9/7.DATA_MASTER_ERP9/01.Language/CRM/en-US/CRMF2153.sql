-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2153- OO
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
SET @FormID = 'CRMF2153';

SET @LanguageValue = N'Call History';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Call Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.CallDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Source';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.Source', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Destination';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.Destination', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duration';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.Duration', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.DID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Call';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.TypeOfCall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Extend';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.Extend', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Download';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.Download', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Play';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.Play', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.Add', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Extend';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.ExtendName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request Support';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.RequestSupportID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request Support';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.RequestSupportName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Call';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2153.TypeOfCallName', @FormID, @LanguageValue, @Language;

