-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2082- CRM
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
SET @FormID = 'CRMF2082';

SET @LanguageValue = N'Xem chi tiết yêu cầu khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.RequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
Exec ERP9AddLanguage @ModuleID, N'CRMF2082.AccountName', @FormID, @LanguageValue, @Language, NULL

SET @LanguageValue = N'Chủ đề';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.RequestSubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách'
Exec ERP9AddLanguage @ModuleID, N'CRMF2082.AssignedToUserName', @FormID, @LanguageValue, @Language, NULL

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
Exec ERP9AddLanguage @ModuleID, N'CRMF2082.PriorityName', @FormID, @LanguageValue, @Language, NULL

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian ghi nhận';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phản hồi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.FeedbackDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
Exec ERP9AddLanguage @ModuleID, N'CRMF2082.CreateUserName', @FormID, N'Người tạo', @Language, NULL

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.RequestDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
Exec ERP9AddLanguage @ModuleID, N'CRMF2082.LastModifyUserName', @FormID, @LanguageValue, @Language, NULL

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue =  N'Trạng thái yêu cầu';
Exec ERP9AddLanguage @ModuleID, N'CRMF2082.RequestStatusName', @FormID, @LanguageValue, @Language, NULL

SET @LanguageValue = N'Cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.TypeOfRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue =  N'Đính kèm';
Exec ERP9AddLanguage @ModuleID, N'CRMF2082.TabCRMT00002', @FormID, @LanguageValue, @Language, NULL

SET @LanguageValue = N'Release Version';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.ReleaseVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.RequestCustomerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung yêu cầu';
Exec ERP9AddLanguage @ModuleID, N'CRMF2082.NoiDungYeuCau', @FormID,@LanguageValue, @Language, NULL

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.TabCRMT00003', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.TabCRMT90031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quản lý vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.QuanLyVanDe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung phản hồi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.NoiDungPhanHoi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.TabOOT2110', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2082.ThongTinYeuCau', @FormID, @LanguageValue, @Language;

