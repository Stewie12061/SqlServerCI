-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2112- CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2112';

SET @LanguageValue = N'Cost estimate view';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost estimate No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost estimate date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total variable fee';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.TotalVariableFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PercentCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total cost';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profit (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PercentProfit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total profit';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Profit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.DeliveryAddressName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery time';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ordering quantity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print number';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size/Length';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size/Width';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size/Height';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Side  1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print color of side 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Side 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print color of side 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity of production';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.OffsetQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File export date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FilmStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount of loss';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loss (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InvenUnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'M2 price';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.SquareMetersPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of currency';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InheritCRMT2100', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified User';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FilmStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of approver';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost estimate voucher';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InheritCRMT2110', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content sample';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ContentSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Color sample';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ColorSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MT Signed Sample  ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.MTSignedSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File/print size (long)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FileLength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File/print size (wide)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FileWidth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ctp file/print size';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FileSum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Include';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Include', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.TableInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Semi-product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.SemiProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FileUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kind';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.KindSuppliers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kind name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Split';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.SplitSheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percent loss (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Infor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InforProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Produce information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InforOffset', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.TabCRMT90031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.TabCRMT00003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Variable fee information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InforTotalVariableFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Size', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cut';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Cut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Child';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Child', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit/set';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.UnitSizeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Paper run';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.RunPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Wave';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.RunWavePaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity run wave';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.QuantityRunWave', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.MoldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.MoldDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative (Gsm)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Gsm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative  (Sheets)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Sheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative (Ram)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Ram', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative  (Kg)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Kg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative (M2)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.M2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase order';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PhaseOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Semi-product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.SemiProductName', @FormID, @LanguageValue, @Language;