-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2021- SO
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
SET @FormID = 'SOF2021';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.QuotationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶程式碼';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'報價者';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售員';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.SalesManID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機會';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨幣';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'汇率:';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.QuotationNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.QuotationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.RefNo1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.RefNo2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.RefNo3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'標題';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Attention1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款碼';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Attention2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接收者';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Dear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Condition', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.SaleAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PurchaseAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'投票狀態';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'已SO';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.IsSO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯人';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯人';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'物品種類';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'截止日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'運輸工具';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交货地址';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支付方式';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款條件';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼01';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼02';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼03';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼04';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼05';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ApportionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'已確認';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.IsConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DescriptionConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.NumOfValidDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Varchar20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.QuotationStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼06';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼07';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼08';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼09';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼10';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Ana10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'價格表';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PriceListID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'繼承采購申請';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InheritPurchase', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.StatusMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'供應商報價之繼承';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InheritPOF2041', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'審核人之備註';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InheritNC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InheritKHCU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InformType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Factor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PlusCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.Revenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InternalShipCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TaxImport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CustomsCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CustomsInspectionCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TT_Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.LC_Open', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.LC_Receice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.WarrantyCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TaxFactor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TaxFactor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TaxCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.GuestsCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.SurveyCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PlusSaleCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'折扣';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DiscountAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TotalCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ProfileCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.TotalCoefficient', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'估計之繼承';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InheritEstimates', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'價格計算表的繼承';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InheritBoardPricing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.OldTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ContactorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'位置';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機會';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InheritOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'晉升';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PromoteIDList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨幣';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'物品種類';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支付方式';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.PaymentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.ItemTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'折扣總額';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.DiscountTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'增值稅總額';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.VATTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2021.OrderTotal', @FormID, @LanguageValue, @Language;

