-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2022- S
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
SET @FormID = 'SF2022';

SET @LanguageValue = N'View detail of rules';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rule ID';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.RuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Filter condition';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.FilterCondition', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Filter content';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.FilterContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Screen';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee ID';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rule name';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.RuleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Effect date';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.EffectDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expiry date';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ExpiryDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User ID';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Filter condition';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.FilterConditionName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ModuleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Screen';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ScreenName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business voucher';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.VoucherBusiness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business voucher';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.VoucherBusinessName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.TableName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attack';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rules condition info';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ThongTinDieuKienRules', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Target data info';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ThongTinDuLieuDich', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Info of rule';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.ThongTinRules', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rule type';
EXEC ERP9AddLanguage @ModuleID, 'SF2022.TypeRulesName', @FormID, @LanguageValue, @Language;
