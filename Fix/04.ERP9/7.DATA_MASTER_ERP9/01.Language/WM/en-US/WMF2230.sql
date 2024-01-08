-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2230- WM
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
SET @FormID = 'WMF2230';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Accounting date';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.OrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Import warehouse';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.ImWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Export warehouse';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.ExWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.KindVoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voting maker';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sectors';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.RefNo01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.RefNo02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object name';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of founder';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2230.VoucherNoSOderID', @FormID, @LanguageValue, @Language;

