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
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'vi-VN' 
SET @ModuleID = 'POS';
SET @FormID = 'POSF3020';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Reconcile of daily report';
EXEC ERP9AddLanguage @ModuleID, 'POSF3020.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF3020.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng/Event';
EXEC ERP9AddLanguage @ModuleID, 'POSF3020.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF3020.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hóa đơn cọc';
EXEC ERP9AddLanguage @ModuleID, 'POSF3020.RefVoucherNo' , @FormID, @LanguageValue, @Language;