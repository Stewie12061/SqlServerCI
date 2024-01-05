-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2141- M
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
SET @FormID = 'MF2141';

SET @LanguageValue = N'Cập nhật kế hoạch sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã TTSX';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.VoucherNoProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.DateDelivery', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu SX';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT thời gian SX';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT thông số máy';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số thời gian SX';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.Number', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày hoàn thành SX';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SP/ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.GoalLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian SX/Ngày';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.TimeNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.RoutingUnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.RoutingUnitName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã máy';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên máy';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.MachineName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa thông tin sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.InheritSOT2080', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian định mức';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.TimeLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu SX';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.StartDateManufacturing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.TabMT2141', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin máy sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.TabMT2142', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.StatusName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kế hoạch hoàn thành SX';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.EndDatePlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng lao động';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.WorkersLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khoảng cách (Ngày)';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.SpaceTimes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa đơn hàng sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.InheritOrderProduce', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa dự trù';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.InheritPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chuyền sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.LineProduce', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.AnaID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.AnaName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số PO';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.PONumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.TotalQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.DeleteQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đặc tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'MF2141.Specification', @FormID, @LanguageValue, @Language;
