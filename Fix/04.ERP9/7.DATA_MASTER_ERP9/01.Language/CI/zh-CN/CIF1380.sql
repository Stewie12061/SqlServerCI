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
SET @Language = 'zh-CN' 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1380';

SET @LanguageValue = N'關係類別 asm-sup-銷售-經銷商清單';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'用戶';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'用戶';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職員';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.SaleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職員';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.SaleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'代理/商店 (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.DealerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'代理/商店 (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.DealerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'槳板衝浪';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.SUPID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'槳板衝浪';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.SUPName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' 先進製造商';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.ASMID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' 先進製造商';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.ASMName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'區域銷售總監';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.RSDID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'區域銷售總監';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.RSDName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'國家總監';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.NDID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'國家總監';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.NDName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.LastModifyUserName', @FormID, @LanguageValue, @Language;

