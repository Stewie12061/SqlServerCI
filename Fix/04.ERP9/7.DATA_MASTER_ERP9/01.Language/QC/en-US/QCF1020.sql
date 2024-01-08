-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF1020- QC
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
SET @ModuleID = 'QC';
SET @FormID = 'QCF1020';

SET @LanguageValue = N'List of standard definitions';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Items';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.InventoryIDSearch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item code';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name items';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 01';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.Notes01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mark';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.Notes02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes 03';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.Notes03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.UpdateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.ChooseImage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.InventoryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'QCF1020.InventoryName.CB', @FormID, @LanguageValue, @Language;
