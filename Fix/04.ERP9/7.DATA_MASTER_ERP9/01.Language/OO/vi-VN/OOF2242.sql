-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2242- OO
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
SET @FormID = 'OOF2242';

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin chi tiết đặt thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.XemChiTietDatThietBi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem thông tin chi tiết đặt thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đặt thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.BookingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.BookingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đặt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.BookingUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đặt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.BookingUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.UseUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.UseUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.EquipmentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.EquipmentTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.EquipmentNameID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.EquipmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lặp lại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.IsRepeat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.BookingStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cả ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.IsAllDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khu vực';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.AreaName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái đặt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.BookingStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.TypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.GhiChu', @FormID, @LanguageValue, @Language

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF2242.DinhKem', @FormID, @LanguageValue, @Language
