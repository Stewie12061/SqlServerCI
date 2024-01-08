-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1082- KPI
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
SET @FormID = 'KPIF1082';

SET @LanguageValue = N'KPI bonus regulations View';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify Date';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modify User';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From period';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.EffectiveDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To period';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.ExpirationDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Table Name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.TableName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.FromToPeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Completion Rate (%)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.CompletionRate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bonus Level (VND)';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.BonusLevelsKPIs', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI bonus regulations info';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.QuyDinhThuongKPIs', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'KPI bonus regulations details';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.ChiTietQuyDinhThuongKPIs', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1082.StatusID', @FormID, @LanguageValue, @Language;