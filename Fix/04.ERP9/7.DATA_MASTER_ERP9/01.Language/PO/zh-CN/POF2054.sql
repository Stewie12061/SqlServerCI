-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2054- PO
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
SET @FormID = 'POF2054';

SET @LanguageValue = N'延遲收到的訂單清單';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.POrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'天';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'類型代碼';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'{0:00}次状態';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顧客姓名';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收貨地址';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.ReceivedAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售訂單類型';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.ClassifyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'跟蹤者姓名';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.FullName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'追隨者';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'发票号码';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同簽訂日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.ContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨幣';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'汇率:';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'已减值原币金额';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.OriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交換';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'POF2054.Notes', @FormID, @LanguageValue, @Language;

