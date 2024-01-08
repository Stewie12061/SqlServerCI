-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF9003- QC
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
SET @FormID = 'QCF9003';

SET @LanguageValue = N'選擇產品品質憑證';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'轉移';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工廠';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機器';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機長';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.Employee01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品質量測試儀';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.Employee02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機械師';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.Employee03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'仓库助理';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.Employee04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'包裝人員';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.Employee05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'監製製作人';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.Employee06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF9003.BatchNo', @FormID, @LanguageValue, @Language;

