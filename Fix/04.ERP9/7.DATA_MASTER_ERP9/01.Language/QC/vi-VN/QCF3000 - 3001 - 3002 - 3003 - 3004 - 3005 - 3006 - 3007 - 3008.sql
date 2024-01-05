-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF2050 
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
SET @ModuleID = 'QC';

SET @FormID = 'QCF3000';
SET @LanguageValue = N'Danh sách báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'QCF3000.Title', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Danh sách báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'ASOFTQC.Bao_cao', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Báo cáo biểu đồ';
EXEC ERP9AddLanguage @ModuleID, 'ASOFTQC.Bieu_do', @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'In tem';
EXEC ERP9AddLanguage @ModuleID, 'ASOFTQC.In_tem', @FormID, @LanguageValue, @Language;

SET @FormID = 'QCF3001';
EXEC ERP9AddLanguage @ModuleID, 'QCF3001.Title', @FormID, N'Biên bản chất lượng', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3001.DivisionID', @FormID, N'Đơn vị', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3001.ToDate', @FormID, N'Đến ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3001.FromDate', @FormID, N'Từ ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3001.ShiftID', @FormID, N'Ca', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3001.DepartmentID', @FormID, N'Phân xưởng', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3001.MachineID', @FormID, N'Máy', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3001.InventoryID', @FormID, N'Mặt hàng', @Language;

SET @FormID = 'QCF3002';
EXEC ERP9AddLanguage @ModuleID, 'QCF3002.Title', @FormID, N'Theo dõi nguyên vật liệu', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3002.DivisionID', @FormID, N'Đơn vị', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3002.ToDate', @FormID, N'Đến ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3002.FromDate', @FormID, N'Từ ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3002.ShiftID', @FormID, N'Ca', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3002.DepartmentID', @FormID, N'Phân xưởng', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3002.MachineID', @FormID, N'Máy', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3002.InventoryID', @FormID, N'Mặt hàng', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3002.MaterialID', @FormID, N'NVL', @Language;

SET @FormID = 'QCF3003';
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.Title', @FormID, N'Báo cáo vận hành máy', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.DivisionID', @FormID, N'Đơn vị', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.Date', @FormID, N'Từ ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.ToDate', @FormID, N'Đến ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.ShiftID', @FormID, N'Ca', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.DepartmentID', @FormID, N'Phân xưởng', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.MachineID', @FormID, N'Máy', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.InventoryID', @FormID, N'Mặt hàng', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.ReportView.InventoryID.CB', @FormID, N'Mã', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3003.ReportView.InventoryName.CB', @FormID, N'Tên', @Language;

SET @FormID = 'QCF3004';
EXEC ERP9AddLanguage @ModuleID, 'QCF3004.Title', @FormID, N'Biên bản kiểm tra thông tin kỹ thuật máy', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3004.DivisionID', @FormID, N'Đơn vị', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3004.Date', @FormID, N'Từ ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3004.ToDate', @FormID, N'Đến ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3004.ShiftID', @FormID, N'Ca', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3004.DepartmentID', @FormID, N'Phân xưởng', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3004.MachineID', @FormID, N'Máy', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3004.InventoryID', @FormID, N'Mặt hàng', @Language;

SET @FormID = 'QCF3005';
EXEC ERP9AddLanguage @ModuleID, 'QCF3005.Title', @FormID, N'Báo cáo sản xuất', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3005.DivisionID', @FormID, N'Đơn vị', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3005.ToDate', @FormID, N'Đến ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3005.FromDate', @FormID, N'Từ ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3005.ShiftID', @FormID, N'Ca', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3005.DepartmentID', @FormID, N'Phân xưởng', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3005.MachineID', @FormID, N'Máy', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3005.InventoryID', @FormID, N'Mặt hàng', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3005.GetPathTemplate', @FormID, N'Mẫu in', @Language;
EXEC ERP9AddLanguage @ModuleID, 'GetPathTemplate', @FormID, N'Mẫu in', @Language;

SET @FormID = 'QCF3006';
EXEC ERP9AddLanguage @ModuleID, 'QCF3006.Title', @FormID, N'Biên bản xử lý lỗi', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3006.DivisionID', @FormID, N'Đơn vị', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3006.ToDate', @FormID, N'Đến ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3006.FromDate', @FormID, N'Từ ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3006.MachineID', @FormID, N'Máy', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3006.InventoryID', @FormID, N'Mặt hàng', @Language;


SET @FormID = 'QCF3007';
EXEC ERP9AddLanguage @ModuleID, 'QCF3007.Title', @FormID, N'Biểu đồ Tiêu chuẩn', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3007.DivisionID', @FormID, N'Đơn vị', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3007.ToDate', @FormID, N'Đến ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3007.FromDate', @FormID, N'Từ ngày', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3007.StandardID', @FormID, N'Tiêu chuẩn', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3007.InventoryID', @FormID, N'Mặt hàng', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3007.InventoryName', @FormID, N'Mặt hàng', @Language;

SET @FormID = 'QCF3008';
EXEC ERP9AddLanguage @ModuleID, 'QCF3008.Title', @FormID, N'In tem', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3008.DivisionID', @FormID, N'Đơn vị', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3008.BatchNo', @FormID, N'Số batch', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3008.InventoryID', @FormID, N'Mặt hàng', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3008.APK', @FormID, N'Số batch - Mặt hàng', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3008.GetPathTemplate', @FormID, N'Mẫu in', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3008.Customer', @FormID, N'Khách hàng', @Language;
EXEC ERP9AddLanguage @ModuleID, 'QCF3008.SCNumber', @FormID, N'SCNumber', @Language;
EXEC ERP9AddLanguage @ModuleID, 'GetPathTemplate', @FormID, N'Mẫu in', @Language;

