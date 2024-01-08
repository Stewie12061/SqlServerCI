-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF10009- QC
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
SET @FormID = 'QCF10009';

SET @LanguageValue = N'選擇產品品質憑證';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'轉移';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工廠';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機器';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機長';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.Employee01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品質量測試儀';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.Employee02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機械師';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.Employee03', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'仓库助理';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.Employee04', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'包裝人員';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.Employee05', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'監製製作人';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.Employee06', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'專案程式碼';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'命名項目';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'批號';
EXEC ERP9AddLanguage @ModuleID, 'QCF10009.BatchNo', @FormID, @LanguageValue, @Language;

