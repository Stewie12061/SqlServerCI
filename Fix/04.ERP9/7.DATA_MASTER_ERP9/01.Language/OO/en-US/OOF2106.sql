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
SET @Language = 'en-US' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF2106';

SET @LanguageValue = N'Net sales';
EXEC ERP9AddLanguage @ModuleID, 'OOF2106.NetSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Commission cost';
EXEC ERP9AddLanguage @ModuleID, 'OOF2106.CommissionCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Guest cost';
EXEC ERP9AddLanguage @ModuleID, 'OOF2106.GuestCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bonus sales';
EXEC ERP9AddLanguage @ModuleID, 'OOF2106.BonusSales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update Project Costs';
EXEC ERP9AddLanguage @ModuleID, 'OOF2106.Title', @FormID, @LanguageValue, @Language;
