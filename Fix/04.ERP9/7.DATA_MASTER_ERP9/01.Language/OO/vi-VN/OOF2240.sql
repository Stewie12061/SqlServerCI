-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2240- OO
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
SET @FormID = 'OOF2240';


SET @LanguageValue = N'Danh mục đặt thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đặt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.BookingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiêu đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.BookingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đặt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.BookingUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đặt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.BookingUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.UseUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.UseUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.PlanEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.EquipmentTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.EquipmentTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.EquipmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.EquipmentNameID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cả ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.IsAllDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.EquipmentTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.EquipmentTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.DeviceID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.DeviceName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái đặt';
EXEC ERP9AddLanguage @ModuleID, 'OOF2240.BookingStatusName', @FormID, @LanguageValue, @Language;


