
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF0000 - WM
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
SET @ModuleID = 'WM';
SET @FormID = 'WMF0000';

SET @LanguageValue = N'倉庫儀表板';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最低結存';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.MinPresent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最大結存';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.MaxPresent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'再次訂購';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ReOrder' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'已過時';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.OutDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'庫存最高的前';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.Top10QuantityWM' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最大庫存的前 10 名（價值）';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.Top10AmountWM' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'庫存時間最長的前10名（庫存年齡';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.Top10AgeWM' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'即將過期的前10類商品';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.Top10OutDateWM' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'按期間劃分的庫存價值圖表';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ChartInventoryByPeriod' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'以越南盾計算的庫存價值';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.AxisYTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'按産品組劃分的入庫/出庫/庫存圖表';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ChartInventoryByGroupProduct' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'入庫';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ImportName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'從倉庫匯出';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ExportName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'庫存';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.EndName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'價值̣';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.AxisYTitleGroupChart' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'圖表';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ChartTop' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期間之選擇';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.Period' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'日期自';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.FromDateFilter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'迄今';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ToDateFilter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'從期間̀';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.FromPeriodFilter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'時期';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ToPeriodFilter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'天';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.DateSuffix' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'越南盾';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.AmountSuffix' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.Division' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'一組貨物';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.InventoryType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位代碼';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.DivisionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位名稱';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.DivisionName.CB' , @FormID, @LanguageValue, @Language;

------------------------------------------Ngôn ngữ màn hình xem thông tin tồn kho---------------------------------------------------------
SET @LanguageValue = N'庫存信息';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.InventoryInforTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'專案程式碼';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'命名項目';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位代碼';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'初始的結存';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.BeginQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'進口數量';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ImportQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'輸出數量';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ExportQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'期末库存';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.EndQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'庫存數量';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.QuantityOnHand' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'初始剩下的成本';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.BeginAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'輸入成本';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ImportAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'導出的成本';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ExportAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最後剩下的成本';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.EndAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'存庫天數';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.DateInWareHouse' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'筆記';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.Notes01' , @FormID, @LanguageValue, @Language;

------------------------------------Ngôn ngữ màn hình phân quyền Dashboard Quản lý kho hàng------------------------------------------------
SET @LanguageValue = N'統計數據'
EXEC ERP9AddLanguage @ModuleID, 'WMD0000.Title', 'WMD0000', @LanguageValue, @Language;

SET @LanguageValue = N'庫存最多/最大/最長的頂級圖表'
EXEC ERP9AddLanguage @ModuleID, 'WMD0001.Title', 'WMD0001', @LanguageValue, @Language;

SET @LanguageValue = N'按產品組別劃分的進出口/庫存價值圖表'
EXEC ERP9AddLanguage @ModuleID, 'WMD0002.Title', 'WMD0002', @LanguageValue, @Language;

SET @LanguageValue = N'按期間劃分的庫存價值圖表'
EXEC ERP9AddLanguage @ModuleID, 'WMD0003.Title', 'WMD0003', @LanguageValue, @Language;