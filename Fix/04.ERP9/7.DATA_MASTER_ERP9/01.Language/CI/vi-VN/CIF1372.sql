-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1372-CI
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
SET @FormID = 'CIF1372';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Mã máy' ELSE N'Mã nguồn lực' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Tên máy' ELSE N'Tên nguồn lực' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Tên máy(Eng)' ELSE N'Tên nguồn lực (Eng)' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MachineNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân xưởng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mẫu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Model', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Năm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hình thành';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thông số';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thông số';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Xem chi tiết máy' ELSE N'Xem chi tiết nguồn lực' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Thông tin máy' ELSE N'Thông tin nguồn lực' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Info', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông số kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Detail', @FormID, @LanguageValue, @Language;
--
SET @LanguageValue = CASE WHEN EXISTS (SELECT TOP 1 1 FROM CustomerIndex WHERE CustomerName = 128) THEN N'Loại máy' ELSE N'Loại nguồn lực' END;
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.ResourceTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hiệu suất';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Efficiency', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian xếp hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian chờ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian di chuyển';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công suất/ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.GoldLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian định mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.TimeLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số lao động';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.WorkersLimit', @FormID, @LanguageValue, @Language;

--Đình Hòa - [16/04/2021] - Thêm ngôn ngữ
SET @LanguageValue  = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1372.StatusID',  @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;