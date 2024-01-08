-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF0010 - PO
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
SET @ModuleID = 'PO';
SET @FormID = 'POF0010';

SET @LanguageValue = N'Dashboard mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.TotalOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số đơn đã nhận';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.TotalOrderReceived', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.TotalSuppliers', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số tiền đã chi';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.TotalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'So với cùng kỳ năm trước';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.ComparePeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.ChartTop', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn kỳ';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.Period', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Top 10 mặt hàng mua nhiều nhất';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.ChartTopInventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Top 10 nhóm hàng mua nhiều nhất';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.ChartTopInventoryType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Top 10 nhà cung cấp mua nhiều nhất';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.ChartTopSupplier', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.AxisYFName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng tiền';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.AxisYSName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ biến động giá mua';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.ChartVolatilityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt hàng: {0}';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.SubtitlesVolatility', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.Object', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.Inventory', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.ChartOrderStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.Division', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.DivisionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POF0010.DivisionName.CB', @FormID, @LanguageValue, @Language;

------------------------------------Ngôn ngữ màn hình phân quyền Dashboard Mua hàng------------------------------------------------
SET @LanguageValue = N'Số liệu thống kê'
EXEC ERP9AddLanguage @ModuleID, 'POD0000.Title', 'POD0000', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ Top 10 nhóm hàng/mặt hàng/nhà cung cấp mua nhiều nhất'
EXEC ERP9AddLanguage @ModuleID, 'POD0001.Title', 'POD0001', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ biến động giá mua'
EXEC ERP9AddLanguage @ModuleID, 'POD0002.Title', 'POD0002', @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái đơn hàng'
EXEC ERP9AddLanguage @ModuleID, 'POD0003.Title', 'POD0003', @LanguageValue, @Language;