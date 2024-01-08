-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF0000- PO
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
SET @FormID = 'POF0000';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF0000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'供應商報價單據類型';
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherPriceQuote', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'采購申請單單據類型';
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'收貨進度單據類型';
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherDeliverySchedule', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出口訂單集裝箱訂購單據類型';
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherBookCont', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'采購訂單單據類型';
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherPurchaseOrder', @FormID, @LanguageValue, @Language;

