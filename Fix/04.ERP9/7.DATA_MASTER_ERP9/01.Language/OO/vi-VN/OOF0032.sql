-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF0032- OO
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
SET @ModuleID = 'S';
SET @FormID = 'OOF0032';

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.YearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.StartDayOff', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.EndDayOff', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghỉ bù';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.IsCompens', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số giờ làm việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.HoursWork', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giờ bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.BeginTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giờ kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.EndTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ hai';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.IsWorkMon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ ba';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.IsWorkTues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ tư';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.IsWorkWed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ năm';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.IsWorkThurs', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ sáu';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.IsWorkFri', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ bảy';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.IsWorkSat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủ nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.IsWorkSun', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết thiết lập thời gian làm việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem chi tiết thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.XemChiTietThietLap', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian làm việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.ThoiGianLamViec', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách ngày nghỉ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.DanhSachNgayNghi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số giờ nghỉ trưa';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.HoursBreak', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ giờ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.BeginBreak', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến giờ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.EndBreak', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền phạt đi trễ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.PunishLate', @FormID, @LanguageValue, @Language;