-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1002- KPI
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
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF1002';

SET @LanguageValue = N'Classification View';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1002.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1002.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From score';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1002.FromScore', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To score';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1002.ToScore', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Classification';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1002.Classification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bonus rate';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1002.BonusRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1002.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1002.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1002.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1002.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1002.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1002.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1002.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1002.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1002.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1002.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classification information';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1002.ThongTinXepLoai',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1002.StatusID',  @FormID, @LanguageValue, @Language;