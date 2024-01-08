-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF0033- S
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
SET @FormID = 'SF0033';

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Thiết lập lịch trình';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.Title' , @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.FromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mỗi';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.Every' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.ScheduleDay01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mỗi ngày';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.ScheduleDay02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.EndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lặp lại mỗi';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsRepeat' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trong vòng';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.Duration' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Áp dụng';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.EnableAdvancedSetting' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.ScheduleType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ sáu';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsFriday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ hai';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsMonday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ bảy';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsSaturday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủ nhật';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsSunday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ năm';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsThursday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ ba';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsTuesday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ tư';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsWednesday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định kỳ Ngày';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.ScheduleMY01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định kỳ Thứ';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.ScheduleMY02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.Month' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'của Tháng';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.OfMonth' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.Year' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tuần thứ';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.WeekOfMonth' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Áp dụng';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsAdvancedSettings' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsExpired' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trong thời gian';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.WithinTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.ToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tạo trước';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.TimeRunBefore' , @FormID, @LanguageValue, @Language;