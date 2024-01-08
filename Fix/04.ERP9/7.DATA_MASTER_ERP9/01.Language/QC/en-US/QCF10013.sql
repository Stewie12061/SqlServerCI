-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF10013- QC
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
SET @FormID = 'QCF10013';

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF10013.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'QCF10013.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'QCF10013.BatchInventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number';
EXEC ERP9AddLanguage @ModuleID, 'QCF10013.BatchNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Item code';
EXEC ERP9AddLanguage @ModuleID, 'QCF10013.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name items';
EXEC ERP9AddLanguage @ModuleID, 'QCF10013.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Votes';
EXEC ERP9AddLanguage @ModuleID, 'QCF10013.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day';
EXEC ERP9AddLanguage @ModuleID, 'QCF10013.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shift';
EXEC ERP9AddLanguage @ModuleID, 'QCF10013.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine';
EXEC ERP9AddLanguage @ModuleID, 'QCF10013.MachineName', @FormID, @LanguageValue, @Language;

