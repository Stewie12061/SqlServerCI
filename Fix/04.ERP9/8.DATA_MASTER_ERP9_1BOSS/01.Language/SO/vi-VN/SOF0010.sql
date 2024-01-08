
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF0010 - OO
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF0010';

SET @LanguageValue = N'Dashboard';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng doanh số';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.TotalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.TotalOrder' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh số trung bình';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.AverageAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn đặt lại';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.ReOrder' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.TotalProduct' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'So với cùng kỳ năm trước';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.ComparePeriod' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Top 10 khách hàng có doanh số cao nhất';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.ChartCustomer' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.ChartOrderStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chưa duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.UnconfirmName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đang thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.ProcessName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hoàn tất';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.CompleteName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn kỳ';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.Period' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Top 10 sản phẩm bán chạy nhất';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.ChartSellProduct' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.AxisQuantityName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉ lệ';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.AxisPercentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.ProductName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉ lệ';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.PercentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.TranYear' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.Target' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.Employee' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sale in';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.SaleIn' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sale out';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.SaleOut' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh số thực tế so với kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.ChartTarget' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.TargetName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực tế';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.RealName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉ lệ hoàn thành kế hoạch doanh số';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.ChartTargetPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh số theo nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.ChartSaleMan' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh số';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.SaleName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh số trung bình';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.AVGName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF0010.OrderStatus' , @FormID, @LanguageValue, @Language;