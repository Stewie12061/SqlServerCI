-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ
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
SET @ModuleID = 'BI';
SET @FormID = 'BF3035'

SET @LanguageValue  = N'Biểu đồ SALES'
EXEC ERP9AddLanguage @ModuleID, 'BF3035.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xu hướng bán hàng'
EXEC ERP9AddLanguage @ModuleID, 'BF3035.Report1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sản lượng và giá bán'
EXEC ERP9AddLanguage @ModuleID, 'BF3035.Report2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Doanh thu'
EXEC ERP9AddLanguage @ModuleID, 'BF3035.Report3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thống kê bán hàng'
EXEC ERP9AddLanguage @ModuleID, 'BF3035.Report4',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thống kê doanh thu'
EXEC ERP9AddLanguage @ModuleID, 'BF3035.Report5',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thống kê công nợ khách hàng'
EXEC ERP9AddLanguage @ModuleID, 'BF3035.Report6',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sản lượng bán hàng'
EXEC ERP9AddLanguage @ModuleID, 'BF3035.ChartTitle1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Doanh thu'
EXEC ERP9AddLanguage @ModuleID, 'BF3035.ChartTitle2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân bổ doanh thu theo sản phẩm'
EXEC ERP9AddLanguage @ModuleID, 'BF3035.ChartTitle3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thống kê công nợ khách hàng'
EXEC ERP9AddLanguage @ModuleID, 'BF3035.ChartTitle4',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'BF3035.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại biểu đồ'
EXEC ERP9AddLanguage @ModuleID, 'BF3035.ReportBFR3035',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm hàng'
EXEC ERP9AddLanguage @ModuleID, 'BF3035.I03ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'BF3035.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại sản phẩm'
EXEC ERP9AddLanguage @ModuleID, 'BF3035.I02ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày'
EXEC ERP9AddLanguage @ModuleID, 'BF3035.Date',  @FormID, @LanguageValue, @Language;
