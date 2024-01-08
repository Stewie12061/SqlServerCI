-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF0030 - CRM
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
SET @FormID = 'CRMF0030';

SET @LanguageValue = N'Dashboard dịch vụ khách hàng (CS)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số yêu cầu hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.TotalSupportTiket', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số cuộc gọi vào';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.TotalCall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số cuộc gọi bị nhỡ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.TotalMissedCall', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu suất';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.CurrentPerformance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số yêu cầu dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.TotalServiceRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số thời gian gọi vào';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.CallTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian gọi vào trung bình';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.AvgCallTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phần trăm hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.PercentComplete', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.Division', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn kỳ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.Period', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'So với cùng kỳ năm trước';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.ComparePeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê số lượng {0} theo trạng thái (CS)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.ChartRSStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng: {0}';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.SubtitleRSStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.RequestService', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.RequestSupport', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.Business', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê số lượng yêu cầu hỗ trợ theo khách hàng (CS)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.ChartRSCustomerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình hình thực hiện Yêu cầu hỗ trợ/Yêu cầu dịch vụ (CS)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.ChartImplementName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phút';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.SuffixMinutes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.RequestServiceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.RequestSupportName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chưa xử lý';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.UnExecuteName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đang làm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.DoingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.CompleteName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trễ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.OutDateName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.Employee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.Object', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số yêu cầu hỗ trợ đang trễ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.LateSupportTiket', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số yêu cầu dịch vụ chưa điều phối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.NotCodinatorServiceRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng quan công ty';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.GeneralDVKH', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết team/cá nhân';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.DetailDVKH', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.DivisionID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0030.DivisionName.CB', @FormID, @LanguageValue, @Language;
------------------------------------Ngôn ngữ màn hình phân quyền Dashboard Quan hệ khách hàng------------------------------------------------
-- SET @LanguageValue = N'Tổng quan công ty';
-- EXEC ERP9AddLanguage @ModuleID, 'CRMD0029.Title', 'CRMD0029', @LanguageValue, @Language;

-- SET @LanguageValue = N'Chi tiết cá nhân/team';
-- EXEC ERP9AddLanguage @ModuleID, 'CRMD0030.Title', 'CRMD0030', @LanguageValue, @Language;

SET @LanguageValue = N'Số liệu thống kê tổng hợp (CS)';
EXEC ERP9AddLanguage @ModuleID, 'CRMD0031.Title', 'CRMD0031', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê số lượng yêu cầu hỗ trợ/yêu cầu dịch vụ theo trạng thái (CS)';
EXEC ERP9AddLanguage @ModuleID, 'CRMD0032.Title', 'CRMD0032', @LanguageValue, @Language;

SET @LanguageValue = N'Biểu đồ thống kê số lượng yêu cầu hỗ trợ theo khách hàng (CS)';
EXEC ERP9AddLanguage @ModuleID, 'CRMD0033.Title', 'CRMD0033', @LanguageValue, @Language;

SET @LanguageValue = N'Số liệu thống kê chi tiết (CS)';
EXEC ERP9AddLanguage @ModuleID, 'CRMD0034.Title', 'CRMD0034', @LanguageValue, @Language;

SET @LanguageValue = N'Tình hình thực hiện yêu cầu hỗ trợ/yêu cầu dịch vụ (CS)';
EXEC ERP9AddLanguage @ModuleID, 'CRMD0035.Title', 'CRMD0035', @LanguageValue, @Language;