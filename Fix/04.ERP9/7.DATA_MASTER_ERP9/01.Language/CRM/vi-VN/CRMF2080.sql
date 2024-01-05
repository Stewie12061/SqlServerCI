-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2080- CRM
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
SET @FormID = 'CRMF2080';

SET @LanguageValue = N'Danh mục yêu cầu khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, N'CRMF2080.AccountID', @FormID, @LanguageValue, @Language, NULL;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, N'CRMF2080.AccountName', @FormID, @LanguageValue, @Language, NULL;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, N'CRMF2080.RelatedToName', @FormID, @LanguageValue, @Language, NULL;

SET @LanguageValue = N'Mã yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.RequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, N'CRMF2080.RequestStatusName', @FormID, @LanguageValue, @Language, NULL;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủ đề';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.RequestSubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, N'CRMF2080.AssignedToUserName', @FormID,@LanguageValue , @Language, NULL;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, N'CRMF2080.PriorityName', @FormID, @LanguageValue, @Language, NULL;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.FeedbackDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.RequestDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.TypeOfRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release Version';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.ReleaseVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2080.RequestCustomerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cơ hội';
EXEC ERP9AddLanguage @ModuleID, N'CRMF2080.OpportunityID.CB', @FormID, @LanguageValue, @Language, NULL

SET @LanguageValue = N'Tên cơ hội';
EXEC ERP9AddLanguage @ModuleID, N'CRMF2080.OpportunityName.CB', @FormID, @LanguageValue, @Language, NULL

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, N'CRMF2080.AssignedToUserID.CB', @FormID, @LanguageValue, @Language, NULL

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, N'CRMF2080.AssignedToUserName.CB', @FormID, @LanguageValue, @Language, NULL

SET @LanguageValue = N'Mã dự án';
EXEC ERP9AddLanguage @ModuleID, N'CRMF2080.ProjectID.CB', @FormID, @LanguageValue, @Language, NULL

SET @LanguageValue = N'Tên dự án';
EXEC ERP9AddLanguage @ModuleID, N'CRMF2080.ProjectName.CB', @FormID, @LanguageValue, @Language, NULL

SET @LanguageValue = N'ExportReport';
EXEC ERP9AddLanguage @ModuleID, N'CRMF2080.Report', @FormID, @LanguageValue, @Language, NULL
