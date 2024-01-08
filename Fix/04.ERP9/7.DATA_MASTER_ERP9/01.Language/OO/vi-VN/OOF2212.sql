-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2212- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF2212';

SET @LanguageValue = N'Xem chi tiết quản lý release';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã release';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.ReleaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên release';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.ReleaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại release';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.TypeOfRelease', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.MilestoneID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.MilestoneName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release Version';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.ReleaseVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tóm tắt và link tải file';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.CreateUserID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.CreateDate2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết quản lý release';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.ThongTinChiTietQuanLyRelease', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.TabCRMT20801', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quản lý vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.TabOOT2160', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.RequestCustomerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.RequestSubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.TypeOfRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chỉ tiêu/Target';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.TabOOT2290', @FormID, @LanguageValue, @Language;