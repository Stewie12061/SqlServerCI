-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2162- OO
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
SET @FormID = 'OOF2162';

SET @LanguageValue = N'Xem chi tiết vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOT2162.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.IssuesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.IssuesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian phát sinh';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deadline yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.RequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release Version';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.ReleaseVerion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.RequestName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.TypeOfIssues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hỗ trợ yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.SupportRequiredID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.SupportRequiredName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.ThongTinChiTietQuanLyVanDe', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.CreateDate2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.CreateUserID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian xác nhận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.TimeConfirm', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Chất lượng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.StatusQualityOfWork', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chỉ tiêu/Target';
EXEC ERP9AddLanguage @ModuleID, 'OOF2162.TargetTaskName', @FormID, @LanguageValue, @Language;