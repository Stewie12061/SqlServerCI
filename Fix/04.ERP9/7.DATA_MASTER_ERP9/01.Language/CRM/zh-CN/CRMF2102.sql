-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2102- CRM
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
SET @FormID = 'CRMF2102';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'所需票數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'信息接收者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'信息接收者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨地點';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品類別';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'市場代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.MarketID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品注意事項';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ProductQuality', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'長度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'寬度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'高';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'痛苦';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PrintSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'切';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.CutSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'長度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.LengthPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'寬度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.WidthPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訂單數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第1面';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第1面印刷的顏色數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第 2 面';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第 2 面印刷的顏色數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨時間';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.FromDeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款期限內';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PaymentTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交通費（租車）';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.TransportAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款方式';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'定量（張）';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Percentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'其他注意事項';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'光盤';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsDiscCD', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品樣品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsSampleInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件模板';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsSampleEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電影';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品數量/印張';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.InvenPrintSheet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品數量/模具';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.InvenMold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'包裝';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Pack', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'膠版紙';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.OffsetPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'膠版紙';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.OffsetPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'印刷面數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'其他加工';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.OtherProcessing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電影上映日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'長度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.LengthFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'寬度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.WidthFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'影片狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.StatusFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模具情況';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.StatusMold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'爆破強度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Design', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Zen suppo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.IsZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'長度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.LengthZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'寬度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.WidthZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新人';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'更新日';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模具狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品類別';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PaperTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第1面印刷的顏色數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ColorPrint01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第 2 面印刷的顏色數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ColorPrint02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'影片狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.StatusFilmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模具情況';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.StatusMoldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯繫';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'聯繫';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電話號碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商業';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商業';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.BusinessLinesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨方式';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DeliveryMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨物包裝方式';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PackingMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'托盤要求';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PalletRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'用於';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.UsedIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'印刷方式';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'紙箱/盒中的訂購數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.QuantityInBox', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承載';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'承載力';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Bearingstrength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'濕度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Humidity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'孔隙度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.Podium', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'BCT承載';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.BearingBCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ECT邊緣壓縮 ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.EdgeCompressionECT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先價值';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PreferredValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'設計文件名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'盒子樣式';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.BoxType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容模板';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.SampleContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顏色樣本按';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.ColorSample', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.FieldDeliveryMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.FieldPackingMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.FieldUsedIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨方式';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.DeliveryMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'貨物包裝方式';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PackingMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'用於';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.UsedInName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款方式';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PaymentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'印刷辦法';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2102.APK_BomVersion', @FormID, @LanguageValue, @Language;

