DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1171'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.UnitID.CB',  @FormID, @LanguageValue, @Language;
SET @LanguageValue  = N'Tên đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.UnitName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.InventoryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.InventoryTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân loại tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.InventoryTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân loại tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.InventoryTypeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.AccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.AccountID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.AccountName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản doanh thu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SalesAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'TK hàng bán trả lại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ReSalesAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản giá vốn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.PrimeCostAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.PurchaseAccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.VATGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.VATGroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.VATGroupName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.VATPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm thuế nhập khẩu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.VATImGroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'% Nhóm thuế nhập khẩu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.VATImPercent',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ProductTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá nhập';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.RecievedPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá xuất';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.DeliveryPrice',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.PurchasePrice01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.PurchasePrice02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.PurchasePrice03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.PurchasePrice04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá mua 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.PurchasePrice05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán 01';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SalePrice01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán 02';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SalePrice02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán 03';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SalePrice03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán 04';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SalePrice04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá bán 05';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SalePrice05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Theo lô';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsSource',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsLimitDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsDiscount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quản lý tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsStocked',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I01ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I02ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I03ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I04ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I05ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I06ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I07ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I08ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I09ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.I10ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Khối lượng bì' ELSE N'Tham số 1' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Varchar01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'ĐVT khác' ELSE N'Tham số 2' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Varchar02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Hệ số ĐVT khác' ELSE N'Tham số 3' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Varchar03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Varchar04',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Varchar05',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 6';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Varchar06',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 7';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Varchar07',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 8';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Varchar08',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 9';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Varchar09',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tham số 10';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Varchar10',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đặt tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Specification',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Tên tiếng anh' ELSE N'Ghi chú 1' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Notes01',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Ghi chú / Notes' ELSE N'Ghi chú 2' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Notes02',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Notes03',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.RefInventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vạch';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Barcode',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hàng hóa chịu thuế BVMT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ETaxID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỷ lệ quy đổi ra đơn vị tính thuế BVMT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ETaxConvertedUnit',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại tài nguyên chịu thuế tài nguyên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.NRTClassifyID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại hàng hóa dịch vụ chịu thuế TTDB';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SETID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xác định mức tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsNorm',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Nhập trước xuất trước (FIFO)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.MethodID1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bình quân gia quyền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.MethodID2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thực tế đích danh';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.MethodID3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bình quân gia quyền liên hoàn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.MethodID4',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Ảnh đại diện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Image01ID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ThongTinChung',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin khác';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ThongTinKhac',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SETID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SETName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tài nguyên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.NRTClassifyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tài nguyên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.NRTClassifyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ETaxID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ETaxName.CB',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tất cả các kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SelectALLMethod',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từng kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.NormMethod',  @FormID, @LanguageValue, @Language;

---[Đình Hoà] [21/07/2020] Thêm ngôn ngữ
SET @LanguageValue  = N'Tài khoản tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.TaiKhoanTonKho',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản doanh thu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.TaiKhoanDoanhThu',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định mức tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.DinhMucTonKho',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quy cách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.QuyCachHang',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quản lý số seri';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.QuanLiSoSeri',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Tồn kho an toàn';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsMinQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại mặt hàng chi phí';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsExpense',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phiếu quà tặng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsGiftVoucher',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.AccountName',  @FormID, @LanguageValue, @Language;

--[Đình Hoà] [27/07/2020] Thêm ngôn ngữ

SET @LanguageValue  = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.WareHouseID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.NormID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.MinQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.MaxQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức đặt hàng lại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ReOrderQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.StandardID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.StandardName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản doanh thu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.AccountIDDT',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xác định mức tồn kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsDefineStockNorm',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tất cả các kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsWareHouse',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Từng kho';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsEveryWarehouse',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên loại quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.UserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã loại quy cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.TypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.MinQuantity10805',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.MaxQuantity10805',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức đặt hàng lại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ReOrderQuantity10805',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.NormID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phế phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsVIP',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phế phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1170.IsVIP',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tạo mã tăng tự động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.AutoSerial',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Enabled1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Enabled2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Enabled3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên Phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S1Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S2Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên Phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S3Type',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ví dụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Example',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dạng hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.OutputOrder',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dấu phân cách';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.Separator',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Độ dài';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.OutputLength',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đặt lại chỉ số tăng tự động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsLastKey',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chỉ số';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.LastKey',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ClassifyID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.ClassifyName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.S.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.SName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tính theo diện tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1171.IsArea',  @FormID, @LanguageValue, @Language;

