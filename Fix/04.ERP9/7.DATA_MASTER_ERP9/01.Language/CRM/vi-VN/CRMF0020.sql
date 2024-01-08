-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF0020 - CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF0020';

SET @LanguageValue = N'Dashboard quan hệ khách hàng (CR)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.Lead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.Opportunity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng giá trị cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.TotalOpportunityAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.Customer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.Contract', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.ContractName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đầu mối lâu không tương tác';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.LeadInteraction', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số cơ hội lâu không tương tác';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.OpportunityInteraction', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.Request', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.Contact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng giá trị hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.TotalContractAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'So với cùng kỳ năm trước';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.ComparePeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'VNĐ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.SuffixVND', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.Division', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn kỳ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.Period', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê số lượng theo nghiệp vụ (CR)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.ChartStatisAmountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kỳ hiện tại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.PeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kỳ trước';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.PastPeriodName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giai đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.Stage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ tỷ trọng số lượng cơ hội theo giai đoạn (CR)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.ChartQuantityAmountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số lượng: {0} <br> Tổng giá trị: {1}';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.SubtitleChartQuantityAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phút';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.SuffixMinutes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng cuộc gọi ra';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.CallTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng thời gian gọi ra';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.TotalCall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian gọi ra trung bình';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.AvgCallTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số cuộc gọi ra thành công';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.TotalSuccessCall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phễu tỷ lệ chuyển đổi giữa các trạng thái của {0} (CR)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.ChartStatusFunnelName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.Business', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ giá trị cơ hội theo nhân viên (CR)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.ChartOppValueName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.Employee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng quan công ty';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.GeneralQHKH', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết team/cá nhân';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.DetailQHKH', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.DivisionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0020.DivisionName.CB', @FormID, @LanguageValue, @Language;
------------------------------------Ngôn ngữ màn hình phân quyền Dashboard Quan hệ khách hàng------------------------------------------------
-- SET @LanguageValue = N'Tổng quan công ty';
-- EXEC ERP9AddLanguage @ModuleID, 'CRMD0021.Title', 'CRMD0021', @LanguageValue, @Language;

-- SET @LanguageValue = N'Chi tiết cá nhân/team';
-- EXEC ERP9AddLanguage @ModuleID, 'CRMD0022.Title', 'CRMD0022', @LanguageValue, @Language;

SET @LanguageValue = N'Số liệu thống kê tổng hợp (CR)';
EXEC ERP9AddLanguage @ModuleID, 'CRMD0023.Title', 'CRMD0023', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê số lượng theo nghiệp vụ (CR)';
EXEC ERP9AddLanguage @ModuleID, 'CRMD0024.Title', 'CRMD0024', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ tỷ trọng số lượng cơ hội theo giai đoạn (CR)';
EXEC ERP9AddLanguage @ModuleID, 'CRMD0025.Title', 'CRMD0025', @LanguageValue, @Language;

SET @LanguageValue = N'Số liệu thống kê chi tiết (CR)';
EXEC ERP9AddLanguage @ModuleID, 'CRMD0026.Title', 'CRMD0026', @LanguageValue, @Language;

SET @LanguageValue = N'Phễu tỷ lệ chuyển đổi giữa các trạng thái của cơ hội / đầu mối (CR)';
EXEC ERP9AddLanguage @ModuleID, 'CRMD0027.Title', 'CRMD0027', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ giá trị cơ hội theo nhân viên (CR)';
EXEC ERP9AddLanguage @ModuleID, 'CRMD0028.Title', 'CRMD0028', @LanguageValue, @Language;