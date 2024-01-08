
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
SET @FormID = 'CSMF1062';

SET @LanguageValue = N'View Service Type';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1062.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1062.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Service Type ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1062.ServiceTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Service Type Name';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1062.ServiceTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1062.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1062.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1062.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create User ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1062.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create Date';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1062.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify User ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1062.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify Date';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1062.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Info Service Type';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1062.Info' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1062.TabCRMT00003' , @FormID, @LanguageValue, @Language;