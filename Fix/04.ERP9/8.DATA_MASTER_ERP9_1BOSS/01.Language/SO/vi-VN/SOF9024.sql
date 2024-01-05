
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF9024- OO
-- Đình Hòa - 29/03/2021 - Bổ sung ngôn ngũ
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
SET @FormID = 'SOF9024';

SET @LanguageValue = N'Chọn khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF9024.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF9024.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF9024.AccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'SOF9024.AccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'SOF9024.Address' , @FormID, @LanguageValue, @Language;

-- Đình Hòa - [19/04/2021] - Bổ sung ngông ngữ 
SET @LanguageValue = N'Điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'SOF9024.Tel' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'SOF9024.Email' , @FormID, @LanguageValue, @Language;


