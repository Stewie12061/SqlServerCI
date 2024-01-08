declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'

SET @FormID = 'CRMF3070'
SET @LanguageValue = N'Báo cáo công nợ khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3070.Title' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3070'
SET @LanguageValue = N'TK công nợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3070.DebitAccountID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3070'
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3070.DivisionID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3070'
SET @LanguageValue = N'TK tiền cọc vỏ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3070.DepositAccountID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3070'
SET @LanguageValue = N'TK tổng tiền cọc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3070.TotalDepositAccountID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3070'
SET @LanguageValue = N'Từ mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3070.FromInventoryID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3070'
SET @LanguageValue = N'Đến mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3070.ToInventoryID' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3070'
SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3070.ToDate' , @FormID, @LanguageValue, @Language;

SET @FormID = 'CRMF3070'
SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3070.FromDate' , @FormID, @LanguageValue, @Language;