-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2061C- SO
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
SET @FormID = 'SOF2061C';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.QuotationID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶程式碼';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'報價者';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售員';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.SalesManID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機會';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨幣';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'汇率:';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.QuotationNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.QuotationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.RefNo1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.RefNo2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.RefNo3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'標題';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Attention1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款碼';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Attention2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接收者';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Dear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Condition', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.SaleAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.PurchaseAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'投票狀態';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.IsSO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯人';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯人';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'物品種類';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'截止日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'運輸工具';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交货地址';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支付方式';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款條件';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼01';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼02';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼03';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼04';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼05';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ApportionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.IsConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.DescriptionConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.NumOfValidDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar07', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar08', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar09', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar10', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar11', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar12', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar13', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar14', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar15', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar16', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar17', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar18', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar19', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Varchar20', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.QuotationStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分支';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼07';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼08';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼09';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼10';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Ana10ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'價格表';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.PriceListID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'繼承采購申請';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InheritPurchase', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.StatusMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'供應商報價之繼承';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InheritPOF2041', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'審核人之備註';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'NC的繼承';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InheritNC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' KHCU的繼承';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InheritKHCU', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'報價類型';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InformType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'係數';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Factor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'增加的價值';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.PlusCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.Revenue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內部運費';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InternalShipCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'進口稅';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.TaxImport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'報關費';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.CustomsCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'海關檢查';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.CustomsInspectionCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'T/T費用';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.TT_Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'信用證開立';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.LC_Open', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收到信用證';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.LC_Receice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預付保修/合同支付/保修';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.WarrantyCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅務1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.TaxFactor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅務2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.TaxFactor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅金';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.TaxCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'接待';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.GuestsCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'調查';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.SurveyCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.PlusSaleCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.DiscountAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'總金額';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.TotalCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'檔案費用';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ProfileCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'總係數';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.TotalCoefficient', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InheritEstimates', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InheritBoardPricing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.OldTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ContactorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機會';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InheritOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.PromoteIDList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.PaymentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.ItemTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.DiscountTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.VATTotal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2061C.OrderTotal', @FormID, @LanguageValue, @Language;

