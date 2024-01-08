-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2111- CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2111';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'估計數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預計日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單價';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.TotalVariableFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PercentCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PercentProfit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Profit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨地點';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.DeliveryAddressName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨時間';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品類別';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂單數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'印刷面數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第1面';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第1面打印的顏色';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第 2 面';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第2面打印的顏色';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生產編號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.OffsetQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件導出日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FilmStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'損失額';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'損耗 （％）';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品注意事項';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單價';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.InvenUnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'M2價格';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SquareMetersPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶請求單';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.InheritCRMT2100', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FilmStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模具情況';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'核准人意見';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'印刷方式';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'估價單';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.InheritCRMT2110', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ContentSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.ColorSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.MTSignedSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FileLength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FileWidth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FileSum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'包括';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.Include', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.TableInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'半成品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SemiProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.SemiProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.FileUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.TotalProfitCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2111.BOMVersion', @FormID, @LanguageValue, @Language;

