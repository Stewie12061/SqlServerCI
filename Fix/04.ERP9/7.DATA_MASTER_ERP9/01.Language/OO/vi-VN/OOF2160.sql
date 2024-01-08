-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2160- OO
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
SET @FormID = 'OOF2160';

SET @LanguageValue = N'Danh mục vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOT2160.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.IssuesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.IssuesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian phát sinh';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deadline yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.RequestID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release Version';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.ReleaseVerion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.RequestName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.TypeOfIssues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.SupportRequiredID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Yêu cầu hỗ trợ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.SupportRequiredName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian xác nhận';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.TimeConfirm', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chất lượng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.StatusQualityOfWork', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chỉ tiêu/Target';
EXEC ERP9AddLanguage @ModuleID, 'OOF2160.TargetTaskName', @FormID, @LanguageValue, @Language;

