-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2211- M
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
SET @FormID = 'MF2211';

SET @LanguageValue = N'Cập nhật thống kê kết quả sản xuât';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.VoucherDate ', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người theo dõi';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã link công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa lệnh sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.InheritProductOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lệnh sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.ProductionOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn lực máy';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.SourceMachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nguồn lực nhân công';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.SourceEmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã line sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Line sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.Ana06Name', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.DetailID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.DetailName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dài';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.Length', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Rộng';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.Width', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cao';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.Height', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhập kho';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.IsWarehouse', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.MachineID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.MachineName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machine Time';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.MachineTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Labor Time';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.LaborTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phân loại công việc';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.TaskTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công việc phát sinh';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.TaskArise', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cycle time (theo KHSX)';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.CycleTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ca SX';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.ProductionShift', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.UserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người thao tác';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.ItemPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thực tế (OK)';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.ItemActual', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'NG';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.ItemReturnedQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cân đối';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.ItemBalance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng thời gian KH (hrs)';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.TotalPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TGLV thực tế (hrs)';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.TotalActualTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giờ bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.StartTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giờ kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.EndTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dừng chuẩn bị SX (phút)';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.PreparePlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dừng nghỉ lần 1';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.RestPlanTime1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dừng ăn chính';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.MainMealPlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dừng nghỉ lần 2';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.RestPlanTime2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dừng ca phụ';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.SideMealPlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dừng vệ sinh cuối ca';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.CleanPlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng dừng kế hoạch (phút)';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.TotalPlanTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sự cố khuôn';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.MoldProblemTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sự cố thiết bị';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.DeviceProblemTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Sự cố vật tư';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.materialProblemTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thay cuộn tôn (>1 lần)';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.ReplaceProplumnTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chờ đánh giá';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.FeedbackProblemTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng dừng sự cố (phút)';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.TotalProblemTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số PO';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.PONumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đặc tính kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'MF2211.Specification', @FormID, @LanguageValue, @Language;