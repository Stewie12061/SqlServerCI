-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2080- WM
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF2080';

SET @LanguageValue = N'List of production details';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.DeliveryAddressName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery time';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Paper type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order quantity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print number';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size/Length';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size/Width';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size/Height';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Side 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print color of side 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Side 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print color of side 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production quantity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.OffsetQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File export date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.FilmStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loss';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percent loss (%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of product';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of order';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.InheritOT2001', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.FilmStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Browsing status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of approver';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Browsing status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print method';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.ApprovePerson01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approver';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.ApprovePerson01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.InheritAPKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.InheritAPKDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.APKSOT2081', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.ContentSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.ColorSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.MTSignedSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.FileLength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.FileWidth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.FileSum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Include';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.Include', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.TableInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Semi-product';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.SemiProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of delivery';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.DeliveryNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approving wave status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.ApproveCutRollStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approving cut roll status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.ApproveWaveStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.FileUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.APKInherit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assembly from semi-product';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.Assemble', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.SemiProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.VoucherAssemble', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.InventoryAssemble', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.AssembleValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2080.APK_BomVersion', @FormID, @LanguageValue, @Language;

