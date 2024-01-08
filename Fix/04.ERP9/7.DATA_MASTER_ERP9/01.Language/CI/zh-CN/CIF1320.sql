-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1320- CI
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
SET @FormID = 'CIF1320';

SET @LanguageValue = N'单据清單';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單據類型名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用組';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VoucherGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'默認值';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.IsDefault', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'默认仓库';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.IsBDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'默认仓库';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.BDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.IsTDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'说明';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.TDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨幣';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯絡電話姓名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'債務帳戶';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.DebitAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'帳號 是';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.CreditAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銀行賬戶';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'倉庫/輸入倉庫';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出口倉庫代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.ExWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'发票类型';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.VATTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'增值稅';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.IsVAT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S1Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S2Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S3Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'空間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.separator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.OutputLength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'显示格式';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.OutputOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自動增加指數';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Separated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建分录';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Enabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Enabled1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'業務';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.ScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Enabled2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.Enabled3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.SetLastKey', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.IsSetLastKey', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1320.TableID', @FormID, @LanguageValue, @Language;

