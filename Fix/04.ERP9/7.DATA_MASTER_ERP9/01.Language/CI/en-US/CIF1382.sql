-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1382- CI
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
SET @FormID = 'CIF1382';

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gửi ý kiến phản hồi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'User name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.SaleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Staff is name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.SaleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dealer/store code (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.DealerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dealer/store name (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.DealerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SUP code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.SUPID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SUP';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.SUPName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ASM code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.ASMID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ASM';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.ASMName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'RSD code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.RSDID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'RSD name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.RSDName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'National Director';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.NDID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'National Director';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.NDName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.LastModifyUserName', @FormID, @LanguageValue, @Language;

