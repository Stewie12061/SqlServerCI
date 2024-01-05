-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1082- OO
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
SET @FormID = 'OOF1082';

SET @LanguageValue = N'Details of violated working hours';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Late hour percentage';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.NumberHourLate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Penalty rate (%)';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.PunishRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.Note', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Information on penalty regulation';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.ThongTinQuyDinhMucPhat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Detailed information on penalty regulation';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.ThongTinChiTietQuyDinhMucPhat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.DinhKem', @FormID, @LanguageValue, @Language;																				  

SET @LanguageValue = N'Penalty for willful violation (%)';											
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.PunishViolated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table name';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.TableName', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Table ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF1082.TableViolatedID', @FormID, @LanguageValue, @Language;

