-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1011- CRM
------------------------------------------------------------------------------------------------------
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1011';

SET @LanguageValue = N'Cập nhật khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.VATNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tel';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Tel', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Fax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Website' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tuyến giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.RouteName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Là tổ chức( Chọn: tổ chức; Không chọn: cá nhân)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.IsOrganize', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.ContactName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng VAT khác';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.IsVATAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng VAT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.VATAccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giao hàng kèm theo hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.IsInvoice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn mức nợ thu cho phép';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.ReCreditLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 01';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.O01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 02';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.O02ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 03';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.O03ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 04';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.O04ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 05';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.O05ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BillAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phường/xã';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BillWard' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quận/Huyện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BillDistrictID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/Thành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BillCityID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vùng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BillPostalCode' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BillCountryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DeliveryAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phường/xã';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DeliveryWard' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quận/Huyện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DeliveryDistrictID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/Thành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DeliveryCityID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vùng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DeliveryPostalCode' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DeliveryCountryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.RouteID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quận/huyện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DistrictID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quận/huyện';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DistrictName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tỉnh/thành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.CityID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tỉnh/thành';	
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.CityName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.CountryID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.CountryName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.AnaID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.AnaName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngưng sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.IsUsing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.CommonInfo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BillInfo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DeliveryInfo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú đường đi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Description01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhãn hiệu 01';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Description02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhãn hiệu 02';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Description03' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhãn hiệu 03';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Description04' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhãn hiệu 04';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Description05' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chu kỳ đặt nước';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.PeriodWater' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn mức vỏ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BottleLimit' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.ConvertUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.ConvertUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DescriptionConvert' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lý do chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.CauseConverted' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BirthDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.S3' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.S2' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.S1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.AssignedToUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.AssignedToUserName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tham số';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Varchar' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BusinessLinesID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vùng/khu vực';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.AreaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên vùng/khu vực';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.AreaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã LVKD';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BusinessLinesID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên LVKD';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BusinessLinesName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.IsCustomer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.VATAccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.AccountID', @FormID, @LanguageValue, @Language;

-- Custom: MAITHU
SET @LanguageValue  = N'Cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.btnUpdateDeli',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thêm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.btnAddDeli',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Xoá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.btnCleanDeli',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Huỷ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.btnCancelDeli',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ {0}';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.AddressMTH',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BankName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.BankAccountNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tỉnh/thành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DeliveryCityID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tỉnh/thành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.DeliveryCityName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cảnh báo không phát sinh đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.WarningNoOrdersGenerated',  @FormID, @LanguageValue, @Language;

-- Custom: VNA
SET @LanguageValue  = N'Mã địa điểm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.StationID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên địa điểm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.StationName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoảng cách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.Distance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tuyến đường';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.RouteName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạm gần nhất';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1011.StationID', @FormID, @LanguageValue, @Language;
