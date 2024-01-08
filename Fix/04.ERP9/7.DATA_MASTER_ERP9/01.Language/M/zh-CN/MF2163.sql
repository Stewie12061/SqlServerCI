-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2163- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF2163';

SET @LanguageValue = N'列印生產指令';
EXEC ERP9AddLanguage @ModuleID, 'MF2163.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'換算單位';
EXEC ERP9AddLanguage @ModuleID, 'MF2163.IsPrint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'MF2163.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'命名項目';
EXEC ERP9AddLanguage @ModuleID, 'MF2163.InventoryID', @FormID, @LanguageValue, @Language;

