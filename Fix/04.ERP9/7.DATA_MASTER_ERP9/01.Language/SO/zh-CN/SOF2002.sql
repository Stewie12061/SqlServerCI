-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2002- SO
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
SET @FormID = 'SOF2002';

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'類型代碼';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'追隨者';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'天';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'帶發票交貨';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.IsInvoice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.SOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯人';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'緊急級別';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ImpactLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.IsConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'物品種類';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'汇率:';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂單狀態';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'增值稅客戶';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VATObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨幣';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'增值稅客戶';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VATObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'送貨路線';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.RouteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'列印狀態';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.IsPrinted', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'发票号码';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同簽訂日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂單PL';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售員';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.SalesManID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到期日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯絡人';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Contact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交货地址';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'運輸工具';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款條件';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支付方式';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅法';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.IsWholeSale', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TotalAfterAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'運輸費';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ShipAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.PayAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'享有 DS 折扣的金額';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DiscountSalesAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.IsInheritPO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼01';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼02';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼03';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼04';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼05';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DealerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.IsReceiveAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ChooseQuotationSaleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.OldTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.IsExportOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ContactorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售員';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.SalesManName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.PromoteIDList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ItemTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DiscountTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.VATTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.OrderTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.ReceiveAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.APKOT2003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.DiscountWalletTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2002.IsInheritSO_AP', @FormID, @LanguageValue, @Language;

