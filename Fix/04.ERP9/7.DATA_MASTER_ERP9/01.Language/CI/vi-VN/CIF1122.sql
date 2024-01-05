------------------------------------------------------------------------------------------------------
-- Script t?o ngôn ng? CIF1122 
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
SET @FormID = 'CIF1122';
------------------------------------------------------------------------------------------------------
--- Title
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Xem chi tiết đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Title' , @FormID, @LanguageValue, @Language;

--- TAB
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Đơn vị cha';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ParentDivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.DivisionID' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.DivisionName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị (En)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.DivisionNameE' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ (En)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.AddressE' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Email' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Fax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ContactPerson' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số VAT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.VATNO' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quận/ Huyện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.District' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/ Thành phố';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.City' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ContactPerson' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Logo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Logo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tháng bắt đầu kỳ kế toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.BeginMonth' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm bắt đầu kỳ kế toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.BeginYear' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu niên độ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.StartDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc niên độ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.EndDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tiền hoạch toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.BaseCurrencyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số kỳ kế toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.PeriodNum' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản ngân hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.BankAccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lẻ số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.QuantityDecimals' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lẻ đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.UnitCostDecimals' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lẻ quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ConvertedDecimals' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lẻ phần trăm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.PercentDecimal' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngành nghề kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Industry' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu năm tài chính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.FiscalBeginDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người ký tờ khai';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxreturnPerson' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cơ quan thuế cấp cục';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxDepartmentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cơ quan thuế quản lý';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxDepartID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị chủ quản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ManagingUnit' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số thuế đơn vị chủ quản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ManagingUnitTaxNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.IsUseTaxAgent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số đại lý thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đại lý thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ trụ sở';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentFax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quận/Huyện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentDistrict' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/Thành phố';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentCity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentTel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentEmail' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số HĐ đại lý thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentContractNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentContractDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'NV viên đại lý thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentPerson' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.TaxAgentCertificate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.CreateUserID' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.CreateDate' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.LastModifyDate' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.LastModifyUserID' , @FormID, @LanguageValue, @Language;


    SET @LanguageValue = N'Thông tin đại lý thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ThongTinDaiLyThue' , @FormID, @LanguageValue, @Language;


    SET @LanguageValue = N'Thông tin nộp thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ThongTinNopThue' , @FormID, @LanguageValue, @Language;


    SET @LanguageValue = N'Thông tin chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ThongTinChung' , @FormID, @LanguageValue, @Language;


    SET @LanguageValue = N'Thông tin đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.ThongTinDonVi' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.Description' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1122.StatusID' , @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;