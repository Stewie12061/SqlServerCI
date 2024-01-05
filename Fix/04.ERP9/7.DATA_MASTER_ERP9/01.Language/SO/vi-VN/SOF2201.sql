-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2201- SO
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF2201';

SET @LanguageValue = N'Cập nhật tài khoản kích hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.ThongTinCaNhan' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin doanh nghiệp';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.ThongTinDoanhNghiep' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.ThongTinCuaHang' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin bổ sung';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.ThongTinBoSung' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản kích hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.AccountNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tài khoản kích hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.AccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SĐT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại kích hoạt'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.Type' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tài khoản'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.AccountType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CCCD/CMND'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.CCCD' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sinh'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.BirthDay' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh thành';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.Province' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quận huyện';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.District' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MST cá nhân';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.MstNumber' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kích hoạt tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.AccountDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên doanh nghiệp';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.CompanyName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người đại diện';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.Representative' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'MST doanh nghiệp';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.MstCompany' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số nhà';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.ApartmentCompany' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đường';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.RoadCompany' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phường/Xã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.WardCompany' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quận/Huyện';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.DistrictCompany' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/Thành Phố';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.ProvinceCompany' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số nhà';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.ApartmentShop' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đường';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.RoadShop' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phường/Xã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.WardShop' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quận/Huyện';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.DistrictShop' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/Thành Phố';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.ProvinceShop' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ email xuất HDĐT';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.EmailShop' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hình của hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.TypeStore' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diện tích shop (m2)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.AreaStore' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng doanh thu VND/Năm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.TotalRevenue' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh số điều hòa Bộ/Năm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.AirConditionerSales' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xếp loại khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.CustomerClassification' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năng lực tài chính';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.FinancialCapacity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thương hiệu bán mạnh nhất';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.StrongSelling1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thương hiệu bán mạnh 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.StrongSelling2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thương hiệu bán mạnh 3';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.StrongSelling3' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn nhập hàng điều hòa 1';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.ImportSource1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn nhập hàng điều hòa 2';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.ImportSource2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn nhập hàng điều hòa 3';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.ImportSource3' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bán GREE';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.SellGree' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trưng bày GREE';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.GreeDisplay' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năng lực bán GREE (SL Bộ/Năm)';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.SellingCapacity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xếp loại khách hàng GREE';
EXEC ERP9AddLanguage @ModuleID, 'SOF2201.ClassificationCustomer' , @FormID, @LanguageValue, @Language;