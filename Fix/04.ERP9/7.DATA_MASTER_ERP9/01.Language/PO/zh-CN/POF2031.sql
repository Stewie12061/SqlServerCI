-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2031- PO
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
SET @FormID = 'POF2031';

SET @LanguageValue = N'更新采購申請單';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程式碼';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ROrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨幣';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'彙率';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收貨地址';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ReceivedAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'{0:00}次状態';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'運輸工具';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Transport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'支付方式';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要貨的日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'发票号码';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同簽訂日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到期日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.DueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先級';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'追隨者';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.CurrencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.PaymentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.OrderStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'從項目繼承采購申請';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.InheritPurchareOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'審批者級別';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.LinkPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'天';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.RequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'報價要求';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.RequestName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'審核人之備註';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2031.OldTaskID', @FormID, @LanguageValue, @Language;

