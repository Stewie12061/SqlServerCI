-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2112- CRM
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
SET @FormID = 'CRMF2112';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'估計數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'預計日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單價';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.TotalVariableFee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'成本 (%)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PercentCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'總費用';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Cost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'利潤 （％）';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PercentProfit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'總利潤';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Profit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.DeliveryAddressName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨時間';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品類別';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂單數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'印刷面數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'長度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'寬度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'高';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第1面印刷的顏色數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第 2 面';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第 2 面印刷的顏色數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生產編號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.OffsetQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件導出日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'影片狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FilmStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'損失額';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.AmountLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'損耗 （％）';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PercentLoss', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'備註';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單價';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InvenUnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'M2價格';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.SquareMetersPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'匯率';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ExchangeRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨幣種類';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.CurrencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InheritCRMT2100', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'修理人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更正日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FilmStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模具情況';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.MoldStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.APKMaster_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Type_9000', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ApprovingLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ApproveLevel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.InheritCRMT2110', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容模板';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ContentSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'色樣本';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.ColorSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生產簽名的MT樣品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.MTSignedSampleDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件/打印尺寸（長）';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FileLength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'文件/打印尺寸（寬）';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FileWidth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ctp/打印文件的大小';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FileSum', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'包括';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.Include', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.TableInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.SemiProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'半成品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.SemiProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.FileUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.TotalProfitCost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2112.BOMVersion', @FormID, @LanguageValue, @Language;

