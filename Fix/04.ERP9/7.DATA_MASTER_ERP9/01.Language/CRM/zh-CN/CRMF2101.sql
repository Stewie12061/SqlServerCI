-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2101- CRM
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
SET @FormID = 'CRMF2101';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'所需票數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'信息接收者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'信息接收者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨地點';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品類別';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'市場代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.MarketID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品注意事項';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ProductQuality', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'長度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'寬度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'高';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'痛苦';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PrintSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'切';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.CutSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'長度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.LengthPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'寬度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.WidthPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂單數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第1面';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第1面印刷的顏色數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第 2 面';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第 2 面印刷的顏色數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨時間';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.FromDeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款期限';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaymentTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交通費（租車）';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.TransportAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款方式';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'定量（張）';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Percentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'其他注意事項';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'光盤';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsDiscCD', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品樣品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsSampleInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件模板';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsSampleEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電影';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品數量/印張';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.InvenPrintSheet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品數量/模具';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.InvenMold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'包裝';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Pack', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'膠版紙';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.OffsetPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'膠版紙';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.OffsetPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'印刷面數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'其他加工';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.OtherProcessing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電影上映日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'長度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.LengthFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'寬度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.WidthFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'影片狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.StatusFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模具情況';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.StatusMold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'爆破強度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Design', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Zen suppo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.IsZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'長度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.LengthZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'寬度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.WidthZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模具狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品類型';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaperTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第 1 面印刷的顏色數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ColorPrint01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第 2 面印刷的顏色數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ColorPrint02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'影片狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.StatusFilmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模具狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.StatusMoldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯繫';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯繫';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話號碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商業';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商業';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.BusinessLinesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨方式';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.DeliveryMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨物包裝方式';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PackingMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'托盤要求';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PalletRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'用於';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.UsedIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'印刷方式';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'紙箱/盒中的數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.QuantityInBox', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承載';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承載力';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Bearingstrength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'濕度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Humidity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'孔隙度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.Podium', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'BCT承載';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.BearingBCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ECT邊緣壓縮 ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.EdgeCompressionECT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先價值';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PreferredValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設計文件名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'盒子樣式';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.BoxType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容模板';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.SampleContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顏色樣本按';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.ColorSample', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.FieldDeliveryMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.FieldPackingMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.FieldUsedIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'運輸方式';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.DeliveryMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'包裝方式';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PackingMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'用於';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.UsedInName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款方法';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PaymentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'印刷辦法';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2101.APK_BomVersion', @FormID, @LanguageValue, @Language;

