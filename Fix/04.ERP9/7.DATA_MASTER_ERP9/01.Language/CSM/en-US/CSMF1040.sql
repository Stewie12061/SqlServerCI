declare @FormID VARCHAR(200), @Language VARCHAR(10), @ModuleID VARCHAR(MAX)
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
declare @LanguageValue NVARCHAR(4000),

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
SET @FormID = 'CSMF1040';

------- phần master
SET @LanguageValue = N'List of Des Product';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1040.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1040.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Des Product ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1040.DesProductID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contents of Des Product';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1040.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1040.ModelID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1040.Iscommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1040.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1040.ID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1040.Description.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1040.ModelID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model Name';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1041.ModelName.CB' , @FormID, @LanguageValue, @Language;