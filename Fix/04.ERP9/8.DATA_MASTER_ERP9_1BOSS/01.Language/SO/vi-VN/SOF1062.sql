------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF1062 - SO
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF1062';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Xem chi tiết chỉ tiêu doanh số nhân viên bán sỉ (Sale In)';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chỉ tiêu';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.TargetsID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.FromDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.ToDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chỉ tiêu doanh số nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.ThongTinChiTieuDoanhSoNV' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết chỉ tiêu doanh số nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.ThongTinChiTietChiTieuDSNV' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.EmployeeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.EmployeeLevelName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.ObjectName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.DepartmentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổ nhóm';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.TeamName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên SA - PG';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.SOAna01Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên SUP';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.SOAna02Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên ASM';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.SOAna03Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên ADMIN';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.SOAna04Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên QLADMIN';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.SOAna05Name' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm hàng (MPT 8)';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.InventoryTypeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm hàng (MPT 4)';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.InventoryTypeName2' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh số tháng';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.SalesMonth' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh số quý';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.SalesQuarter' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Doanh số năm';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.SalesYear' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.LastModifyUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'SOF1062.StatusID' , @FormID, @LanguageValue, @Language;