-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2081- WM
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
SET @FormID = 'SOF2081';

SET @LanguageValue = N'Update production detail';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DeliveryAddressName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery time';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Paper type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of orders';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print number';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size/Length';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size/Width';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size/Height';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Side 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print color of side 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Side 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print color of side 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production quantity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.OffsetQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File export date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.FilmStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loss';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percent loss (%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of product';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit sales orders';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.InheritOT2001', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.FilmStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reviewer''s comments';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approving status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print method';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApprovePerson01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approved by';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApprovePerson01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.InheritAPKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.InheritAPKDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.APKSOT2081', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sample content';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ContentSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sample color';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ColorSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sample signed';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.MTSignedSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File Length';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.FileLength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File Width';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.FileWidth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sum';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.FileSum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Include';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Include', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.TableInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Semi-product';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.SemiProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery notes';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DeliveryNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approving wave status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApproveCutRollStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Approving cut roll status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ApproveWaveStatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.FileUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.APKInherit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assembly from semi-product';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Assemble', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.SemiProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.VoucherAssemble', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.InventoryAssemble', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.AssembleValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.APK_BomVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note of delivery';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DeliveryNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Routing';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.RoutingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Display name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kind';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.KindSuppliers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kind name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit price';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Amount';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Amount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Size', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cut';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Cut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Child/set';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Child', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print method';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Paper run';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.RunPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Wave';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.RunWavePaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Split';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.SplitSheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.MoldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold date';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.MoldDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative (Gsm)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Gsm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative (Sheets)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Sheets', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative (Ram)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Ram', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative (Kg)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Kg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative (M2)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.M2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DeliveryAddressID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.DeliveryAddressName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Paper type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PaperTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PaperTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Code.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PrintTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PrintTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.RunPaperID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Paper run';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.RunPaperName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Analysis';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.UnitSizeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.UnitSizeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.SemiProduct.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Semi-product';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.SemiProductName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PhaseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'SOF2081.PhaseName.CB', @FormID, @LanguageValue, @Language;
