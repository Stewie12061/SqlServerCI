-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2214- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF2214';

SET @LanguageValue = N'生產指令之繼承';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計日期';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生產人員';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'客戶';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'交貨日期';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'階段';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'階段';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'力量';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'生産日期';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.ManufacturerDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'産品代碼';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'産品名稱';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'語言代碼';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.DetailID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'詳細名稱';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.DetailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'數量';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'{0:00}次状態';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.CycleTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.ItemPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.StartTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.EndTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.PreparePlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.RestPlanTime1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.RestPlanTime2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.MainMealPlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.SideMealPlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.Ana06Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.TotalPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.TotalActualTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.S01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.S02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.S03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.S01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.S02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.S03Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2214.Specification', @FormID, @LanguageValue, @Language;

