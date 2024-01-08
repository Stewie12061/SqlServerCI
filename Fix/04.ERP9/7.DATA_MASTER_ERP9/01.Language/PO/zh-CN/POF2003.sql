-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2003- PO
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
SET @ModuleID = 'PO';
SET @FormID = 'POF2003';

SET @LanguageValue = N'打印采購訂單';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'選擇打印類型';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.ChooseTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'命名項目';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'換算單位';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.IsPrint', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'In Skid Label';
EXEC ERP9AddLanguage @ModuleID, 'POF2003.Skid', @FormID, @LanguageValue, @Language;

