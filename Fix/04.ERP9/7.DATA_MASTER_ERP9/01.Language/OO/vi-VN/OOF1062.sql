-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1062- OO
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
SET @FormID = 'OOF1062';

SET @LanguageValue = N'Xem chi tiết mẫu công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mẫu công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mẫu công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thực hiện (giờ)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.ExecutionTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiến độ (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.PercentProgress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.TaskTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên checklist';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.ChecklistName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.AttachFile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin checklist';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.ThongTinChecklist', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin mẫu công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.ThongTinMauCongViec', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.ThongTinMoTa', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chốt chặn';
EXEC ERP9AddLanguage @ModuleID, 'OOF1062.TaskBlockTypeID', @FormID, @LanguageValue, @Language;