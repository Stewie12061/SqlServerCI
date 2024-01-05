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
SET @Language = 'en-US' 
SET @ModuleID = 'S';
SET @FormID = 'SF0033';

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Setting schedule';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.Title' , @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Start';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.FromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Every';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.Every' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.ScheduleDay01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Every Day';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.ScheduleDay02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.EndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rêpat';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsRepeat' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duration';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.Duration' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Apply';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.EnableAdvancedSetting' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.ScheduleType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Friday';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsFriday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Monday';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsMonday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Saturday';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsSaturday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sunday';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsSunday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thursday';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsThursday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tuesday';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsTuesday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Wednesday';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsWednesday', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Regularly Date';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.ScheduleMY01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Regularly Stuff';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.ScheduleMY02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Month';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.Month' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'of Month';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.OfMonth' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Year';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.Year' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Week Of Month';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.WeekOfMonth' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Apply';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsAdvancedSettings' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Expired';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.IsExpired' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Within Time';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.WithinTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.ToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time Run Before';
EXEC ERP9AddLanguage @ModuleID, 'SF0033.TimeRunBefore' , @FormID, @LanguageValue, @Language;