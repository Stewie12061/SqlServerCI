
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HF0405- OO
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
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF1012';

SET @LanguageValue = N'View Reason Deny';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1012.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1012.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason Deny ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1012.ReasonDenyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contents of Reason Deny';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1012.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1012.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1012.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1012.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create User ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1012.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create Date';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1012.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify User';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1012.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify Date'
EXEC ERP9AddLanguage @ModuleID, 'CSMF1012.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Info Reason Deny';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1012.Info' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1012.TabCRMT00003' , @FormID, @LanguageValue, @Language;