-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1032- OO
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
SET @FormID = 'OOF1032';

SET @LanguageValue = N'Xem chi tiết bước quy trình';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.DescriptionT', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thực hiện (giờ)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.ExecutionTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ tự hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bước';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.StepID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên bước';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.StepName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.TaskTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.DanhSachMauCongViecTheoBuoc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin bước';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.XemChiTietBuoc', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.TargetTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.TargetTypeName', @FormID, @LanguageValue, @Language;

--- Modified by Trọng Kiên on 06/11/2020: Bổ sung ngôn ngữ cột StatusID
SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF1032.StatusID', @FormID, @LanguageValue, @Language;

