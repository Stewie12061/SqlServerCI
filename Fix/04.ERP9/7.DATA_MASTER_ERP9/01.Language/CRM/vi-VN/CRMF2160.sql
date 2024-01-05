-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2160- OO
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
SET @FormID = 'CRMF2160';

SET @LanguageValue = N'Danh mục yêu cầu hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.SupportRequiredID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.SupportRequiredName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian phát sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release Version';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.ReleaseVerion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.TypeOfRequest', @FormID, @LanguageValue, @Language;

-- Hoài Phong [22/03/2021] Bổ sung ngôn ngũ cột chất lượng
SET @LanguageValue = N'Chất lượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2160.StatusQualityOfWork', @FormID, @LanguageValue, @Language;