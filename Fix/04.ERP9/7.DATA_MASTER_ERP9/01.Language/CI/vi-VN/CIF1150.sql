------------------------------------------------------------------------------------------------------
-- Script t?o ngôn ng? CIF1150 
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
SET @FormID = 'CIF1150';
------------------------------------------------------------------------------------------------------
--- Title
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Danh mục đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.Title' , @FormID, @LanguageValue, @Language;

--- TAB
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.DivisionID' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Loại đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.ObjectTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.Email' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Vãng lai';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.IsUpdateName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.IsSupplier' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.IsCustomer' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.Fax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã số thuế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.VATNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.Contactor' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.S1' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.S2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.S3' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích đối tượng 1';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.O01ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích đối tượng 2';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.O02ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích đối tượng 3';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.O03ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích đối tượng 4';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.O04ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích đối tượng 5';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.O05ID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tỉnh/thành phố';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.CityID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên tỉnh/thành phố';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.CityName.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.CountryID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên quốc gia';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.CountryName.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Mã loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.CurrencyID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên loại tiền';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.CurrencyName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.AccountID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.AccountName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.AnaID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.AnaName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã ĐKTT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.PaymentTermID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên DKTT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.PaymentTermName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại đối tương';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.ObjectTypeID.CB' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên loại đối tương';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.ObjectTypeName.CB' , @FormID, @LanguageValue, @Language;

--[Đình Hoà] [21/07/2020] Thêm ngôn ngữ cho control
SET @LanguageValue = N'Sử dụng HĐĐT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.IsUsedEInvoice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhà phân phối';
EXEC ERP9AddLanguage @ModuleID, 'CIF1150.IsDealer' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;