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
SET @Language = 'en-US'
SET @ModuleID = 'OO';
SET @FormID = 'OOF0032';

SET @LanguageValue = N'Details Setting working time';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit code';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Code';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.YearID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Since';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update day';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Updater';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Late fine';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.PunishLate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start Day Off';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.StartDayOff', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Day Off';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.EndDayOff', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IsCompens';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.IsCompens', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Setting Details';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.XemChiTietThietLap', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Working time';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.ThoiGianLamViec', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'List Day off';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.DanhSachNgayNghi', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Number Lunch Breaks';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.HoursBreak', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Begin Break';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.BeginBreak', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Break';
EXEC ERP9AddLanguage @ModuleID, 'OOF0032.EndBreak', @FormID, @LanguageValue, @Language;