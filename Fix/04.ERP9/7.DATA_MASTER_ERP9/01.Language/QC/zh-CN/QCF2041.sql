-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2041- QC
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
SET @FormID = 'QCF2041';

SET @LanguageValue = N'輸入機器運作參數';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'五份文件';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生産日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.ManufacturingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生产班次';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生产班次';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'力量';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'力量';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品品質檢驗表';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.Voucher_QCT2000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工廠';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工廠';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'普魯';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品名稱';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'批號';
EXEC ERP9AddLanguage @ModuleID, 'QCF2041.BatchNo', @FormID, @LanguageValue, @Language;

