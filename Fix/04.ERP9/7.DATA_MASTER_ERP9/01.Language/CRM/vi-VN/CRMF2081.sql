-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2081- CRM
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
SET @FormID = 'CRMF2081';

SET @LanguageValue = N'Cập nhật yêu cầu khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
Exec ERP9AddLanguage @ModuleID, N'CRMF2081.AccountName', @FormID, @LanguageValue , @Language, NULL

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng';
Exec ERP9AddLanguage @ModuleID, N'CRMF2081.AccountID', @FormID, @LanguageValue, @Language, NULL

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RequestSubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
Exec ERP9AddLanguage @ModuleID, N'CRMF2081.AssignedToUserName', @FormID,@LanguageValue, @Language, NULL

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian ghi nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm file';
Exec ERP9AddLanguage @ModuleID, N'CRMF2081.Attach', @FormID, @LanguageValue, @Language, NULL

SET @LanguageValue = N'Phản hồi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.FeedbackDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RequestDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cơ hội';
Exec ERP9AddLanguage @ModuleID, N'CRMF2081.OpportunityID.CB', @FormID, @LanguageValue, @Language, NULL

SET @LanguageValue = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cơ hội';
Exec ERP9AddLanguage @ModuleID, N'CRMF2081.OpportunityName.CB', @FormID, @LanguageValue, @Language, NULL

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.TypeOfRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release Version';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.ReleaseVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2081.RequestCustomerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2181.TablePrice.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2181.TablePriceName.CB', @FormID, @LanguageValue, @Language;

