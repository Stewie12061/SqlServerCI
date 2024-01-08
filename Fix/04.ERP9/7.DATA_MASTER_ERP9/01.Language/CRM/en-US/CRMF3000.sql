------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF3000 - CRM

------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
@LanguageValue nvarchar(4000)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMF1082'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'en-US'
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF3000';

SET @LanguageValue = N'Chart report';
EXEC ERP9AddLanguage @ModuleID, N'CRMF3000.Title', @FormID, @LanguageValue , @Language;

SET @LanguageValue = N'Request subject';
EXEC ERP9AddLanguage @ModuleID, N'CRMF3000.RequestSubject', @FormID, @LanguageValue , @Language;

SET @LanguageValue = N'Request subject';
EXEC ERP9AddLanguage @ModuleID, N'A.RequestSubject', @FormID, @LanguageValue , @Language;

SET @LanguageValue = N'Lead - opportunity-customer';
EXEC ERP9AddLanguage @ModuleID, 'AsoftCRM.BaoCaoThongKe' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Conversion rate';
EXEC ERP9AddLanguage @ModuleID, 'AsoftCRM.TyLeChuyenDoi' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quotation';
EXEC ERP9AddLanguage @ModuleID, 'AsoftCRM.BaoGia' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tum over';
EXEC ERP9AddLanguage @ModuleID, 'AsoftCRM.DoanhSo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order';
EXEC ERP9AddLanguage @ModuleID, 'AsoftCRM.Donhang' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Marketing';
EXEC ERP9AddLanguage @ModuleID, 'AsoftCRM.BaoCaoKhac' , @FormID, @LanguageValue, @Language;
