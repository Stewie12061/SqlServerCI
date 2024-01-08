-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2231- WM
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
SET @FormID = 'WMF2231';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounting date';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.OrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Import warehouse';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ImWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Export warehouse';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ExWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.KindVoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voting maker';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sectors';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue =N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reference code 1';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.RefNo01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Reference code 2';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.RefNo02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voting maker';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order number';
EXEC ERP9AddLanguage @ModuleID, 'WMF2231.VoucherNoSOderID', @FormID, @LanguageValue, @Language;

