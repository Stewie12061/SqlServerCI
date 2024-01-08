------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2141 - CRM 
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
SET @FormID = 'SOF2141';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Cập nhật phương án kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.CuratorName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủ đầu tư';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.InvestorName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng thầu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.GeneralContractorName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ContractName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'PL hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.AppendixContractName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên bán hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quản lý dự án';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ProjectManagementName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'GS Thi Công';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ClerkName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh thu bán hàng chưa VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.RevenueExcludingVAT' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh thu bán hàng có VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Revenue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng giá vốn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.TotalCostOfGoodsSold' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lợi nhuận trước thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ProfitBeforeTax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ suất lợi nhuận';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ProfitMargin' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông số kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Specification' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.UnitName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diện tích';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Area' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Quantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá vốn/SP';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.CostPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Coefficient' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giá bán/SP';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.UnitPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lợi nhuận/SP';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Profit' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng giá vốn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.TotalCostPrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ giá vốn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.CostPriceRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh thu';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Revenue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng lợi nhuận';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.TotalProfit' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.VATGroupName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'%Thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.VATPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.VATOriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.StandardID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.StandardName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.VATGroupID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.VATGroupName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.AnaID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.AnaName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn nhiều mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.lblBtnInventoryList' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ý kiến người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.ApprovalNotes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa báo giá kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.IsInheritKT' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa báo giá Sale';
EXEC ERP9AddLanguage @ModuleID, 'SOF2141.IsInheritSale' , @FormID, @LanguageValue, @Language;
