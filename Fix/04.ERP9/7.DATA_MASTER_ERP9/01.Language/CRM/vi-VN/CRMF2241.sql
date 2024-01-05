-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2241 - CRM
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
SET @FormID = 'CRMF2241';

SET @LanguageValue = N'Cập nhật thuê bao';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thuê bao';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.SubscriberID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy chủ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.ServerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên miền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.Subdomain', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn online';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.SourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.CustomerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dung lượng lưu trữ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.MemoryStorage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng người dùng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.MaxUser', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng thử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.IsTrial', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.CreateSubscriberDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn nhiều sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.ChoosePackageList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.PackageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.PackageName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gói';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.IsPackage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã máy chủ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.ServerID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên máy chủ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.ServerName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.LeadName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chính thức';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2241.IsOfficial', @FormID, @LanguageValue, @Language;