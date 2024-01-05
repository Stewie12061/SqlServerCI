-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2110- M
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
SET @FormID = 'MF2110';

SET @LanguageValue = N'Danh mục cấu trúc sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã cấu trúc';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.NodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên cấu trúc';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.NodeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cấu trúc';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đặc tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'MF2110.Specification', @FormID, @LanguageValue, @Language;