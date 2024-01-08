-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2190- OO
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
SET @FormID = 'OOF2190';

SET @LanguageValue = N'Danh mục quản lý milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.MilestoneID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.MilestoneName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release Verion';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.ReleaseVerion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả Milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.TypeOfMilestone', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.ProjectID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2190.ProjectName.CB', @FormID, @LanguageValue, @Language;

