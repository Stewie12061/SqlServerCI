declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'Vi-VN'

SET @FormID = 'CRMF2011'
SET @LanguageValue = N'Thêm điều phối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2011.Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tuyến giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2011.RouteName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Nhân viên giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2011.DeliveryEmployeeName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2011.Notes' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2011.InventoryID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2011.UnitID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2011.OrderQuantity' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2011.AccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng cọc, nợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2011.Parameter01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá cọc, nợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2011.Parameter02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền cọc, nợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2011.Parameter03' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2011.Description' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'In thông tin cọc nợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2011.IsDeposit' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Vật tư cho mượn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2011.IsBorrow' , @FormID, @LanguageValue, @Language;