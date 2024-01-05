-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF0010 - OO
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
SET @ModuleID = 'QC';
SET @FormID = 'QCF0010';

SET @LanguageValue = N'Dashboard chất lượng đầu ca';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ cột hàng NG ';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.ChartLineProductNGVertical' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ cột hàng NG theo tháng';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.ChartLineProductNGMonthVertical' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ cột hàng NG theo tuần';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.ChartLineProductNGWeekVertical' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ tỷ lệ hàng NG theo Line tháng/ tuần (Dữ liệu cột theo Line)';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.ChartQCD0002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.Division' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Line mục tiêu';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.TargetLine' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.TranYear' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.TranMonth' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% Số lượng hàng NG';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.QuantityUnQC' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn tuần';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.Week' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn kỳ';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.Period' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ theo';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.TypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn Line';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.Line' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn tuần';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.TranWeek' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'BIỂU ĐỒ TỶ LỆ HÀNG NG CÁC LINE THÁNG/TUẦN';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.NGRatioChart' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'BIỂU ĐỒ TỶ LỆ HÀNG NG CÁC LINE THÁNG';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.NGRatioChartMonth' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'BIỂU ĐỒ TỶ LỆ HÀNG NG CÁC LINE TUẦN';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.NGRatioChartWeek' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.Suplier' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'BIỂU ĐỒ TỶ LỆ HÀNG NG THEO NHÀ CUNG CẤP';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.QCD0004Chart' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.AnaID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.AnaName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mục tiêu';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.Target' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực tế';
EXEC ERP9AddLanguage @ModuleID, 'QCF0010.Actual' , @FormID, @LanguageValue, @Language;

------------------------------------Ngôn ngữ màn hình phân quyền Dashboard Bán hàng------------------------------------------------

SET @LanguageValue = N'Số liệu thống kê hàng NG theo Line (Biểu đồ cột)'
EXEC ERP9AddLanguage @ModuleID, 'QCD0000.Title', 'QCD0000', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ cột hàng NG theo Line'
EXEC ERP9AddLanguage @ModuleID, 'QCD0001.Title', 'QCD0001', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ tỷ lệ hàng NG theo Line tháng/ tuần (Dữ liệu cột theo Line)'
EXEC ERP9AddLanguage @ModuleID, 'QCD0002.Title', 'QCD0002', @LanguageValue, @Language;