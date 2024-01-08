-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2106- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF2106';

SET @LanguageValue = N'淨銷售額';
EXEC ERP9AddLanguage @ModuleID, 'OOF2106.NetSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'佣金';
EXEC ERP9AddLanguage @ModuleID, 'OOF2106.CommissionCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'待客費用';
EXEC ERP9AddLanguage @ModuleID, 'OOF2106.GuestCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'增加的價值';
EXEC ERP9AddLanguage @ModuleID, 'OOF2106.BonusSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2106.APK', @FormID, @LanguageValue, @Language;

