declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'Vi-VN'

SET @FormID = 'CRMF2023'
SET @LanguageValue = N'Cập nhật phiếu điều phối Details';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2023.Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2023.InventoryID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2023.InventoryName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2023.UnitID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2023.ActualQuantity' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2023.UnitPrice' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2023.OriginalAmount' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2023.Notes' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2023.VoucherID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2023.TransactionID' , @FormID, @LanguageValue, @Language;
