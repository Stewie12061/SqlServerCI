-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2011- CSM
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
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF2011';

SET @LanguageValue = N'Cập nhật phiếu sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ kiện đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.CSMT2011_AccessoriesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phụ kiện đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.AccessoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.AttachID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày phiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số phiếu tham chiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.DispatchID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.ProductID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.ProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Serial';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.SerialNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số IMEI';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.IMEINumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái phiếu';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.GSXStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái xác nhận GSX';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.DispatchStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hãng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.FirmID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại dịch vụ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.ServiceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.ProductTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.Model', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Model';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.ModelName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.PurchaseDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hết hạn BH';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.EndOfWarranty', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.CustomerTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.CustomerGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.AgencyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đại lý';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.AgencyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.StoreID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cửa hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.StoreName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.CustomerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh xưng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.Appellation', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/TP';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.CityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.PhoneNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả lỗi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.SymptomDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng BH';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.WarrantyStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại BH';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.WarrantyTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm mã lỗi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.SymptomGroup', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lỗi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.SymptomCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lỗi chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.IssueCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng lỗi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.ModifierCode', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.GSXStatus.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.GSXStatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.CustomerTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.CustomerTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.AppellationID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.AppellationName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.CityID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.CityName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.ServiceTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.ServiceTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.FirmID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.FirmName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.ProductTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.ProductTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.ModelID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.ModelName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.WarrantyStatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.WarrantyStatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.WarrantyTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.WarrantyTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.SymptomGroupID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.SymptomGroupName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.SymptomCode.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.SymptomName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.IssueCode.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.IssueName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.ModifierCode.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.ModifierName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.CustomerInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.ProductInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin lỗi';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2011.ErrorInfo', @FormID, @LanguageValue, @Language;