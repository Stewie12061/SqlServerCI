-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2152- M
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
SET @FormID = 'MF2152';

SET @LanguageValue = N'Xem chi tiết dự trù chi phí sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã TTSX';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.MOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày vật tư';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.SuppliesDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.ProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.ProductQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Bộ định mức';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.ApporitionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kiểm soát';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.ControlID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.BusinessInfo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa thông tin sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.InheritSOT2080', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa đơn hàng sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.InheritOT2001', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.ProductID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.OrderStatus.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.OrderStatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho giữ chỗ';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.WareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự trù';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.TabOT2202', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.ProductQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.PDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thay thế';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.IsChange', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.MaterialQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.MDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tồn kho an toàn';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.SafeQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tồn kho thực tế';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.EndQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự trù định mức';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.MaterialQuantityDC', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự trù giữ chỗ';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.IntendedPickingQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng mua đã duyệt';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.PickingQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gợi ý mua hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.SuggestQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin dự trù';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.Master.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết dự trù';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.DetailDT.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin tính dự trù';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.DetailTDT.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin đối chiếu';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.DetaiDC.gR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã người yêu cầu';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kỳ tháng';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kỳ năm';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho giữ chỗ';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.WareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.SemiProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đặc tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.Specification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số PO';
EXEC ERP9AddLanguage @ModuleID, 'MF2152.nvarchar01', @FormID, @LanguageValue, @Language;
