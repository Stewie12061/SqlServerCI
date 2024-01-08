-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1282- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1282';

SET @LanguageValue  = N'Detail payment term'
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment terms code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Name of payment terms';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.PaymentTermName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expire';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.IsDueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Maturity type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.DueType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of days';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.DueDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Closing date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.CloseDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'On the day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.TheDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Of the second month';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.TheMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.IsDiscount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount type code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.DiscountType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number of days to enjoy discount';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.DiscountDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Discount rate to be enjoyed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.DiscountPercentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Payment Terms Information';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.ThongTinDieuKhoanThanhToan',  @FormID, @LanguageValue, @Language;
