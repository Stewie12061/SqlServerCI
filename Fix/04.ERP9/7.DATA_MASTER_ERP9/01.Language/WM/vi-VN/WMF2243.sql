
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2243 - WM
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
SET @ModuleID = 'WM';
SET @FormID = 'WMF2243';


SET @LanguageValue = N'Kiểm kê hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.WareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.Inventory' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin thời gian';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.VarChar' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Theo kỳ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.Type1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Theo ngày';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.Type2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kỳ kiểm kê';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.Period' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kiểm kê';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.DateTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiếp tục >>';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.Continues' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.WareHouseID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2243.WareHouseName.CB' , @FormID, @LanguageValue, @Language;