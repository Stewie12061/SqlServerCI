-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF1821- M
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
SET @FormID = 'MF1821';

SET @LanguageValue = N'Cập nhật nguồn lực sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.ResourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.ResourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu suất';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.Efficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian xếp hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian đợi';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian chuyển';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian tối đa';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.ResourcesTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.ResourcesTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.ResourceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.RoutingUnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF1821.RoutingUnitName.CB', @FormID, @LanguageValue, @Language;