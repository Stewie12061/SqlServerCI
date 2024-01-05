-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2102- CRM
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
SET @FormID = 'CRMF2102';

SET @LanguageValue = N'Customer request details';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information receiver';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information receiver';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Market ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.MarketID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ProductQuality', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Width';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Height';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print size';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PrintSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cut';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.CutSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.LengthPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Width';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.WidthPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity of product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Side 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of colors for side 1 printing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Side 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of colors for side 2 printing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery schedule';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.FromDeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment deadline';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PaymentTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Freight (vehicle engagement)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.TransportAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percentage';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Percentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other notes';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CD disk';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsDiscCD', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory sample';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsSampleInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email sample';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsSampleEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Film';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory/Print No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.InvenPrintSheet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory/Mold No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.InvenMold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Pack', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Offset paper';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.OffsetPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Offset paper';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.OffsetPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print number';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other processing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.OtherProcessing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Film date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.LengthFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Width';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.WidthFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Film status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.StatusFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.StatusMold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Design';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Design', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Zen suppo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.LengthZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Width';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.WidthZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PaperTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of colors for side 1 printing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ColorPrint01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of colors for side 2 printing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ColorPrint02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Film status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.StatusFilmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.StatusMoldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.BusinessLinesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DeliveryMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packing method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PackingMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Pallet request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PalletRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Used in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.UsedIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of contents in box/container';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.QuantityInBox', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Load';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bearing strength';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Bearingstrength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Humidity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Humidity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Podium';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Podium', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' BCT bearing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.BearingBCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ECT edge compression';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.EdgeCompressionECT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Preferred value';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PreferredValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Design file name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Box type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.BoxType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sample content';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.SampleContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Color sample';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ColorSample', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.FieldDeliveryMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.FieldPackingMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.FieldUsedIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DeliveryMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packing method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PackingMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Used in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.UsedInName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PaymentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.InformationRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request details';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DetailRequirements', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Process information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.TabCRMT2104', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Additional information';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.AdditionalInformation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.TabCRMT90031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.TabCRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.TabCRMT00003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Routing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.RoutingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.NodeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.NodeTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.NodeTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PhaseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PhaseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Display name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kind';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Size', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cut';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Cut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Child/set';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Child', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit/set';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.UnitSizeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.UnitSizeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.UnitSizeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Papper run';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.RunPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Wave';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.RunWavePaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.MoldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.MoldDate', @FormID, @LanguageValue, @Language;
