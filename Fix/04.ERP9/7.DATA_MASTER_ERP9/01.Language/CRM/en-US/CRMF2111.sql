-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2111- CRM
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
SET @FormID = 'CRMF2111';

SET @LanguageValue = N'Update cost estimate';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost estimate No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost estimate date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total variable fee';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.TotalVariableFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PercentCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total cost';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profit (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PercentProfit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total profit';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Profit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.DeliveryAddressName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery time';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ordering quantity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print number';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size/Length';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size/Width';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size/Height';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Side  1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print color of side 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Side 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print color of side 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity of production';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.OffsetQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File export date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FilmStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount of loss';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loss (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.InvenUnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'M2 price';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SquareMetersPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of currency';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.InheritCRMT2100', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified User';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FilmStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of approver';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost estimate voucher';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.InheritCRMT2110', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content sample';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ContentSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Color sample';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ColorSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MT Signed Sample  ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.MTSignedSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File/print size (long)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FileLength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File/print size (wide)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FileWidth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ctp file/print size';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FileSum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Include';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Include', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.TableInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Semi-product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SemiProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FileUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Routing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.RoutingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PhaseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PhaseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Display name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kind';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.KindSuppliers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kind name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PrintTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PrintTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Size', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cut';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Cut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Child/set';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Child', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Paper run';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.RunPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Wave';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.RunWavePaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Split';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SplitSheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.MoldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.MoldDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative (Gsm)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Gsm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative (Sheets)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Sheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative (Ram)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Ram', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative (Kg)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Kg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative (M2)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.M2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount loss';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percent long (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.DeliveryAddressID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.DeliveryAddressName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PaperTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PaperTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Code.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PrintTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PrintTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.RunPaperID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.RunPaperName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.CurrencyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.CurrencyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.DisplayName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Include';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Include', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity run wave';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.QuantityRunWave', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit/set';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.UnitSizeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.UnitSizeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.UnitSizeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase order';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PhaseOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Semi-product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SemiProduct.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Semi-product name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SemiProductName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.UnitPrice.CB', @FormID, @LanguageValue, @Language;