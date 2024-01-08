-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2051- QC
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
SET @FormID = 'QCF2051';

SET @LanguageValue = N'詳細產品品質檢驗表';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.VoucherType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'单据ID';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'月';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'擦除';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生産日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.ManufacturingDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生产班次';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'力量';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工廠';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品品質檢驗表';
EXEC ERP9AddLanguage @ModuleID, 'QCF2051.Voucher_QCT2000', @FormID, @LanguageValue, @Language;

