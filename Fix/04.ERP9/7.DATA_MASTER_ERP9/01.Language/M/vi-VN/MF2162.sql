-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2162- M
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
SET @FormID = 'MF2162';

SET @LanguageValue = N'Xem chi tiết lệnh sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thông tin sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.MOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.DateDelivery', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phẩm/bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.ProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng sản xuất/bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.ProductQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa kế hoạch sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.InheritMT2140', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thông tin sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.MOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại lệnh';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.CommandType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.MaterialQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế hoạch sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.MPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.ProductID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã máy';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.MachineID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số lao động';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.WorkersLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin lệnh sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.Master.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết lệnh sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.DetailDT.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu kế thừa sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.MOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số Lô';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.SourceNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thông tin sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.MOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số PO';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.PONumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đặc tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'MF2162.Specification', @FormID, @LanguageValue, @Language;