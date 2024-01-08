-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2242 - CRM
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
SET @FormID = 'CRMF2242';

SET @LanguageValue = N'Xem chi tiết thuê bao';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin thuê bao';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.ThongTinThueBao', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thuê bao';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.SubscriberID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy chủ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.ServerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đường dẫn Web';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.UrlWeb', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đường dẫn API';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.UrlAPI', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên miền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.Subdomain', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn online';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.SourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.CustomerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dung lượng lưu trữ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.MemoryStorage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng người dùng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.MaxUser', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng thử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.IsTrial', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.CreateSubscriberDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết thuê bao';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.ChiTietThueBao', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.PackageID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.PackageName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gói';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.IsPackage', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.LeadName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chính thức';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2242.IsOfficial', @FormID, @LanguageValue, @Language;