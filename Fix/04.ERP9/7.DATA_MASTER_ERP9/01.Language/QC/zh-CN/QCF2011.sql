-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2011- QC
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
SET @FormID = 'QCF2011';

SET @LanguageValue = N'记录成品数量';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'五份文件';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生産日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.ManufacturingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生产班次';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生产班次';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.ShiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'力量';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'力量';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品品質檢驗表';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.Voucher_QCT2000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'總重量';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.GrossWeight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'净重';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.NetWeight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工廠';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工廠';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'專案程式碼';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'命名項目';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'批號';
EXEC ERP9AddLanguage @ModuleID, 'QCF2011.BatchNo', @FormID, @LanguageValue, @Language;

