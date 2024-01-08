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
SET @Language = 'zh-CN' 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1381';

SET @LanguageValue = N'asm-sup-銷售-經銷商關係之建立';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.Title', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用者';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用者';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職員';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.SaleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.SaleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'代理/商店 (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.DealerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.DealerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'槳板衝浪';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.SUPID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.SUPName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' 先進製造商';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.ASMID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.ASMName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'區域銷售總監';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.RSDID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.RSDName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'國家總監';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.NDID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.NDName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.LastModifyUserName', @FormID, @LanguageValue, @Language;

