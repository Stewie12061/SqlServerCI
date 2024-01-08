-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF0000- QC
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
SET @FormID = 'QCF0000';

SET @LanguageValue = N'系統設定';
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型 產品品質檢驗表';
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherFirstShift', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'憑證類型 數量確認單';
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作參數文件的類型';
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherOperateParam', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'技術規格檔類型';
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherTechniqueParam', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型 物料跟蹤';
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherMaterial', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CT 型 處理缺陷貨物';
EXEC ERP9AddLanguage @ModuleID, 'QCF0000.VoucherDefective', @FormID, @LanguageValue, @Language;

