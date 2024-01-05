------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MTF0070 - MT
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
SET @FormID = 'POSR3011';


SET @LanguageValue = N'Báo cáo bán hàng theo khu vực';
EXEC ERP9AddLanguage @ModuleID, 'POSR3011.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSR3011.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSR3011.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSR3011.FromMemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến hội viên';
EXEC ERP9AddLanguage @ModuleID, 'POSR3011.ToMemberID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSR3011.FromInventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSR3011.ToInventoryID' , @FormID, @LanguageValue, @Language;


------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;