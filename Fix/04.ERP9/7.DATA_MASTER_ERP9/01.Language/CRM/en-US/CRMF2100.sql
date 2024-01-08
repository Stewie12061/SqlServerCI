-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2100- CRM
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
SET @FormID = 'CRMF2100';

SET @LanguageValue = N'List of customer request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information receiver';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information receiver';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Market ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.MarketID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product note';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.ProductQuality', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Width';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Height';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print size';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.PrintSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cut';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.CutSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.LengthPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Width';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.WidthPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity of product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Side 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of colors for side 1 printing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Side 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of colors for side 2 printing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery schedule';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.FromDeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment deadline';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.PaymentTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Freight (vehicle engagement)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.TransportAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.IsContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Percentage';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.Percentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other notes';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CD disk';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.IsDiscCD', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory sample';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.IsSampleInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email sample';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.IsSampleEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Film';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.IsFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory/Print No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.InvenPrintSheet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory/Mold No';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.InvenMold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.Pack', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Offset paper';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.OffsetPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Offset paper';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.OffsetPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print number';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Other processing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.OtherProcessing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Film date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.LengthFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Width';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.WidthFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Film status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.StatusFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.StatusMold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Design';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.Design', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Zen suppo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.IsZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Length';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.LengthZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Width';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.WidthZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of product';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.PaperTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of colors for side 1 printing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.ColorPrint01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of colors for side 2 printing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.ColorPrint02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Film status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.StatusFilmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mold status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.StatusMoldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business lines';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.BusinessLinesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.DeliveryMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packing method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.PackingMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Pallet request';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.PalletRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Used in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.UsedIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of contents in box/container';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.QuantityInBox', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Load';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bearing strength';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.Bearingstrength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Humidity';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.Humidity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Podium';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.Podium', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'BCT bearing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.BearingBCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ECT edge compression';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.EdgeCompressionECT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Preferred value';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.PreferredValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Design file name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Box type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.BoxType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sample content';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.SampleContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Color sample';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.ColorSample', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.FieldDeliveryMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.FieldPackingMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.FieldUsedIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Delivery method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.DeliveryMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Packing method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.PackingMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Used in';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.UsedInName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.PaymentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Print method';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2100.PrintTypeName', @FormID, @LanguageValue, @Language;

