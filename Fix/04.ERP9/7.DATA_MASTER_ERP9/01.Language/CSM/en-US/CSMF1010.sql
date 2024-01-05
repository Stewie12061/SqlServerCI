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
SET @FormID = 'CSMF1010';

------- phần master
SET @LanguageValue = N'List of Reason Deny';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1010.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1010.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reason Deny ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1010.ReasonDenyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contents of Reason Deny';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1010.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1010.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1010.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1010.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1010.ID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CSMF1010.Description.CB' , @FormID, @LanguageValue, @Language;