DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1172'
---------------------------------------------------------------

SET @LanguageValue  = N'Xem chi tiết mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phế phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsVIP',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.S3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.AccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản doanh thu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.SalesAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'TK hàng bán trả lại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ReSalesAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản giá vốn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.PrimeCostAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.PurchaseAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.VATGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế nhập khẩu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.VATImGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Nhóm thuế nhập khẩu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.VATImPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ProductTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá nhập';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.RecievedPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá xuất';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.DeliveryPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.PurchasePrice01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.PurchasePrice02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.PurchasePrice03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.PurchasePrice04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.PurchasePrice05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.SalePrice01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.SalePrice02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.SalePrice03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.SalePrice04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.SalePrice05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phương pháp tính giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.MethodID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Theo lô';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsSource',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsLimitDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsDiscount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quản lý tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsStocked',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I01ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I02ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I03ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I04ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I05ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I06ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I07ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I08ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I09ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.I10ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Khối lượng bì';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Varchar01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ĐVT khác';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Varchar02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Hệ số ĐVT khác';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Varchar03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Varchar04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Varchar05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Varchar06',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Varchar07',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Varchar08',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Varchar09',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Varchar10',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đặt tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Specification',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tiếng anh';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú / Notes';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Notes02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Notes03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.RefInventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vạch';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Barcode',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hàng hóa chịu thuế BVMT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ETaxID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ quy đổi ra đơn vị tính thuế BVMT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ETaxConvertedUnit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tài nguyên chịu thuế tài nguyên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.NRTClassifyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hàng hóa dịch vụ chịu thuế TTDB';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.SETID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xác định mức tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsNorm',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.AccountName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.GroupName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ảnh đại diện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172ImageID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsWareHouseName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'mã định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.NormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.MinQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.MaxQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ReOrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ThongTinMatHang',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin khác';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ThongTinKhac',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin tài khoản tồn kho - doanh thu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ThongTinTaiKhoanTonKhoDoanhThu',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin định mức tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ThongTinDinhMucTonKho',  @FormID, @LanguageValue, @Language;

---[Đình Hoà] [22/07/2020] Thêm ngôn ngữ
SET @LanguageValue  = N'Tồn kho an toàn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsMinQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng chi phí';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsExpense',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phiếu quà tặng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsGiftVoucher',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.NormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.MinQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.MaxQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức đặt hàng lại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.ReOrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsCheck',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.StandardID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.StandardName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị ban đầu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsBeginningValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chọn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsUsed',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị ban đầu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.OriginalValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.WareHouseID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.WareHouseName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.NormID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phế phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsVIP',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính theo diện tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1172.IsArea',  @FormID, @LanguageValue, @Language;
