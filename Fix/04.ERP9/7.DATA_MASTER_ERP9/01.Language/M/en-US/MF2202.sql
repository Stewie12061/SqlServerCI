-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2202- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF2202';

SET @LanguageValue = N'Container booking view';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Selection of multi sales orders';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.InheritSOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer name';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Country';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.CountryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Branch';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.Branch', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Container';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.Container', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales order';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.InheritVoucher', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Volume';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.CBM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TContainer booking information';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.SapXepCont', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Container booking details';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.ChiTietSapXepCont', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'MF2202.StatusID', @FormID, @LanguageValue, @Language
