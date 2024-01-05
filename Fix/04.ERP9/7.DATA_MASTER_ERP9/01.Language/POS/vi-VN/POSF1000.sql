------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF1000 - POS
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
SET @ModuleID = 'POS';
SET @FormID = 'POSF1000';
------------------------------------------------------------------------------------------------------
-- Title
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Danh mục event';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.Title' , @FormID, @LanguageValue, @Language;



SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã event';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên event';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.ShopName' , @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.ObjectID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.Address' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Fax';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.Fax' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.Email' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đóng event';
EXEC ERP9AddLanguage @ModuleID, 'POSF1000.Disabled' , @FormID, @LanguageValue, @Language;