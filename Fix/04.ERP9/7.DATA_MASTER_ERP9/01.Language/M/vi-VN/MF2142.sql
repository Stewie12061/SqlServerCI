-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2142- M
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
SET @FormID = 'MF2142';

SET @LanguageValue = N'Xem chi tiết kế hoạch sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã TTSX';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.VoucherNoProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.DateDelivery', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT thời gian sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT thông số máy';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số thời gian sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.Number', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hoàn thành sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SP/ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.GoalLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.TimeNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.RoutingUnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.RoutingUnitName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã máy';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên máy';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.MachineName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa thông tin sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.InheritSOT2080', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian định mức';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.TimeLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.StartDateManufacturing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã TTSX';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.VoucherNoProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.DateDelivery', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hoàn thành sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.Notes.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin kế hoạch sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.Master.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiếu thông tin sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.DetailTTSX.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin máy sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.DetailMay.GR', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kế hoạch hoàn thành SX';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.EndDatePlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng lao động';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.WorkersLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoảng cách (Ngày)';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.SpaceTimes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.TotalQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đặc tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'MF2142.Specification', @FormID, @LanguageValue, @Language;