-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2022- QC
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
SET @FormID = 'QCF2022';

SET @LanguageValue = N'成品错误处理清单';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件類型';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.VoucherType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生産日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.ShiftVoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品品質檢驗表';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機器';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'月';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'擦除';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工廠';
EXEC ERP9AddLanguage @ModuleID, 'QCF2022.DepartmentID', @FormID, @LanguageValue, @Language;

