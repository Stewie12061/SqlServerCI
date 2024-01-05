-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2082- SO
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
SET @FormID = 'SOF2082';

SET @LanguageValue = N'Production detail view';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.DeliveryAddressName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery time';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Paper type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order quantity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print number';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size/Length';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size/Width';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size/Height';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Side 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print color of side 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Side 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print color of side 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production quantity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.OffsetQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File export date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.FilmStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loss';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percent loss (%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of product';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance of order';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.InheritOT2001', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.FilmStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approving status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of approver';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approving status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print method';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ApprovePerson01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approver';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ApprovePerson01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.InheritAPKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.InheritAPKDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.APKSOT2081', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sample content';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ContentSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sample color';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ColorSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sample signed';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.MTSignedSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File Length';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.FileLength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File Width';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.FileWidth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sum';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.FileSum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Include';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Include', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.TableInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Semi-product';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.SemiProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of delivery';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.DeliveryNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approving wave status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ApproveCutRollStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approving cut roll status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.ApproveWaveStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.FileUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.APKInherit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assembly from semi-product';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Assemble', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.SemiProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.VoucherAssemble', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.InventoryAssemble', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.AssembleValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Routing';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.RoutingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Display name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kind';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.KindSuppliers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kind name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Size', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cut';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Cut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Child/set';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Child', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print method';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Paper run';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.RunPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Wave';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.RunWavePaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Split';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.SplitSheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.MoldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.MoldDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative (Gsm)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Gsm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative (Sheets)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Sheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative (Ram)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Ram', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative (Kg)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Kg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative (M2)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.M2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'General information';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Infor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product information';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.InforProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Produce information';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.InforOffset', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.TabCRMT90031', @FormID, @LanguageValue, @Language;
											
SET @LanguageValue = N'Attachment';			
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.TabCRMT00002', @FormID, @LanguageValue, @Language;
											
SET @LanguageValue = N'History'; 			
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.TabCRMT00003', @FormID, @LanguageValue, @Language;

-- Đình Hòa [17/06/2021] : Bổ sung ngôn ngữ
SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2082.Quantity', @FormID, @LanguageValue, @Language;
