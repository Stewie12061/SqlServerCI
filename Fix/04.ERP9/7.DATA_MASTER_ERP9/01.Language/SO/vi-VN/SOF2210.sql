-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2210- SO
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
SET @FormID = 'SOF2210';

SET @LanguageValue = N'Kích hoạt bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'SOF2210.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2210.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số seri';
EXEC ERP9AddLanguage @ModuleID, 'SOF2210.SeriNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản T-Card';
EXEC ERP9AddLanguage @ModuleID, 'SOF2210.TAccount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kích hoạt bảo hành';
EXEC ERP9AddLanguage @ModuleID, 'SOF2210.TAccountNumber' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kích hoạt bảo hành'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2210.TAccountDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Họ và tên khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2210.Enduser' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Điện thoại'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2210.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số nhà'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2210.Apartment' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đường'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2210.Road' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phường/Xã';
EXEC ERP9AddLanguage @ModuleID, 'SOF2210.Ward' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quận huyện';
EXEC ERP9AddLanguage @ModuleID, 'SOF2210.District' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tỉnh/Thành phố';
EXEC ERP9AddLanguage @ModuleID, 'SOF2210.Province' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài khoản D-Card';
EXEC ERP9AddLanguage @ModuleID, 'SOF2210.DAccount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kích hoạt D-card';
EXEC ERP9AddLanguage @ModuleID, 'SOF2210.DAccountNumber' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kích hoạt';
EXEC ERP9AddLanguage @ModuleID, 'SOF2210.DAccountDate' , @FormID, @LanguageValue, @Language;
