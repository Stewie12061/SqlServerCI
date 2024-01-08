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
SET @Language = 'zh-CN' 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1382';

SET @LanguageValue = N'Asm-sup-銷售-經銷商關係詳細信息';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用者';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用者';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.SaleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'員工姓名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.SaleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'代理/商店代碼 (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.DealerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'代理/商店名稱(Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.DealerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SUP代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.SUPID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'槳板衝浪';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.SUPName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ASM程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.ASMID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' 先進製造商';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.ASMName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'區域銷售總監';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.RSDID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'區域銷售總監';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.RSDName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'國家總監';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.NDID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'國家總監';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.NDName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.LastModifyUserName', @FormID, @LanguageValue, @Language;

