-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1180- CI
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
SET @Language = 'en-US'; 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1180';
SET @LanguageValue  = N'Category KIT'
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm set code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.KITID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm set name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.KITName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gift code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.InventoryGiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gift name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.InventoryGiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The person who set it up';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1180.EmployeeName.CB',  @FormID, @LanguageValue, @Language;