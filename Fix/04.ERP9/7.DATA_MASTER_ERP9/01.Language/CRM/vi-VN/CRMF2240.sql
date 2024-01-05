-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2240 - CRM
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
SET @FormID = 'CRMF2240';

SET @LanguageValue = N'Danh sách thuê bao';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thuê bao';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.SubscriberID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy chủ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.ServerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đường dẫn Web';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.UrlWeb', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đường dẫn API';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.UrlAPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên miền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.Subdomain', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn online';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.SourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.CustomerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dung lượng lưu trữ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.MemoryStorage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng người dùng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.MaxUser', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng thử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.IsTrial', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.CreateSubscriberDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã máy chủ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.ServerID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên máy chủ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.ServerName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.LeadName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chính thức';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2240.IsOfficial', @FormID, @LanguageValue, @Language;