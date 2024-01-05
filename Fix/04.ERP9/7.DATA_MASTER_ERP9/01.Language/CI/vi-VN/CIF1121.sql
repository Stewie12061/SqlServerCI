------------------------------------------------------------------------------------------------------
-- Script t?o ngôn ng? CIF1121 
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
SET @FormID = 'CIF1121';
------------------------------------------------------------------------------------------------------
--- Title
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Cập nhật đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Title' , @FormID, @LanguageValue, @Language;

--- TAB
-----------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Đơn vị cha';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ParentDivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.DivisionID' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.DivisionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị (En)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.DivisionNameE' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ (En)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.AddressE' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Email' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Fax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ContactPerson' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.VATNO' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quận/ Huyện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.District' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/ Thành phố';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.City' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ContactPerson' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Logo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Logo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng bắt đầu kỳ kế toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.BeginMonth' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm bắt đầu kỳ kế toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.BeginYear' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu niên độ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.StartDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc niên độ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.EndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền hoạch toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.BaseCurrencyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số kỳ kế toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.PeriodNum' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.BankAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lẻ số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.QuantityDecimals' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lẻ đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.UnitCostDecimals' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lẻ quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ConvertedDecimals' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lẻ phần trăm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.PercentDecimal' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.Industry' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu năm tài chính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.FiscalBeginDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người ký tờ khai';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxreturnPerson' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cơ quan thuế cấp cục';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxDepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cơ quan thuế quản lý';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxDepartID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị chủ quản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ManagingUnit' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số thuế đơn vị chủ quản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ManagingUnitTaxNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.IsUseTaxAgent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số đại lý thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đại lý thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ trụ sở';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentFax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quận/Huyện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentDistrict' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/Thành phố';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentCity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentTel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentEmail' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số HĐ đại lý thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentContractNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentContractDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'NV viên đại lý thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentPerson' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxAgentCertificate' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Thông tin đại lý thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ThongTinDaiLyThue' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Thông tin nộp thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ThongTinNopThue' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ThongTinChung' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Thông tin đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ThongTinDonVi' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Mã tiền hạch toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.CurrencyID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên tiền hạch toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.CurrencyName.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Mã cơ quan';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxDepartmentID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên cơ quan';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxDepartmentName.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Mã cơ quan';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxDepartID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên cơ quan';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.TaxDepartName.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Mã quận/huyện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.DistrictID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên quận/huyện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.DistrictName.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Mã thành phố';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.CityID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên thành phố';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.CityName.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.DivisionID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.DivisionName.CB' , @FormID, @LanguageValue, @Language;


    SET @LanguageValue = N'Mã người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.EmployeeID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.EmployeeName.CB' , @FormID, @LanguageValue, @Language;


    SET @LanguageValue = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.BankAccountID.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.BankName.CB' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Thông tin phương thức thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ThongTinPhuongThucThanhToan' , @FormID, @LanguageValue, @Language;






------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;