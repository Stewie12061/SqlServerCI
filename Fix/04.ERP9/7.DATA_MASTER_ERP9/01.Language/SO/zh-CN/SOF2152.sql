﻿-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2152- SO
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF2152';

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'類型代碼';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'追隨者';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'天';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'帶發票交貨';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.IsInvoice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.SOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯人';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'緊急級別';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.ImpactLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.IsConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'物品種類';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'汇率:';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂單狀態';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'增值稅客戶';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.VATObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨幣';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'增值稅客戶';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.VATObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'送貨路線';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.RouteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'列印狀態';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.IsPrinted', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'发票号码';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同簽訂日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.ContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂單PL';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售員';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.SalesManID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到期日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯絡人';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.Contact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交货地址';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'運輸工具';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款條件';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支付方式';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅法';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.IsWholeSale', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.TotalAfterAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'運輸費';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.ShipAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.PayAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'享有 DS 折扣的金額';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.DiscountSalesAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.IsInheritPO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼01';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼02';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼03';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼04';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼05';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.DealerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.IsReceiveAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.ChooseQuotationSaleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.OldTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.IsExportOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.ContactorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售員';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.SalesManName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.PromoteIDList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.ItemTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.DiscountTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.VATTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.OrderTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.ReceiveAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.APKOT2003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.DiscountWalletTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2152.IsInheritSO_AP', @FormID, @LanguageValue, @Language;

