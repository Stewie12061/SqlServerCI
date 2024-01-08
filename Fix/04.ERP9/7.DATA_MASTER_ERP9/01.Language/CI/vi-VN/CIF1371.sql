-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1371- CI
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
SET @FormID = 'CIF1371';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Mã máy' ELSE N'Mã nguồn lực' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Tên máy' ELSE N'Tên nguồn lực' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Tên máy (ENG)' ELSE N'Tên nguồn lực (ENG)' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MachineNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Model', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hình thành';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Cập nhật máy' ELSE N'Cập nhật nguồn lực' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông số kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thông số kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thông số';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thông số';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Loại máy' ELSE N'Loại nguồn lực' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.ResourceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu suất';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.Efficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian xếp hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian chờ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian di chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.ResourcesTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.ResourcesTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.RoutingUnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.RoutingUnitName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công suất/ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.GoldLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.TimeLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số lao động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1371.WorkersLimit', @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;