------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0001 - POS
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
 - Tieng Viet: en-US 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US' 
SET @ModuleID = 'POS';
SET @FormID = 'POSF3020';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Reconcile of daily report';
EXEC ERP9AddLanguage @ModuleID, 'POSF3020.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POSF3020.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop/Event';
EXEC ERP9AddLanguage @ModuleID, 'POSF3020.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher NO';
EXEC ERP9AddLanguage @ModuleID, 'POSF3020.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deposit voucher NO';
EXEC ERP9AddLanguage @ModuleID, 'POSF3020.RefVoucherNo' , @FormID, @LanguageValue, @Language;