-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1370-CI
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1370';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Mã máy' ELSE N'Mã nguồn lực' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Tên máy' ELSE N'Tên nguồn lực' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Tên máy (ENG)' ELSE N'Tên nguồn lực (ENG)' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.MachineNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.Model', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hình thành';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Danh mục máy' ELSE N'Danh mục nguồn lực' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Loại máy' ELSE N'Loại nguồn lực' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.ResourceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu suất';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.Efficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian xếp hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu suất';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian chờ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.ResourcesTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.ResourcesTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.RoutingUnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.RoutingUnitName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công suất/ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1370.GoldLimit', @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
