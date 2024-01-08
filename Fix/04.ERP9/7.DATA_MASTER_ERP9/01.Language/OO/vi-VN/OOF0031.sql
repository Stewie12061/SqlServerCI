-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF0031- OO
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
SET @FormID = 'OOF0031';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.YearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Áp dụng từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'STT';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.StartDayOff', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.EndDayOff', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nghỉ bù';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.IsCompens', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số giờ làm việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.HoursWork', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ giờ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.BeginTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến giờ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.EndTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ hai';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.IsWorkMon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ ba';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.IsWorkTues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ tư';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.IsWorkWed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ năm';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.IsWorkThurs', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ sáu';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.IsWorkFri', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ bảy';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.IsWorkSat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủ nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.IsWorkSun', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật thiết lập thời gian làm việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách ngày nghỉ đặc biệt';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.TabOOT0031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian làm việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.TabOOT0032', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số giờ nghỉ trưa';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.HoursBreak', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ giờ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.BeginBreak', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến giờ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.EndBreak', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền phạt đi trễ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.PunishLate', @FormID, @LanguageValue, @Language;

