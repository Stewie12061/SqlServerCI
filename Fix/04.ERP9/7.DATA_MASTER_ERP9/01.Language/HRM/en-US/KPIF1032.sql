-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1032- KPI
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
SET @FormID = 'KPIF1032';

SET @LanguageValue = N'Source View';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Source ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1032.SourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Source name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1032.SourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1032.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N' Common use';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1032.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1032.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1032.TabCRMT00002',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1032.TabCRMT90031',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'History';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1032.TabCRMT00003',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Source Information';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1032.ThongTinNguonDo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1032.StatusID',  @FormID, @LanguageValue, @Language;