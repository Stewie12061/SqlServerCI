-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2055- SO
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
SET @FormID = 'SOF2055';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2055.SOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'天';
EXEC ERP9AddLanguage @ModuleID, 'SOF2055.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型';
EXEC ERP9AddLanguage @ModuleID, 'SOF2055.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'類型代碼';
EXEC ERP9AddLanguage @ModuleID, 'SOF2055.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'{0:00}次状態';
EXEC ERP9AddLanguage @ModuleID, 'SOF2055.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'SOF2055.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顧客姓名';
EXEC ERP9AddLanguage @ModuleID, 'SOF2055.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交货地址';
EXEC ERP9AddLanguage @ModuleID, 'SOF2055.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銷售訂單類型';
EXEC ERP9AddLanguage @ModuleID, 'SOF2055.ClassifyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'跟蹤者姓名';
EXEC ERP9AddLanguage @ModuleID, 'SOF2055.FullName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'追隨者';
EXEC ERP9AddLanguage @ModuleID, 'SOF2055.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'发票号码';
EXEC ERP9AddLanguage @ModuleID, 'SOF2055.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'合同簽訂日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2055.ContractDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨幣';
EXEC ERP9AddLanguage @ModuleID, 'SOF2055.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'汇率:';
EXEC ERP9AddLanguage @ModuleID, 'SOF2055.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'已减值原币金额';
EXEC ERP9AddLanguage @ModuleID, 'SOF2055.OriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交換';
EXEC ERP9AddLanguage @ModuleID, 'SOF2055.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'SOF2055.Notes', @FormID, @LanguageValue, @Language;

