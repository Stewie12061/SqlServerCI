
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF3000- OO
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
SET @ModuleID = 'BI';
SET @FormID = 'BF0000';

SET @LanguageValue = N'Revenues and quantity of sales';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.BlockASMTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng bán';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.BlockASMOrderQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.BlockASMProOrderQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh số bán';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.BlockASMAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ASM';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.ASM' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SKU';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.SKU' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenues and quantity of sales';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.BlockASMTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cash and Bank balances';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block01Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VND';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block01Amount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales chart';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block03Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual Revenues';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block03AcctualAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target Revenues';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block03TargetAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales rate achieved';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block03ActualRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cost of Sales Rate';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block04Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee Bonus Revenues';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block04EmpRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotional Proceeds';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block04ProRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Average Inventory';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block05Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Average Inventory';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block05AVRAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenues and quantity of sales';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block08Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revennues of Sales';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block08Amount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity of Sales';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block08AcctualyQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Promotional Quantity';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block08ProQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revenue chart';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block03_1Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual Amount';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block03_1ActualAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target Amount';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block03_1TargetAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Turnover of money';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block03_1SaleReceiptAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales rate achieved';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block03_1ActualRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sales revenue ratio';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block03_1SaleReceiptRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Filter';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Filter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'2 year nearest';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.TwoYearAgo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'1 year nearest';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.YearAgo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'6 month nearest';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.SixMonthAgo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'3 month nearest';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.ThreeMonthAgo' , @FormID, @LanguageValue, @Language;

-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ
SET @LanguageValue = N'Profit and loss of each branch';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block12Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Branch profit and loss for multiple periods';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block10Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Compare branch costs for multiple periods';
EXEC ERP9AddLanguage @ModuleID, 'BF0000.Block11Title' , @FormID, @LanguageValue, @Language;
