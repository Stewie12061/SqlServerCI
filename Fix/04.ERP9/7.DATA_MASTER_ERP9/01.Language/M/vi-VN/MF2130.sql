-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2130- M
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
SET @FormID = 'MF2130';

SET @LanguageValue = N'Danh mục quy trình sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy trình';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.RoutingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy trình';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.RoutingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại quy trình';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.RoutingTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian quy trình';
EXEC ERP9AddLanguage @ModuleID, 'MF2130.RoutingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.RoutingUnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.RoutingUnitName.CB', @FormID, @LanguageValue, @Language;