------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2005 - CRM 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP fw
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2005';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Thêm nhanh khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.AccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.AccountName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Mã số thuế';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.VATNo' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Địa chỉ';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.Address' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Email';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.Email' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Tel';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.Tel' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Diễn Giải';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.Description' , @FormID, @LanguageValue, @Language;

 
 SET @LanguageValue = N'Ghi chú đường đi';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.Description01' , @FormID, @LanguageValue, @Language;


 SET @LanguageValue = N'Là tổ chức (Chọn: tổ chức; Không chọn: cá nhân)';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.IsOrganize' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Khách hàng VAT khác';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.IsVATAccountID' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Giao hàng kèm theo hóa đơn';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.IsInvoice' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Dùng chung';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.IsCommon' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Hạn mức nợ cho phép';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.ReCreditLimit' , @FormID, @LanguageValue, @Language;

   SET @LanguageValue = N'Mã phân tích 05';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.O05ID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Mã';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.AnaID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.AnaName' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Nhãn hiệu 01';
 EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.Description02' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Nhãn hiệu 02';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.Description03' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Nhãn hiệu 03';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.Description04' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Nhãn hiệu 04';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.Description05' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 01';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.O01ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã phân tích 02';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.O02ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã phân tích 03';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.O03ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã phân tích 04';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.O04ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Chứng từ đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.VoucherAttach' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Hạn mức vỏ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.BottleLimit' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.AnaID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2005.AnaName.CB' , @FormID, @LanguageValue, @Language;





