-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2021- S
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
SET @FormID = 'SF2021';

SET @LanguageValue = N'Updated rules';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rule ID';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.RuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Filter condition';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.FilterCondition', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Filter content';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.FilterContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Screen';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rule name';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.RuleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Effect date';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expiry date';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User ID';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Filter condition';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.FilterConditionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ModuleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Screen';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ScreenName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business voucher';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.VoucherBusiness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business voucher';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.VoucherBusinessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.TableName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module ID';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ModuleID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module name';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ModuleName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Screen ID';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ScreenID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Screen name';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.ScreenName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Filter data';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.TabST2021', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target data';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.TabST2022', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.DescriptionDetail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Absent type nme';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.AbsentTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Operator';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.Operator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Value';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.Vaule', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Value';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.Value', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rules type';
EXEC ERP9AddLanguage @ModuleID, 'SF2021.TypeRules', @FormID, @LanguageValue, @Language;


