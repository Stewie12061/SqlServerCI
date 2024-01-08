
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
SET @FormID = 'CSMF1042';

SET @LanguageValue = N'View Des Product';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1042.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1042.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Des Product ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1042.DesProductID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contents of Des Product';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1042.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1040.ModelID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1042.Iscommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1042.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create User';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1042.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create Date';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1042.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify User';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1042.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Las tModify Date';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1042.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Info Des Product';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1042.Info' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1042.TabCRMT00003' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1040.ModelID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model Name';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1041.ModelName.CB' , @FormID, @LanguageValue, @Language;