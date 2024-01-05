
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2271 - WM
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
SET @FormID = 'WMF2271';

SET @LanguageValue = N'Cập nhật kết chuyển số dư cuối kỳ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2271.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2271.WareHouseID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kỳ muốn kết chuyển';
EXEC ERP9AddLanguage @ModuleID, 'WMF2271.PeriodID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết chuyển';
EXEC ERP9AddLanguage @ModuleID, 'WMF2271.Transfer' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết chuyển';
EXEC ERP9AddLanguage @ModuleID, 'WMF2271.btnTransferBalance' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2271.WareHouseID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2271.WareHouseName.CB' , @FormID, @LanguageValue, @Language;