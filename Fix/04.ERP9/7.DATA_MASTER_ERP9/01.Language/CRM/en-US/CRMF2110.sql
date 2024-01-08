-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2110- CRM
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
SET @FormID = 'CRMF2110';

SET @LanguageValue = N'Cost estimate';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost estimate No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost estimate date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total variable fee';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.TotalVariableFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.PercentCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total cost';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profit (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.PercentProfit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total profit';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.Profit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.DeliveryAddressName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery time';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ordering quantity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print number';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size/Length';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size/Width';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size/Height';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Side  1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print color of side 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Side 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print color of side 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity of production';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.OffsetQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File export date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.FilmStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount of loss';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loss (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.InvenUnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'M2 price';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.SquareMetersPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of currency';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.InheritCRMT2100', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified User';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.FilmStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of approver';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approval status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost estimate voucher';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.InheritCRMT2110', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Content sample';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.ContentSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Color sample';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.ColorSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MT Signed Sample  ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.MTSignedSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File/print size (long)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.FileLength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File/print size (wide)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.FileWidth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ctp file/print size';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.FileSum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Include';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.Include', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.TableInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Semi-product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.SemiProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2110.FileUnitID', @FormID, @LanguageValue, @Language;

