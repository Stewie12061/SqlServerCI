
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF0003 - WM
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
SET @FormID = 'WMF0003';

SET @LanguageValue = N'Tính giá xuất kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF0003.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kỳ kế toán';
EXEC ERP9AddLanguage @ModuleID, 'WMF0003.PeriodID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF0003.FromInventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF0003.ToInventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tính giá không phân biệt kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF0003.AllWare' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF0003.WareHouseName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'WMF0003.btnAction' , @FormID, @LanguageValue, @Language;