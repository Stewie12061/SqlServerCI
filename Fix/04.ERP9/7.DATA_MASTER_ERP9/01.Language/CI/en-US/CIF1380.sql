-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1380- CI
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
SET @FormID = 'CIF1380';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Staff';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.SaleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Staff';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.SaleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dealer/store (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.DealerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dealer/store (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.DealerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SUP';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.SUPID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SUP';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.SUPName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ASM';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.ASMID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ASM';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.ASMName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'RSD code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.RSDID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'RSD name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.RSDName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'National Director';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.NDID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'National Director';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.NDName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation Date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.LastModifyUserName', @FormID, @LanguageValue, @Language;

