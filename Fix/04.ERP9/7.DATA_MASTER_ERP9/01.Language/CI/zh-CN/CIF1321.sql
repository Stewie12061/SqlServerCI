-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1321- CI
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
SET @FormID = 'CIF1321';

SET @LanguageValue = N'單據之更新';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程式碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單據類型名稱';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'使用組';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VoucherGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'默認值';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsDefault', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'默认仓库';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單據描述使用';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsBDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'默认仓库';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.BDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單據描述使用';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsTDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'说明';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.TDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨幣';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯絡電話姓名';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'債務帳戶';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.DebitAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'帳號 是';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CreditAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'銀行賬戶';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.BankAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'倉庫/輸入倉庫';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'出口倉庫代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ExWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'发票类型';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.VATTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'增值稅';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsVAT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S1Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S2Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S3Type', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'空間';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.separator', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'小数长度';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.OutputLength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'显示格式';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.OutputOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自動增加指數';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Separated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建分录';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Auto', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'重置自增指數';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Enabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Enabled1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統代碼';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ModuleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'業務';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.ScreenID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Enabled2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.Enabled3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'分類3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.S3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'自動增加指數';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.SetLastKey', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'重置自增指數';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.IsSetLastKey', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1321.TableID', @FormID, @LanguageValue, @Language;

