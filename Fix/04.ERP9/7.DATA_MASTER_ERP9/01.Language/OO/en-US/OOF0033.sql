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
SET @Language = 'en-US' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF0033';

SET @LanguageValue = N'Setting Time Repeat';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repeat days';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.DayOfWeek', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repeat days';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.DayOfWeek1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'day';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.DayNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day Of Month Year';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.DayOfMonthYear1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day Of Month';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.DayOfMonthYear2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day Of Month Years';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.DayOfMonthYear3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day Of Month';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.DayOfMonthYear4', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Time';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.EndTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Every Days';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.EveryDays', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Every Days';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.EveryDays1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MonDay';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.IsMonday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TuesDay';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.IsTuesday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Wednesday';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.IsWednesday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MonDay';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.IsMonday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Friday';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.IsFriday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Saturday';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.IsSaturday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SunDay';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.IsSunday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'EveryDay';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.RecurrenceTypeID0', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'DayOfWeek';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.RecurrenceTypeID1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Month';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.RecurrenceTypeID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Years';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.RecurrenceTypeID3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start Time';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.StartTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'of year';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.TheMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'of month';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.WeekOfMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Every';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.DayNumber1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Period Frequency';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.Tab01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time Effect';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.Tab02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The Day';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.TheDay', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'of month';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.WeekOfMonth1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'of year';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.TheMonth1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create the job first';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.IsNumberOfRepeat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'month(s)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.Months', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'of every';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.OfEvery', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year(s)';
EXEC ERP9AddLanguage @ModuleID, 'OOF0033.Years', @FormID, @LanguageValue, @Language;
