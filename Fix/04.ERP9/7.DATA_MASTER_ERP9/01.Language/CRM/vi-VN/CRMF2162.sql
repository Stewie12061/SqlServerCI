-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2162- OO
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
SET @FormID = 'CRMF2162';

SET @LanguageValue = N'Xem chi tiết yêu cầu hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn  vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.SupportRequiredID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.SupportRequiredName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian phát sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.ContactID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release Version';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.ReleaseVerion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.ContactName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.TypeOfRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ điển hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.SupportDictionaryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết hỗ trợ yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.ThongTinChiTietHoTroYeuCau', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quản lý vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.QuanLyVanDe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử cuộc gọi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.LichSuCuocGoi', @FormID, @LanguageValue, @Language;

-- Hoài Phong [22/03/2021] Bổ sung ngôn ngũ cột chất lượng
SET @LanguageValue = N'Chất lượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2162.StatusQualityOfWork', @FormID, @LanguageValue, @Language;