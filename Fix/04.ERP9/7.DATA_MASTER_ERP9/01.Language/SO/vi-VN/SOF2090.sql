-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2090- SO
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
SET @FormID = 'SOF2090';

SET @LanguageValue = N'Danh mục đơn hàng điều chỉnh';
EXEC ERP9AddLanguage @ModuleID, 'SOF2090.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2090.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2090.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đơn hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2090.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2090.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2090.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2090.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ giao hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2090.DeliveryAddress' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại tiền'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2090.CurrencyID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỷ giá'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2090.ExchangeRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên tệ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2090.OriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy đổi'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2090.ConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2090.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2090.VoucherTypeID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'SOF2090.VoucherTypeName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng đơn hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2090.OrderStatus' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2090.StatusName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2090.Status' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng bán';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2090.OrderNo' , @FormID, @LanguageValue, @Language;