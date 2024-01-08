declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'

SET @FormID = 'CRMF1010'
SET @LanguageValue = N'Danh mục khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.Title' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.DivisionID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.AccountID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.AccountName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.Address' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.Tel' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.Email' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã khách hàng VAT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.VATAccountID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tuyến giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.RouteID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Là tổ chức';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.IsOrganize' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.IsCommon' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngưng sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.IsUsing' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.Disabled' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.Fax' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.Website' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.Description' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.DeliveryAddress' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Địa chỉ thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.BillAddress' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.BirthDate' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Chuyển đổi từ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.ConvertTypeName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.InheritConvertID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.AssignedToUserID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.BillCountryID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.CountryName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã tỉnh/Thành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.BillCityID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên tỉnh/Thành';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.CityName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã vùng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.BillPostalCode' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên vùng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.AreaName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.CreateDate' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Nhóm kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.O01ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Nhóm thị trường';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.O02ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Hạng khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.O03ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Địa bàn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.O04ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Thời gian khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.O05ID' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Website';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.Website' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Ngày sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.BirthDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.BirthMonth' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Năm sinh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.BirthYear' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã giới tính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.Gender' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên giới tính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.GenderName' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tuổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.YearOld' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.AssignedToUser' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.AssignedToUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1010.AssignedToUserName' , @FormID, @LanguageValue, @Language;