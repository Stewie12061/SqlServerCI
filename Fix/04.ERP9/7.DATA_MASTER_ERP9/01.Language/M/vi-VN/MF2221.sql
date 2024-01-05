-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2221- M
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
SET @FormID = 'MF2221';

SET @LanguageValue = N'Cập nhật đơn hàng sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'PL đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.IsInheritSO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa bộ định mức';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.IsInheritBOM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người theo dõi';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.OrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kiểm soát';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.LinkNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày yêu cầu hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.RefInfor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tập hợp chi phí giá thành';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.IsPeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quản lý sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.IsPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng THCP';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.PeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.PeriodID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.PeriodName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.DepartmentID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.DepartmentName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.InventoryTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.InventoryTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.ClassifyID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.ClassifyName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đặc tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'MF2221.Specification', @FormID, @LanguageValue, @Language;

-- Khách hàng INNOTEK
IF ((SELECT CustomerName FROM dbo.CustomerIndex) = 161)
BEGIN
    SET @LanguageValue = N'Số lượng cần sản xuất';
    EXEC ERP9AddLanguage @ModuleID, 'MF2221.OrderQuantity', @FormID, @LanguageValue, @Language;
    
    SET @LanguageValue = N'Số lượng đơn hàng';
    EXEC ERP9AddLanguage @ModuleID, 'MF2221.QuantityOfOrder', @FormID, @LanguageValue, @Language;
    
    SET @LanguageValue = N'Số lượng đơn hàng';
    EXEC ERP9AddLanguage @ModuleID, 'MF2221.AnaName', @FormID, @LanguageValue, @Language;
    
    SET @LanguageValue = N'Số lượng tồn kho thực tế';
    EXEC ERP9AddLanguage @ModuleID, 'MF2221.EndQuantity', @FormID, @LanguageValue, @Language;
    
    SET @LanguageValue = N'Số lượng tồn kho an toàn';
    EXEC ERP9AddLanguage @ModuleID, 'MF2221.SafeQuantity', @FormID, @LanguageValue, @Language;
    
    SET @LanguageValue = N'Số lượng giữ chỗ trước đó';
    EXEC ERP9AddLanguage @ModuleID, 'MF2221.IntendedPickingQuantity', @FormID, @LanguageValue, @Language;
END

