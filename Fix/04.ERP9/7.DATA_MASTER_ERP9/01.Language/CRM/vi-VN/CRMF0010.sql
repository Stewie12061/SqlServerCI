-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF0010- CRM
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
SET @FormID = 'CRMF0010';

SET @LanguageValue = N'Dashboard';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phễu bán hàng và dữ liệu thống kê';
EXEC ERP9AddLanguage @ModuleID, 'CRMD0001.Title', 'CRMD0001', @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách cơ hội lâu không tương tác';
EXEC ERP9AddLanguage @ModuleID, 'CRMD0003.Title', 'CRMD0003', @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách đầu mối lâu không tương tác';
EXEC ERP9AddLanguage @ModuleID, 'CRMD0004.Title', 'CRMD0004', @LanguageValue, @Language;

SET @LanguageValue = N'Phễu bán hàng và dữ liệu thống kê';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.SalesFunnelChart', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lọc dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.btnFilter', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phễu bán hàng theo nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.FunnelEmployee', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.Lead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.Opportunity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.Customer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đầu mối mới: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.newLead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số đầu mối: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.totalLead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số cơ hội: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.totalOpportunity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thắng: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.newOpportityWin', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thua: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.newOpportityLost', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.Request', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu mới: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.newRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số yêu cầu: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.totalRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng mới: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.newCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số khách hàng: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.totalCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.Contact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Liên hệ mới: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.newContact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số liên hệ: ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.totalContact', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh số';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.sales', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách cơ hội lâu không tương tác';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.GridOpportunity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách đầu mối lâu không tương tác';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.GridLead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn Kỳ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.Period', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chúc mừng sinh nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.BirthToDayNotify', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sắp đến sinh nhật của';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.BirthDayNotify', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Happy Pride Day!';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.HappyPrideDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dữ liệu thống kê';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0010.StatisticalTitle', @FormID, @LanguageValue, @Language;