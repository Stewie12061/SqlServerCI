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
SET @FormID = 'POSF3028';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Bảng kê phiếu nhập';
EXEC ERP9AddLanguage @ModuleID, 'POSF3028.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF3028.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng/Event';
EXEC ERP9AddLanguage @ModuleID, 'POSF3028.ShopID' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Từ kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF3028.FromWareHouseID' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Đến kho';
EXEC ERP9AddLanguage @ModuleID, 'POSF3028.ToWareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF3028.FromInventoryName' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Đến mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF3028.ToInventoryName' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'POSF3028.StatusID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF3028.InventoryID' , @FormID, @LanguageValue, @Language;