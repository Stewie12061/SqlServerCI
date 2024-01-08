-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2017- PO
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
SET @Language = 'zh-CN' 
SET @ModuleID = 'PO';
SET @FormID = 'POF2017';

SET @LanguageValue = N'命令';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'類型代碼';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂單類型';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.OrderTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂單狀態';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'按進度的發貨日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.ScheduleFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到達';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.ScheduleToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'按要求的發貨日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.RequireFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到達';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.RequireToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'天';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.ContactPersonTel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂單狀態';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.OrderStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨幣';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯絡人';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'追隨者';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款條件';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.PaymentTermName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支付方式';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.PaymentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'天';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.VoucherFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到達';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.VoucherToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.ContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.ObjectName1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.ObjectConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2017.LastModifyDate', @FormID, @LanguageValue, @Language;

