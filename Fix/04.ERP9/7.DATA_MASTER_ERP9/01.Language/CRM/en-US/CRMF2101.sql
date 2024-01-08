-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2101- CRM
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
SET @Language = 'vi-VN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2101';

SET @LanguageValue = N'Customer request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information receiver';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information receiver';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Market ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.MarketID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ProductQuality', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Width';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Height';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print size';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PrintSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cut';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.CutSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.LengthPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Width';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.WidthPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity of product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Side 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of colors for side 1 printing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Side 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of colors for side 2 printing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery schedule';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.FromDeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment deadline';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaymentTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Freight (vehicle engagement)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.TransportAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percentage';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Percentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other notes';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CD disk';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsDiscCD', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory sample';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsSampleInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email sample';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsSampleEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Film';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory/Print No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.InvenPrintSheet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory/Mold No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.InvenMold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Pack', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Offset paper';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.OffsetPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Offset paper';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.OffsetPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print number';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other processing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.OtherProcessing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Film date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.LengthFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Width';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.WidthFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Film status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.StatusFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.StatusMold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Design';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Design', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Zen suppo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.LengthZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Width';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.WidthZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaperTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of colors for side 1 printing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ColorPrint01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of colors for side 2 printing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ColorPrint02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Film status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.StatusFilmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.StatusMoldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.BusinessLinesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.BusinessLinesID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Field';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.BusinessLinesName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.DeliveryMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packing method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PackingMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Pallet request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PalletRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Used in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.UsedIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of contents in box/container';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.QuantityInBox', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Load';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bearing strength';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Bearingstrength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Humidity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Humidity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Podium';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Podium', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'BCT bearing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.BearingBCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ECT edge compression';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.EdgeCompressionECT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Preferred value';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PreferredValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Design file name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Box type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.BoxType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sample content';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.SampleContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Color sample';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ColorSample', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.FieldDeliveryMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.FieldPackingMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.FieldUsedIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.DeliveryMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packing method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PackingMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Used in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.UsedInName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaymentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PrintTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PrintTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Routing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.RoutingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.NodeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.NodeTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.NodeTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PhaseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PhaseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Display name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kind';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.KindSupplierName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Size';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Size', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cut';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Cut', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Child/set';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Child', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit/set';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.UnitSizeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.UnitSizeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.UnitSizeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Papper run';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.RunPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Wave';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.RunWavePaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.MoldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.MoldDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaymentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaymentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.AnaName.CB', @FormID, @LanguageValue, @Language;