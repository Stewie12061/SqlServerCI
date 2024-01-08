-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2003- QC
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
SET @ModuleID = 'QC';
SET @FormID = 'QCF2003';

SET @LanguageValue = N'選擇打印樣本';
EXEC ERP9AddLanguage @ModuleID, 'QCF2003.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'列印範本';
EXEC ERP9AddLanguage @ModuleID, 'QCF2003.IsPrint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'命名項目';
EXEC ERP9AddLanguage @ModuleID, 'QCF2003.InventoryID', @FormID, @LanguageValue, @Language;

