-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2222- M
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
SET @FormID = 'MF2222';

SET @LanguageValue = N'Chi tiết đơn hàng sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'PL đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người theo dõi';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phòng ban';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.OrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kiểm soát';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.LinkNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày yêu cầu hoàn thành';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin kinh doanh';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.RefInfor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tập hợp chi phí giá thành';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.IsPeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quản lý sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.IsPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng THCP';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.PeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết đơn hàng sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.ThongTinChiTietDonHangSanXuat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mặt hàng sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.VatLieuSanXuat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đặc tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.Specification', @FormID, @LanguageValue, @Language;

-- Khách hàng INNOTEK
IF ((SELECT CustomerName FROM dbo.CustomerIndex) = 161)
BEGIN
    SET @LanguageValue = N'Số lượng cần sản xuất';
    EXEC ERP9AddLanguage @ModuleID, 'MF2222.OrderQuantity', @FormID, @LanguageValue, @Language;
    
    SET @LanguageValue = N'Số lượng đơn hàng';
    EXEC ERP9AddLanguage @ModuleID, 'MF2222.QuantityOfOrder', @FormID, @LanguageValue, @Language;
    
    SET @LanguageValue = N'Số lượng đơn hàng';
    EXEC ERP9AddLanguage @ModuleID, 'MF2222.AnaName', @FormID, @LanguageValue, @Language;
    
    SET @LanguageValue = N'Số lượng tồn kho thực tế';
    EXEC ERP9AddLanguage @ModuleID, 'MF2222.EndQuantity', @FormID, @LanguageValue, @Language;
    
    SET @LanguageValue = N'Số lượng tồn kho an toàn';
    EXEC ERP9AddLanguage @ModuleID, 'MF2222.SafeQuantity', @FormID, @LanguageValue, @Language;
    
    SET @LanguageValue = N'Số lượng giữ chỗ trước đó';
    EXEC ERP9AddLanguage @ModuleID, 'MF2222.IntendedPickingQuantity', @FormID, @LanguageValue, @Language;
END

