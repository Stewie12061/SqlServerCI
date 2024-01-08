-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1281- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1281';

SET @LanguageValue = N'付款條件之更新';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款條件';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.PaymentTermID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'条款名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.PaymentTermName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.IsDueDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'到期代码';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.DueType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'天數';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.DueDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'截止日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.CloseDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'當日';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.TheDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第   月的';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.TheMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'折扣';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.IsDiscount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'折扣類型代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.DiscountType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'折扣天数';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.DiscountDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'可享折扣率';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.DiscountPercentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1281.APK', @FormID, @LanguageValue, @Language;

