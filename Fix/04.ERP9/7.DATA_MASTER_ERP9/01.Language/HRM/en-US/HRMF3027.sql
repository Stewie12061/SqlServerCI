-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF3027- HRM
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
SET @Language = 'en-US' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF3027';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report type';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.ReportTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rank';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.DayInWeek', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code ca';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.ShiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Staff is name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Location';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.Position', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Product code';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Planning (h)';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.PlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Planned output';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.PlanQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual (h)';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.Reality', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Actual output';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.RealityQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Difference between actual & planned hours';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.TimeDifference', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ratio';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.RateDifference', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yield difference';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.QuantityDifference', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ratio';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.QuantityRateDifference', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Các bản dịch đã thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.StandardQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Output difference';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.StandardDifference', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ratio';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.StandardRateDifference', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explanation';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Report name';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.ReportTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.FromToDate', @FormID, @LanguageValue, @Language;

