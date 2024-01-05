------------------------------------------------------------------------------------------------------
-- Script t?o ngôn ng? CIF1151 
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
SET @FormID = 'CIF1151';
------------------------------------------------------------------------------------------------------
--- Title
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Cập nhật đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Title' , @FormID, @LanguageValue, @Language;

--- TAB
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DivisionID' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ObjectTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thương hiệu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.TradeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CountryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/Thành phố';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CityID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Website' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Contactor' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Phonenumber' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Email' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vãng lai';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsUpdateName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsSupplier' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsCustomer' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Fax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.VATNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.S1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.S2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.S3' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích đối tượng 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.O01ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích đối tượng 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.O02ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích đối tượng 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.O03ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích đối tượng 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.O04ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích đối tượng 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.O05ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền giao dịch';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CurrencyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn mức nợ cho phép';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ReCreditLimit' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.RePaymentTermID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số ngày phải thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ReDueDays' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn mức tuổi nợ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ReDays' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Fax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khóa (Ngưng bán hàng)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsLockedOver' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản phải thu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ReAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn mức nợ cho phép';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaCreditLimit' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều khoản thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaPaymentTermID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số ngày phải thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaDueDays' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số ngày hưởng chiếc khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaDiscountDays' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ lệ hưởng chiếc khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaDiscountPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ReAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản phải trả';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.BankName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.BankAccountNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số giấy phép';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.LicenseNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vốn điều lệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.LegalCapital' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Note' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Note1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khu vực';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.AreaID' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Điều khoản bán hàng, phải thu';
EXEC ERP9AddLanguage @ModuleID, 'CI1151.IsRePayment' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điều khoản mua hàng, phải trả';
EXEC ERP9AddLanguage @ModuleID, 'CI1151.IsPaPayment' , @FormID, @LanguageValue, @Language;





SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ThongTinChung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin thương mại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ThuongMai' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin khác';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ThongTinKhac' , @FormID, @LanguageValue, @Language;



SET @LanguageValue = N'Mã tỉnh/thành phố';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CityID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên tỉnh/thành phố';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CityName.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CountryID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CountryName.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CurrencyID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CurrencyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.AccountID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.AccountName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.AnaID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.AnaName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã ĐKTT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaymentTermID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên DKTT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.PaymentTermName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại đối tương';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ObjectTypeID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên loại đối tương';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ObjectTypeName.CB' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Người dùng hệ thống';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsUser' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng phụ thuộc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.RelationObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.RelationObjectID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.RelationObjectName.CB' , @FormID, @LanguageValue, @Language;

--[Đình Hoà] [21/07/2020] Thêm ngôn ngữ cho control
SET @LanguageValue = N'Sử dụng hoá đơn điện tử';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsUsedEInvoice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng HĐĐT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.EInvoiceObjectID' , @FormID, @LanguageValue, @Language;

--[Đình Hoà] [03/09/2020] Thêm ngôn ngữ cho control
SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryCountryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vùng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryPostalCode' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/Thành';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryCityID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quận/Huyện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryDistrictID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phường/xã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryWard' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tuyến đường';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.RouteName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thêm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.btnAddDeli' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xoá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.btnCleanDeli' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.AddressMTH' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.btnUpdateDeli' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Huỷ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.btnCancelDeli' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vùng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.AreaID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên vùng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.AreaName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quận/huyện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DistrictID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên quận/huyện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DistrictName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DutyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DutyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chức vụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DutyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhà phân phối';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsDealer' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tỉnh/thành';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryCityID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tỉnh/thành';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DeliveryCityName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoảng cách (Km)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Distance' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giao tại chành';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.IsDelivery' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cưới';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.WeddingDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đại diện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.RepresentativeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CCCD/CMND';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.CICName_Repr' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DateOfBirth_Repr' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại liên lạc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.Phonenumber_Repr' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quận/Huyện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.DistrictID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phường/Xã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.WardID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số nhà';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ApartmentNumb' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đường';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.StreetName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi nhanh ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.BankBrachName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Phường/xã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.WardID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên Phường/xã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.WardName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ObjectID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1151.ObjectName.CB' , @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;