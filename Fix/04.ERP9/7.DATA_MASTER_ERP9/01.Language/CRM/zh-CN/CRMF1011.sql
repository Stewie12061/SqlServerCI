-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1011- CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1011';

SET @LanguageValue = N'客戶姓名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'稅號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'解釋';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'為組織（選擇：組織；不選擇：個人）';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.IsOrganize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'其他增值稅客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.IsVATAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'帶發票的交貨';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.IsInvoice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'允許的催收債務限額';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.ReCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼01';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.O01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'停止使用';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.IsUsing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'不顯示';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.IsCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分配';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.VATAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼02';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.O02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼03';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.O03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼04';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.O04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分析代碼05';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.O05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'網站';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Website', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'傳真';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Fax', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商業';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BillAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'國家';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BillCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'區域代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BillPostalCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'省/市';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BillCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'郡/縣';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BillDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'坊/社';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BillWard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'國家';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DeliveryCountryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'區域代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DeliveryPostalCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'省/市';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DeliveryCityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'郡/縣';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DeliveryDistrictID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'坊/社';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DeliveryWard', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.ConvertType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.InheritConvertID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'轉換人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.ConvertUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'轉化原因';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.CauseConverted', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'轉化的說明';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DescriptionConvert', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.ConvertTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類3';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'轉換人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.ConvertUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.LastAssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'沒有發生訂單的警告';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.WarningNoOrdersGenerated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Note1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.AssignedToUser', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.IsComfirmCustomers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.APKRel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.RelatedToID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.TableREL', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.RePaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.PaymentTermName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Tel1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Tel2', @FormID, @LanguageValue, @Language;

