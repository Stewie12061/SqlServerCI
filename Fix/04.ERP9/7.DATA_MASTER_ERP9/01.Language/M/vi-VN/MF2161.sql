-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2161- M
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
SET @FormID = 'MF2161';

SET @LanguageValue = N'Cập nhật lệnh sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thông dự trù sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.MOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.DateDelivery', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thành phẩm/bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.ProductID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên thành phẩm/bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.ProductName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng thành phẩm/bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.ProductQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa kế hoạch sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.InheritMT2140', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.OrderStatus.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.OrderStatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại lệnh';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.CommandType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.MaterialQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguyên liệu';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã lệnh';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.CommandType.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên lệnh';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.Description.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã kế hoạch sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.MPlanID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số PO';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.PONumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đặc tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'MF2161.Specification', @FormID, @LanguageValue, @Language;