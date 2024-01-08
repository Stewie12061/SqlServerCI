-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2019- PO
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
SET @FormID = 'POF2019';

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order number';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.OrderTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order status';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'GH days according to schedule';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.ScheduleFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Arrive';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.ScheduleToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'GH date upon request';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.RequireFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Arrive';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.RequireToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order date';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phone';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.ContactPersonTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order status';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.OrderStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Currency';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Petitioner';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.PaymentTermName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment methods';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.PaymentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Planning day';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.VoucherFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Arrive';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.VoucherToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of document';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Followers';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Contact';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.ContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Terms of payment';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment methods';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Exchange rate';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Client';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.ObjectName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Confirm delivery progress';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.ObjectConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'POF2019.LastModifyDate', @FormID, @LanguageValue, @Language;

