-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1181- CI
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
SET @FormID = 'CIF1181';

SET @LanguageValue  = N'Update KIT'
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.Title',  @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm set code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.KITID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm set name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.KITName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gift code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.InventoryGiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gift name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.InventoryGiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The person who set it up';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1181.EmployeeName.CB',  @FormID, @LanguageValue, @Language;