------------------------------------------------------------------------------------------------------
-- Script t?o ngôn ng? CIF1152 
-----------------------------------------------------------------------------------------------------
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
SET @Language = 'vi-VN' 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1152';

------------------------------------------------------------------------------------------------------
--- Title
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Xem chi tiết đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Title' , @FormID, @LanguageValue, @Language;

--- TAB
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.DivisionID' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ObjectTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thương hiệu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.TradeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.CountryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/Thành phố';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.CityID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Website' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Contactor' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Phonenumber' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Email' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vãng lai';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.IsUpdateName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.IsSupplier' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.IsCustomer' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Fax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.VATNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.S1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.S2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.S3' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích đối tượng 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.O01ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích đối tượng 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.O02ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích đối tượng 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.O03ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích đối tượng 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.O04ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích đối tượng 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.O05ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền giao dịch';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.CurrencyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn mức nợ cho phép';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ReCreditLimit' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.RePaymentTermID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số ngày phải thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ReDueDays' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.DeAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn mức tuổi nợ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ReDays' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Fax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khóa (Ngưng bán hàng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.IsLockedOver' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản phải thu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ReAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn mức nợ cho phép';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.PaCreditLimit' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.PaPaymentTermID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số ngày phải thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.PaDueDays' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số ngày hưởng chiếc khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.PaDiscountDays' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ hưởng chiếc khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.PaDiscountPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ReAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản phải trả';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.PaAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.BankName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.BankAccountNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số giấy phép';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.LicenseNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vốn điều lệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.LegalCapital' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Note1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khu vực';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.AreaID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.CreateUserID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.CreateDate' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.LastModifyDate' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều khoản bán hàng, phải thu';
EXEC ERP9AddLanguage @ModuleID, 'CI1152.IsRePayment' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều khoản mua hàng, phải trả';
EXEC ERP9AddLanguage @ModuleID, 'CI1152.IsPaPayment' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ThongTinChung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin thương mại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ThuongMai' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin khác';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ThongTinKhac' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người dùng hệ thống';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.IsUser' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng phụ thuộc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.RelationObjectName' , @FormID, @LanguageValue, @Language;

--[Đình Hoà] [21/07/2020] Thêm ngôn ngữ cho control
SET @LanguageValue = N'Sử dụng hoá đơn điện tử';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.IsUsedEInvoice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng HĐĐT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.EInvoiceObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.Description',  @FormID, @LanguageValue, @Language;

--[Đình Hoà] [07/09/2020] Thêm ngôn ngữ
SET @LanguageValue  = N'Thông tin địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.ThongTinDiaChiGiaoHang',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.DeliveryAddress',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.CountryName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vùng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.AreaName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tỉnh/Thành';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.CityName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quận/Huyện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.DistrictName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Phường/Xã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.DeliveryWard',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhà phân phối';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.IsDealer' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.TabCRMT00002' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cưới';
EXEC ERP9AddLanguage @ModuleID, 'CIF1152.WeddingDate' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;