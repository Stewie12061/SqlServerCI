-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1320- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1320';
SET @LanguageValue  = N'List of voucher type'
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of document type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Usage group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VoucherGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Default value';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.IsDefault', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interpretation of documents';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Use document interpretation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.IsBDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Invoice interpretation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.BDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Use document interpretation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.IsTDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interpretation of accounting entries';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.TDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Debt account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.DebitAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account yes';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.CreditAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse/Import warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Export warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.ExWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bills';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VATTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'V.a.t tax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.IsVAT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S1Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S2Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S3Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Space';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.separator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.OutputLength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Display format';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.OutputOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Index of auto increase';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Separated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Set up auto increment code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reset auto-increment index';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Enabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Enabled1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Major';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.ScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Enabled2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Enabled3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Index of auto increas';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.SetLastKey', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reset auto-increment index';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.IsSetLastKey', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.TableID', @FormID, @LanguageValue, @Language;

