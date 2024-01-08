-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2053- S
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
SET @ModuleID = 'S';
SET @FormID = 'SOF2053';

SET @LanguageValue = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'SOF2053.SaleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Staff name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2053.SaleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Limit at the beginning of the year';
EXEC ERP9AddLanguage @ModuleID, 'SOF2053.Beginning', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Limit granted';
EXEC ERP9AddLanguage @ModuleID, 'SOF2053.GrantedQuota', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expenses paid';
EXEC ERP9AddLanguage @ModuleID, 'SOF2053.AdvanceCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Guest cost';
EXEC ERP9AddLanguage @ModuleID, 'SOF2053.RefundedCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Remaining limit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2053.RemainingQuota', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment';
EXEC ERP9AddLanguage @ModuleID, 'SOF2053.RowNum', @FormID, @LanguageValue, @Language;

