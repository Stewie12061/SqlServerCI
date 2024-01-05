declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'

SET @FormID = 'CRMR3005'
SET @LanguageValue = N'Tổng hợp tỷ lệ chuyển đổi từ cơ hội';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3005.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3005'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3005.DivisionID' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'CRMR3005'
-- SET @LanguageValue = N'Từ giai đoạn';
-- EXEC ERP9AddLanguage @ModuleID, 'CRMR3005.FromStageID' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'CRMR3005'
-- SET @LanguageValue = N'Đến giai đoạn';
-- EXEC ERP9AddLanguage @ModuleID, 'CRMR3005.ToStageID' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'CRMR3005'
-- SET @LanguageValue = N'Từ nhân viên';
-- EXEC ERP9AddLanguage @ModuleID, 'CRMR3005.FromSalesManName' , @FormID, @LanguageValue, @Language;

-- SET @FormID = 'CRMR3005'
-- SET @LanguageValue = N'Đến nhân viên';
-- EXEC ERP9AddLanguage @ModuleID, 'CRMR3005.ToSalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3005'
SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3005.SalesManName' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMR3005'
SET @LanguageValue = N'Giai đoạn';
EXEC ERP9AddLanguage @ModuleID, 'CRMR3005.StageID' , @FormID, @LanguageValue, @Language;
