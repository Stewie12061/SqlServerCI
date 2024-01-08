-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2111- SO
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
SET @FormID = 'SOF2111';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.FromDateToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'票據代碼';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成品';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成品';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'套數';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.SetNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顏色';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ColorID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ColorName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成本';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceOriginal', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期望利潤率(%)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ProfitRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期望的利潤';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ProfitDesired', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顧客姓名';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顧客姓名';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'在工廠交付的單價/套';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceSetFactory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'在工廠交付的單價/m2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceAcreageFactory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'安裝單價/套';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceSetInstall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'安裝單價/m2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceAcreageInstall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'競爭對手價格';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.PriceRival', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'BOM繼承';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.IsInheritBOM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'瀏覽狀態';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.StatusSS', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2111.APK_InheritBOM', @FormID, @LanguageValue, @Language;

