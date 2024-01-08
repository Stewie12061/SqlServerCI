-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2115- SO
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF2115';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.FromDateToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'票據代碼';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'專案程式碼';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'命名項目';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'套數';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.SetNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.ColorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顏色';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.ColorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成本';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.PriceOriginal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期望利潤率(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.ProfitRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期望的利潤';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.ProfitDesired', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'在工廠交付的單價/套';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.PriceSetFactory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'在工廠交付的單價/m2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.PriceAcreageFactory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'安裝單價/套';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.PriceSetInstall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'安裝單價/m2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.PriceAcreageInstall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'競爭對手價格';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.PriceRival', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.IsInheritBOM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'瀏覽狀態';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2115.APK_InheritBOM', @FormID, @LanguageValue, @Language;

