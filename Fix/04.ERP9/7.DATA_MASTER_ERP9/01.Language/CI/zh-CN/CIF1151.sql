-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1151- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1151';

SET @LanguageValue = N'更新對象';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'對象名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商誉';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.TradeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅法';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結構型式';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ObjectTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'省/市';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'國家';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'傳真';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'網站';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯絡人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Contactor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'联系电话';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Phonenumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'供應商';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsSupplier', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'往来';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsUpdateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'外幣種類';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'允许借款额';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ReCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款條件';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.RePaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'应付天数';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ReDueDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交货地址';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'允许的借款时间';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ReDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'关闭(停止销售)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsLockedOver', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'应收账款';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ReAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'允许借款额';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款條件';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaPaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'应付天数';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaDueDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'享受折扣天數';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaDiscountDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'折扣率';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaDiscountPercent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收貨地址';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ReAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'银行名称';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.BankName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'银行账户编号';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.BankAccountNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'许可证号码';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.LicenseNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注册资金';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.LegalCapital', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備注2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Note1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'區域';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.AreaID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'對象解析代碼1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.O01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'對象解析代碼2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.O02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'對象解析代碼3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.O03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'對象解析代碼4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.O04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'對象解析程代碼5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.O05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'应付账款';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'位置';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DutyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'經銷商';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsDealer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'國家';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'区码,区域名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryPostalCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'省/市';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'區';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'病房';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryWard', @FormID, @LanguageValue, @Language;

