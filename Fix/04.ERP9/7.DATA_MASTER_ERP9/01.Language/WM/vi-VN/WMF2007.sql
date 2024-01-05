-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2007- WM
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
SET @ModuleID = 'WM';
SET @FormID = 'WMF2007';

SET @LanguageValue = N'Cập nhật yêu cầu xuất kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.WMF2007Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.VoucherTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ContractNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.WarehouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.Status', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ApprovePerson' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ApprovePersonStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InputDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hoạch toán';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ImWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ImWareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho xuất';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ExWareHouseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ExWareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tham chiếu 1';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.RefNo01', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tham chiếu 2';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.RefNo02', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ContractID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người liên lạc';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ContactPerson', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Địa chỉ giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.RDAddress', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.CheckPurchase', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.LastModifyUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.WareHouseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên kho';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.WareHouseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InventoryTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InventoryTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.EmployeeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.EmployeeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.VoucherTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.VoucherTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InventoryID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InventoryName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.AccountID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.AccountName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ReVoucherNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lô nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ReSourceNo.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.UnitPrice.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ReQuantity.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng xuất';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.DeQuantity.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng tồn cuối (ĐVT chuẩn)';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.EndQuantity.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ReVoucherDate.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hết hạn';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.LimitDate.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa đơn hàng bán';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InheritSaleOrders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người lập phiếu';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hàng khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.IsProInventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn nhiều mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ChooseInventoryList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TK nợ';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.DebitAccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TK có';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.CreditAccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái duyệt';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.StatusMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú người duyệt';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ApprovalNotes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn nhiều mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ChooseInventoryList', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng xuất';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chứng từ nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ReVoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.OriginalAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lô nhập';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.SourceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hạn sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.LimitDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tồn cuối';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ActEndQty', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa lệnh sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InheritProductOrder' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số PO';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.PONumber' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa phiếu bảo hành/sửa chữa';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.InheritWarrantyRepair' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đặc tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.Specification', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy cách';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy cách';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tài xế';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.DriverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã xe';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.CarID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.UnitID.CB', @FormID, @LanguageValue, @Language;


SET @LanguageValue = N'Đơn giá chuyển đổi';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.UnitName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ConvertedUnitID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.ConvertedUnitName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Toán tử';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.DataTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cách tính';
EXEC ERP9AddLanguage @ModuleID, 'WMF2007.FormulaDes.CB', @FormID, @LanguageValue, @Language;
