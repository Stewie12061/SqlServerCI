
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
SET @FormID = 'CSMF1052';

SET @LanguageValue = N'View VMI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1052.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1052.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VMI ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1052.VMIID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1052.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1052.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1052.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1052.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create User';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1052.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create Date';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1052.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify User';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1052.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify Date';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1052.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Info VMI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1052.Info' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1052.TabCRMT00003' , @FormID, @LanguageValue, @Language;