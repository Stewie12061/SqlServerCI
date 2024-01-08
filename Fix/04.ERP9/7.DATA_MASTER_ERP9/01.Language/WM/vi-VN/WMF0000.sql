
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
SET @Language = 'vi-VN' 
SET @ModuleID = 'WM';
SET @FormID = 'WMF0000';

SET @LanguageValue = N'Dashboard kho hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tồn tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.MinPresent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tồn tối đa';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.MaxPresent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đặt hàng lại';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ReOrder' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hết hạn sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.OutDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Top 10 tồn kho nhiều nhất (số lượng)';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.Top10QuantityWM' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Top 10 tồn kho lớn nhất (giá trị)';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.Top10AmountWM' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Top 10 tồn kho lâu nhất (tuổi tồn kho)';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.Top10AgeWM' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Top 10 10 mặt hàng sắp hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.Top10OutDateWM' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ giá trị tồn kho theo kỳ';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ChartInventoryByPeriod' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị tồn kho tính bằng VNĐ';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.AxisYTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ nhập/xuất/tồn kho theo nhóm hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ChartInventoryByGroupProduct' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhập kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ImportName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xuất kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ExportName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.EndName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá trị';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.AxisYTitleGroupChart' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ChartTop' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn kỳ';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.Period' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.FromDateFilter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ToDateFilter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ kỳ';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.FromPeriodFilter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến kỳ';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ToPeriodFilter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.DateSuffix' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VNĐ';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.AmountSuffix' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.Division' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.InventoryType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.DivisionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.DivisionName.CB' , @FormID, @LanguageValue, @Language;

------------------------------------------Ngôn ngữ màn hình xem thông tin tồn kho---------------------------------------------------------
SET @LanguageValue = N'Thông tin tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.InventoryInforTitle' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tồn đầu';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.BeginQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ImportQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng xuất';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ExportQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tồn cuối';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.EndQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng tồn';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.QuantityOnHand' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền tồn đầu';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.BeginAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ImportAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền xuất';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.ExportAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền tồn cuối';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.EndAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số ngày lưu kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.DateInWareHouse' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'WMF0000.Notes01' , @FormID, @LanguageValue, @Language;

------------------------------------Ngôn ngữ màn hình phân quyền Dashboard Quản lý kho hàng------------------------------------------------
SET @LanguageValue = N'Số liệu thống kê'
EXEC ERP9AddLanguage @ModuleID, 'WMD0000.Title', 'WMD0000', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ top tồn kho nhiều/lớn/lâu nhất'
EXEC ERP9AddLanguage @ModuleID, 'WMD0001.Title', 'WMD0001', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ giá trị nhập/xuất/tồn kho theo nhóm hàng'
EXEC ERP9AddLanguage @ModuleID, 'WMD0002.Title', 'WMD0002', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ giá trị tồn kho theo kỳ'
EXEC ERP9AddLanguage @ModuleID, 'WMD0003.Title', 'WMD0003', @LanguageValue, @Language;