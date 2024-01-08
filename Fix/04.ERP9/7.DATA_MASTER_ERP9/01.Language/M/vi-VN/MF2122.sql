-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2122- M
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
SET @FormID = 'MF2122';

SET @LanguageValue = N'Xem chi tiết định mức sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.NodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.NodeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cấu trúc';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.NodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.NodeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại định lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.QuantitativeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.MaterialGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.MaterialConstant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.NodeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại định lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.QuantitativeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hệ số';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.MaterialConstant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.NodeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.QuantitativeValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguyên liệu thay thế';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy trình sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.RoutingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gia công';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.OutsourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lập lệnh';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.DictatesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lệnh sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại cấu trúc';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.NodeTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.NodeTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã định lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.QuantitativeTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên định lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.QuantitativeTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhóm';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.MaterialGroupID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhóm';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.MaterialGroupName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.MaterialID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.MaterialName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy trình';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.RoutingID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy trình';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.RoutingName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã gia công';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.OutsourceID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên gia công';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.OutsourceName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lập lệnh';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.DictatesID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên lập lệnh';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.DictatesName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.PhaseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.PhaseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định mức sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.DinhMucSanPham', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết định mức sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.ChiTietDinhMucSanPham', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết định mức nhân công';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.DinhMucNhanCong', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết định mức tool';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.DinhMucTool', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhóm nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.MaterialGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.LossValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hiển thị ';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách Version BOM Nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.DanhSachVersionBOM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách Version BOM Tool';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.DanhSachVersionBOMTool', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Danh sách Version BOM Nhân công';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.DanhSachVersionBOMLabour', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày cập nhật';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.LastModifyDate', @FormID, @LanguageValue, @Language;

--- Đình Định 06/12/2022: Thêm ngôn ngữ tab chi tiết 
SET @LanguageValue = N'Lượng hao hụt';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.LossAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.QuantityProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.Total', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.SetUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tính định mức nhân công';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.IsLabourCalculated', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã Nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.MaterialInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên Nguyên vật liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.MaterialInventoryName', @FormID, @LanguageValue, @Language;

--- Đình Định 06/12/2022: Tạo tiêu đề cho các tab
-- Đức Tuyên 22/02/2023: Bổ sung ngôn ngữ Tab
SET @LanguageValue = N'Định mức sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'TabMT2121', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định mức nhân công';
EXEC ERP9AddLanguage @ModuleID, 'TabMT2124', @FormID, @LanguageValue, @Language;

--- Đức Tuyên 22/02/2023: Bổ sung ngôn ngữ Tab Định mức nhân công
SET @LanguageValue = N'Mã nhân công';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.LaborID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân công';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.LaborName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.LaborUnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Định mức thời gian';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.TimeLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đặc tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'MF2122.Specification', @FormID, @LanguageValue, @Language;