-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ AF1303- M
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
SET @ModuleID = 'M';
SET @FormID = 'AF1303';

SET @LanguageValue = N'Chọn kho hàng';
EXEC ERP9AddLanguage @ModuleID, 'AF1303.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'AF1303.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kho hàng';
EXEC ERP9AddLanguage @ModuleID, 'AF1303.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên kho hàng';
EXEC ERP9AddLanguage @ModuleID, 'AF1303.WareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'AF1303.Address', @FormID, @LanguageValue, @Language;