-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2060- PO
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
SET @ModuleID = 'PO';
SET @FormID = 'POF2060';

SET @LanguageValue = N'Container booking for export order';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Votes';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day vouchers';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loading';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.PackedTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date of department';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.DepartureDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The day arrives';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.ArrivalDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Port';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.PortName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Closing time';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.ClosingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Consignee';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.Forwarder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Carriers';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.ShipBrand', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Container quantity';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.ContQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.DatePeriodPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.DivisionIDPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Carriers';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.ShipBrandPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Port';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.PortNamePOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.VoucherNoPOF2060', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2060.DeleteFlag', @FormID, @LanguageValue, @Language;

