-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF1820- M
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
SET @FormID = 'MF1820';

SET @LanguageValue = N'Danh mục nguồn lực sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.ResourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.ResourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.ResourceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.ResourcesTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.ResourcesTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.ResourceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.RoutingUnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF1820.RoutingUnitName.CB', @FormID, @LanguageValue, @Language;