DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1170'
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham chiếu mã hàng từ quản lý dự án và ERP';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.MappingToolbar',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.S3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.AccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản doanh thu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.SalesAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'TK hàng bán trả lại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.ReSalesAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản giá vốn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.PrimeCostAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.PurchaseAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.VATGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế nhập khẩu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.VATImGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Nhóm thuế nhập khẩu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.VATImPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.ProductTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá nhập';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.RecievedPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá xuất';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.DeliveryPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.PurchasePrice01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.PurchasePrice02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.PurchasePrice03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.PurchasePrice04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.PurchasePrice05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.SalePrice01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.SalePrice02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.SalePrice03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.SalePrice04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.SalePrice05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Theo kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsSource',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsLimitDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsDiscount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quản lý tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsStocked',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I01ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I02ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I03ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I04ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I05ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I06ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I07ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I08ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I09ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.I10ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Varchar01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Varchar02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Varchar03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Varchar04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đặt tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Specification',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Notes02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Notes03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.RefInventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vạch';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Barcode',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hàng hóa chịu thuế BVMT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.ETaxID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ quy đổi ra đơn vị tính thuế BVMT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.ETaxConvertedUnit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tài nguyên chịu thuế tài nguyên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.NRTClassifyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hàng hóa dịch vụ chịu thuế TTDB';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.SETID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xác định mức tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsNorm',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương pháp tính giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.MethodID',  @FormID, @LanguageValue, @Language;

---[Đình Hoà] [20/07/2020] Thêm ngôn ngữ
SET @LanguageValue  = N'Tồn kho an toàn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsMinQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng chi phí';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsExpense',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phiếu quà tặng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsGiftVoucher',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.NormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.MinQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.MaxQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức đặt hàng lại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.ReOrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsCheck',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.StandardID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.StandardName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị ban đầu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsBeginningValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsUsed',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị ban đầu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.OriginalValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.WareHouseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.WareHouseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.NormID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phế phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsVIP',  @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.UnitID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.UnitName.CB' , @FormID, @LanguageValue, @Language;