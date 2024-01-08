declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'Vi-VN'

SET @FormID = 'CRMF2021'
SET @LanguageValue = N'Cập nhật phiếu điều phối Master';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2021.Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2021.VATObjectName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tuyến giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2021.RouteName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Nhân viên giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2021.DeliveryEmployeeName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2021.Description' , @FormID, @LanguageValue, @Language;

