-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1322- CI
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
SET @FormID = 'CIF1322';
SET @LanguageValue  = N'View detail voucher type'
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of document type';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Usage group';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VoucherGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Default value';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.IsDefault', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interpretation of documents';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Use document interpretation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.IsBDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Invoice interpretation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.BDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Use document interpretation';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.IsTDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Interpretation of accounting entries';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.TDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Debt account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.DebitAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account yes';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.CreditAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bank account';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse/Import warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Export warehouse';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ExWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bills';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VATTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'V.a.t tax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.IsVAT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S1Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S2Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S3Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Space';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.separator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.OutputLength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Display format';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.OutputOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Index of auto increase';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Separated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Set up auto increment code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Enabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Enabled1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Major';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Enabled2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Enabled3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reset auto-increment index';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.SetLastKey', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reset auto-increment index';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.IsSetLastKey', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table ID';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'General info';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ThongTinChung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Default info';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ThongTinMacDinh',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Code to increase auto info';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ThongTinMaTangTuDong',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Description',  @FormID, @LanguageValue, @Language;