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
SET @Language = 'en-US'
SET @ModuleID = 'OO';
SET @FormID = 'OOF0031';

SET @LanguageValue = N'Update Setting work time';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.YearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Orders';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start Day Off';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.StartDayOff', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Day Off';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.EndDayOff', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Late fine';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.PunishLate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IsCompens';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.IsCompens', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hours Work';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.HoursWork', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Begin Time';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.BeginTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Time';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.EndTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Monday';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.IsWorkMon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tuesday';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.IsWorkTues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Wednesday';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.IsWorkWed', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thrusday';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.IsWorkThurs', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Friday';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.IsWorkFri', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Saturday';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.IsWorkSat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sunday';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.IsWorkSun', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'List Special Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.TabOOT0031', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time Work';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.TabOOT0032', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number Lunch Breaks';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.HoursBreak', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Begin Break';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.BeginBreak', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Break';
EXEC ERP9AddLanguage @ModuleID, 'OOF0031.EndBreak', @FormID, @LanguageValue, @Language;

