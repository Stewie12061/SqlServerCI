-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2214 - CRM
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
SET @FormID = 'CRMF2214';

SET @LanguageValue = N'Chọn dữ liêu nguồn online';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguồn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguồn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.SourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công ty';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.CompanyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.JobTitle', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.TypeOfSourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.ProductInfoName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian ghi nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.WriteTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chiến dịch';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.CampaignName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2214.AssignedToUserName', @FormID, @LanguageValue, @Language;