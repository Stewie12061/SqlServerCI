-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2005- WM
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
SET @ModuleID = 'WM';
SET @FormID = 'WMF2005';

SET @LanguageValue = N'Output request';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.WMF2005Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher no';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contract';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Output warehouse ID';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.WarehouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.InputDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher type';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Total amount';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.ImWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.ImWareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.ExWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Output warehouse';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.ExWareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reference code 1';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.RefNo01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reference code 2';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.RefNo02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.ContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.RDAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.CheckPurchase', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.LastModifyUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse ID';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.WareHouseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Warehouse name';
EXEC ERP9AddLanguage @ModuleID, 'WMF2005.WareHouseName.CB', @FormID, @LanguageValue, @Language;