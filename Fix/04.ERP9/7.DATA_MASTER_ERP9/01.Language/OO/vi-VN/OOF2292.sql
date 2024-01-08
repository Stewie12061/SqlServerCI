-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2292- OO
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
SET @FormID = 'OOF2292';

SET @LanguageValue = N'Xem chi tiết chỉ tiêu/target';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chỉ tiêu/target';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.ThongTinChitieuCongViec', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.CRMT90031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.TabOOT2110', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.CRMT00002', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chỉ tiêu/target';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.TargetTaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chỉ tiêu/target';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.TargetTaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Độ ưu tiên';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.PriorityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời điểm bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.BeginDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người giao';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.RequestUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiến độ (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.Progress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.AssignedUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.LastModifyUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2292.StatusName', @FormID, @LanguageValue, @Language;
