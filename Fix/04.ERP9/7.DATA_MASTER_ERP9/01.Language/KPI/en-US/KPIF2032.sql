-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF2032- KPI
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
SET @FormID = 'KPIF2032';

SET @LanguageValue = N'Soft salary coefficient View';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.TableID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table Name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.TableName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CompletionRate';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.CompletionRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SoftwageCoefficient';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.SoftwageCoefficient', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2031.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Soft salary coefficient';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.HeSoTinhLuongMem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Soft salary coefficient details';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.ChiTietHeSoTinhLuongMem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'KPIF2032.StatusID', @FormID, @LanguageValue, @Language;