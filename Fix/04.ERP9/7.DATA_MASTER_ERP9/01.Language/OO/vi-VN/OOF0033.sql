	-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF0033- OO
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
SET @FormID = 'OOF0033';

SET @LanguageValue = N'Thiết lập thời gian lặp lại';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thiết lập thời gian lặp lại';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033Title.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' Lặp lại vào các thứ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.DayOfWeek', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lặp lại vào các thứ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.DayOfWeek1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.DayNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lặp lại vào các ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.DayOfMonthYear1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lặp lại vào các thứ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.DayOfMonthYear2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lặp lại vào ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.DayOfMonthYear3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lặp lại vào thứ';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.DayOfMonthYear4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.EndTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mỗi ngày trong tuần';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.EveryDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Every Days';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.EveryDays1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ sáu';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.IsFriday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ hai';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.IsMonday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ bảy';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.IsSaturday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chủ nhật';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.IsSunday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ năm';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.IsThursday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ ba';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.IsTuesday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thứ tư';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.IsWednesday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mỗi ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.RecurrenceTypeID0', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày trong tuần';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.RecurrenceTypeID1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.RecurrenceTypeID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.RecurrenceTypeID3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.StartTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'của năm';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.TheMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'của tháng';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.WeekOfMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mỗi';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.DayNumber1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chu kì lặp lại';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.Tab01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian hiệu lực';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.Tab02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lặp lại vào ngày';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.TheDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'của tháng';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.WeekOfMonth1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'của năm';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.TheMonth1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tạo công việc trước';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.IsNumberOfRepeat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'tháng';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.Months', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'của mỗi';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.OfEvery', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'năm';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.Years', @FormID, @LanguageValue, @Language;
