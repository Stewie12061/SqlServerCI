-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CMNF1303- A00
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
SET @ModuleID = '00';
SET @FormID = 'CMNF1303';

SET @LanguageValue = N'Chọn kho';
EXEC ERP9AddLanguage @ModuleID, 'CMNF1303.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CMNF1303.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'CMNF1303.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên kho';
EXEC ERP9AddLanguage @ModuleID, 'CMNF1303.WareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CMNF1303.Address', @FormID, @LanguageValue, @Language;

