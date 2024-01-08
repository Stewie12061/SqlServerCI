-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1381- CI
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
SET @FormID = 'CIF1381';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Send feedback';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Staff';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.SaleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Staff''s name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.SaleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dealer/store (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.DealerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dealer/store name (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.DealerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SUP';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.SUPID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SUP';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.SUPName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ASM';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.ASMID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ASM';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.ASMName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'RSD code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.RSDID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'RSD name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.RSDName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'National Director';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.NDID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'National Director';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.NDName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.LastModifyUserName', @FormID, @LanguageValue, @Language;

