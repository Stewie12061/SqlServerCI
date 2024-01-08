-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2190- SO
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
SET @FormID = 'SOF2190';

SET @LanguageValue = N'Quản lý bảo hành sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'SOF2190.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2190.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2190.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'SOF2190.VoucherDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại';
EXEC ERP9AddLanguage @ModuleID, 'SOF2190.VoucherTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số xe'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2190.CarNumber' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2190.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2190.ObjectType' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2190.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ 2'; 
EXEC ERP9AddLanguage @ModuleID, 'SOF2190.Address2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF2190.Description' , @FormID, @LanguageValue, @Language;

