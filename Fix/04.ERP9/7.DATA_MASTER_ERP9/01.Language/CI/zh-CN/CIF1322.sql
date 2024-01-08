-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1322- CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1322';

SET @LanguageValue = N'詳細單據之查看';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單據類型名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用組';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VoucherGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'默認值';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.IsDefault', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'默认仓库';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.IsBDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'默认仓库';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.BDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.IsTDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'说明';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.TDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨幣';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯絡電話姓名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'債務帳戶';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.DebitAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'帳號 是';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.CreditAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銀行賬戶';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'倉庫/輸入倉庫';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出口倉庫代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ExWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'发票类型';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.VATTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'增值稅';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.IsVAT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S1Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S2Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S3Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'空間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.separator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'小数长度';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.OutputLength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'显示格式';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.OutputOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自動增加指數';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Separated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建分录';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Enabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Enabled1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'業務';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.ScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Enabled2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.Enabled3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.SetLastKey', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.IsSetLastKey', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1322.TableID', @FormID, @LanguageValue, @Language;

