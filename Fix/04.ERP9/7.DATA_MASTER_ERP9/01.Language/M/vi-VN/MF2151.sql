-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2151- M
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
SET @FormID = 'MF2151';

SET @LanguageValue = N'Cập nhật dự trù chi phí sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã TTSX';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.MOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày vật tư';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.SuppliesDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ProductQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ định mức';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ApporitionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kiểm soát';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ControlID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.BusinessInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa thông tin sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.InheritSOT2080', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa đơn hàng sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.InheritOT2001', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ProductID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.OrderStatus.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.OrderStatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho giữ chỗ';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự trù';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.TabOT2202', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ProductQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.PDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thay thế';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.IsChange', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.MaterialQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.MDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tồn kho an toàn';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.SafeQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tồn kho thực tế';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.EndQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự trù định mức';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.MaterialQuantityDC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự trù giữ chỗ';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.IntendedPickingQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng mua đã duyệt';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.PickingQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gợi ý mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.SuggestQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tính dự trù';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.TabOT2203', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối chiếu';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.TabOT2205', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.MaterialIDChange.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.MaterialNameChange.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.GroupName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho giữ chỗ';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.WareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng phiếu';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa Dự toán';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.InheritCRMT2110', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.SemiProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đặc tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.Specification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số PO';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.nvarchar01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cấp duyệt';
EXEC ERP9AddLanguage @ModuleID, 'MF2151.ApprovingLevel.M', @FormID, @LanguageValue, @Language;

