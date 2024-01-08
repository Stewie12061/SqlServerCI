-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2211- CRM
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
SET @FormID = 'CRMF2211';

SET @LanguageValue = N'Cập nhật dữ liệu ao đầu mối online';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.DisplayID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.SourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công ty';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.TypeOfSource', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.ProductInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IsComfirmLead';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.IsComfirmLead', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.JobTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.TypeOfSourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.ProductInfoName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DomainERR9';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.DomainERR9', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'UserName';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.UserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Password';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.Password', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã team';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.TeamID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kiểu Ads';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2211.CampaignMedium', @FormID, @LanguageValue, @Language;