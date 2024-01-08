------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF1061 - SO
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF1061';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Cập nhật chỉ tiêu doanh số nhân viên bán sỉ (Sell In)';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.TargetsID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.EmployeeLevelName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.TeamName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên SA - PG';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.SOAna01Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên SUP';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.SOAna02Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên ASM';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.SOAna03Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên ADMIN';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.SOAna04Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên QLADMIN';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.SOAna05Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngành hàng (MPT 8)';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm hàng (MPT 4)';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.InventoryTypeName2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh số tháng';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.SalesMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh số quý';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.SalesQuarter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh số năm';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.SalesYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.AnaUserID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.AnaUserName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.UserName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cấp';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.AnaTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cấp';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.UserName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhóm';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.TeamID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhóm';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.TeamName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.ObjectID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.ObjectName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã ngành hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.InventoryTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên ngành hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.InventoryTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phân tích';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhóm hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.InventoryTypeID2.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhóm hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF1061.InventoryTypeName2.CB', @FormID, @LanguageValue, @Language;