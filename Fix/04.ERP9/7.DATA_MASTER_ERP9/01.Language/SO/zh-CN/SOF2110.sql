-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2110- SO
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
SET @FormID = 'SOF2110';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.FromDateToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'票據代碼';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'專案程式碼';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'命名項目';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'套數';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.SetNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ColorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顏色';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ColorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成本';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceOriginal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期望利潤率(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ProfitRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期望的利潤';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ProfitDesired', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顧客姓名';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'在工廠交付的單價/套';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceSetFactory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'在工廠交付的單價/m2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceAcreageFactory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'安裝單價/套';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceSetInstall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'安裝單價/m2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceAcreageInstall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'競爭對手價格';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.PriceRival', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.IsInheritBOM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'瀏覽狀態';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2110.APK_InheritBOM', @FormID, @LanguageValue, @Language;

