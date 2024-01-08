declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'SO'
SET @Language = 'vi-VN'

SET @FormID = 'SOF2033'
SET @LanguageValue = N'Thủ kho xác nhận giao hàng về';
EXEC ERP9AddLanguage @ModuleID, 'SOF2033.Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Phiếu xuất kho giao nước';
EXEC ERP9AddLanguage @ModuleID, 'SOF2033.TitleGridOut' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Phiếu nhập kho vỏ bình';
EXEC ERP9AddLanguage @ModuleID, 'SOF2033.TitleGridIn' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2033.InventoryID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2033.InventoryName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2033.UnitID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số lượng xuất';
EXEC ERP9AddLanguage @ModuleID, 'SOF2033.RefQuantity' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số lượng thực giao';
EXEC ERP9AddLanguage @ModuleID, 'SOF2033.ActualQuantity' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Số lượng nhập vỏ/bình';
EXEC ERP9AddLanguage @ModuleID, 'SOF2033.ActualQuantityIn' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2033.VoucherDate' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày chứng từ nhập kho';
EXEC ERP9AddLanguage @ModuleID, 'SOF2033.ImVoucherDate' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Vật tư cho mượn';
EXEC ERP9AddLanguage @ModuleID, 'SOF2033.IsBorrow' , @FormID, @LanguageValue, @Language;

