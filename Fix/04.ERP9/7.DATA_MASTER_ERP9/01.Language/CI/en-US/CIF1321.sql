-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1321- CI
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
SET @FormID = 'CIF1321';

SET @LanguageValue  = N'Update voucher info'
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of document type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Usage group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VoucherGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Default value';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsDefault', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interpretation of documents';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Use document interpretation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsBDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Invoice interpretation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.BDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Use document interpretation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsTDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interpretation of accounting entries';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.TDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Debt account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.DebitAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account yes';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CreditAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse/Import warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Export warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ExWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bills';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VATTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'V.a.t tax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsVAT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S1Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S2Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S3Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Space';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.separator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.OutputLength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Display format';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.OutputOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Index of auto increase';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Separated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Set up auto increment code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reset auto-increment index';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Enabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Enabled1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Major';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Enabled2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Enabled3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Index of auto increase';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.SetLastKey', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reset auto-increment index';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsSetLastKey', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VoucherGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VoucherGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CurrencyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Currency name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CurrencyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Warehouse ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.WareHouseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Warehouse name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.WareHouseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.AccountID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.AccountName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Type ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VATTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Type name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VATTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.BankAccountID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Account name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.BankAccountName.CB',  @FormID, @LanguageValue, @Language;
SET @LanguageValue  = N'General info';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ThongTinChung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Default info';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ThongTinMacDinh',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Code to increase auto info';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ThongTinMaTangTuDong',  @FormID, @LanguageValue, @Language;
