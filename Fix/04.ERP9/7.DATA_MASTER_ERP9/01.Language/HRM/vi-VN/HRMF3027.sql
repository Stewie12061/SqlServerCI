-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1032- OO
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


SET @Language = 'vi-VN';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF3027'

SET @LanguageValue  = N'Giải trình chênh lệch'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại báo cáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.ReportTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.Date',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thứ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.DayInWeek',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ca'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.ShiftID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.EmployeeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.DepartmentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã máy'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.MachineID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.EmployeeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Vị trí'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.Position',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã sản phẩm'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hoạch định (h)'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.PlanTime',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sản lượng hoạch định'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.PlanQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thực tế (h)'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.Reality',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sản lượng thực tế'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.RealityQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chênh lệch giữa giờ thực tế & kế hoạch '
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.TimeDifference',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.RateDifference',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sản lượng chênh lệch'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.QuantityDifference',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.QuantityRateDifference',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng chuẩn'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.StandardQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chênh lệch sản lượng'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.StandardDifference',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.StandardRateDifference',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giải trình'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên báo cáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.ReportTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã báo cáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.ReportTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên báo cáo'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.ReportTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phòng ban'
EXEC ERP9AddLanguage @ModuleID, 'HRMF3027.DepartmentName.CB',  @FormID, @LanguageValue, @Language;