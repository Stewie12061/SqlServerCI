-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2103- CRM
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
SET @FormID = 'CRMF2103';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'所需票數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'信息接收者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'信息接收者';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶姓名';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨地點';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.DeliveryAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品名稱';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品類別';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PaperTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'市場代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.MarketID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品質量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ProductQuality', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'長度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'寬度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'高';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'痛苦';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PrintSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'切';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.CutSize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'長度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.LengthPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'寬度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.WidthPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'數量';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第1面';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.SideColor1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第1面印刷的顏色數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ColorPrint01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第 2 面';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.SideColor2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第 2 面印刷的顏色數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ColorPrint02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨時間';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.DeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.FromDeliveryTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款時間';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PaymentTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交通費（租車）';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.TransportAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'付款方式';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PaymentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.IsContract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'定量（張）';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Percentage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'光盤';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.IsDiscCD', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品樣品';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.IsSampleInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件模板';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.IsSampleEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電影';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.IsFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附件';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品數量/印張';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.InvenPrintSheet', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'產品數量/模具';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.InvenMold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'包裝';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Pack', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'膠版紙';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.OffsetPaperName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'膠版紙';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.OffsetPaper', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'印刷辦法';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PrintNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'其他加工';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.OtherProcessing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電影上映日期';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.FilmDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'長度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.LengthFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'寬度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.WidthFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'影片狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.StatusFilm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模具情況';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.StatusMold', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'爆破強度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Design', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Zen suppo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.IsZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'長度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.LengthZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'寬度';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.WidthZenSuppo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.APKMInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.APKDInherited', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'模具狀態';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PaperTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第1面印刷的顏色數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ColorPrint01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'第 2 面印刷的顏色數';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ColorPrint02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.StatusFilmName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.StatusMoldName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.BusinessLinesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.BusinessLinesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.DeliveryMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PackingMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PalletRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.UsedIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PrintTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.QuantityInBox', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Weight', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Bearingstrength', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Humidity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.Podium', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.BearingBCT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.EdgeCompressionECT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PreferredValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.FileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.BoxType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.SampleContent', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.ColorSample', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.FieldDeliveryMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.FieldPackingMethod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.FieldUsedIn', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.DeliveryMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PackingMethodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.UsedInName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PaymentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.PrintTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2103.APK_BomVersion', @FormID, @LanguageValue, @Language;

