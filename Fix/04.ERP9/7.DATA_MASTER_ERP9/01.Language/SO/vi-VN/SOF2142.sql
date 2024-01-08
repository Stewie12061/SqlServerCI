------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2142 - SO
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
SET @FormID = 'SOF2142';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Xem chi tiết phương án kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.CuratorName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủ đầu tư';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.InvestorName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng thầu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.GeneralContractorName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ContractName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'PL hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.AppendixContractName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quản lý dự án';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ProjectManagementName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'GS Thi Công';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ClerkName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh thu bán hàng chưa VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.RevenueExcludingVAT' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh thu bán hàng có VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.Revenue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng giá vốn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.TotalCostOfGoodsSold' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lợi nhuận trước thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ProfitBeforeTax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ suất lợi nhuận';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ProfitMargin' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông số kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.Specification' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diện tích';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.Area' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.Quantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá vốn/SP';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.CostPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.Coefficient' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá bán/SP';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lợi nhuận/SP';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.Profit' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng giá vốn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.TotalCostPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ giá vốn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.CostPriceRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh thu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.Revenue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng lợi nhuận';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.TotalProfit' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.VATGroupName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'%Thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.VATPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.VATOriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.StandardID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.StandardName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.VATGroupID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.VATGroupName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.AnaID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.AnaName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn nhiều mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.lblBtnInventoryList' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin phương án kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.ThongTinChung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết phương án kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.TabSOT2141' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.CRMT90031' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.CRMT00002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2142.StatusID',  @FormID, @LanguageValue, @Language;
