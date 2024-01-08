-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF1831- M
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
SET @FormID = 'MF1831';

SET @LanguageValue = N'Cập nhật nguyên vật liệu thay thế';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhóm ';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.MaterialGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhóm ';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.GroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhóm ';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.MaterialGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguyên liệu thay thế';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguyên liệu thay thế';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số thay thế';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.CoValues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.InventoryTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.InventoryTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.InventoryUnit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.InventoryUnit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'MF1831.IsCommon', @FormID, @LanguageValue, @Language;