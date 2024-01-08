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
SET @Language = 'en-US'; 
SET @ModuleID = 'PO';
SET @FormID = 'POF0000';
SET @LanguageValue  = N'Thiết lập hệ thống'
EXEC ERP9AddLanguage @ModuleID, 'POF0000.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã'
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên'
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'POF0000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT supplier quote';
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherPriceQuote', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CT type requires purchase';
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CT type Delivery progress';
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherDeliverySchedule', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type CT Book cont export orders';
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherBookCont', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase order CT type';
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherPurchaseOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại CT Book cont đơn hàng xuất khẩu'
EXEC ERP9AddLanguage @ModuleID, 'POF0000.VoucherBookCont',  @FormID, @LanguageValue, @Language;