-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF1830- M
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
SET @FormID = 'MF1830';

SET @LanguageValue = N'Danh mục nguyên vật liệu thay thế';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhóm';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.MaterialGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhóm';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.GroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguyên vật liêu';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'MF1830.IsCommon', @FormID, @LanguageValue, @Language;