-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2132- M
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
SET @FormID = 'MF2132';

SET @LanguageValue = N'Xem chi tiết quy trình sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy trình';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.RoutingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy trình';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.RoutingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại quy trình';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.RoutingTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người chỉnh sửa';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng thời gian';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.RoutingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trình tự';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.PhaseOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.PhaseTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn trước';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.PreviousOrders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn sau';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.NextOrders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.ResourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian xếp hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian chờ';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian di chuyển';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian tối đa';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.PhaseTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy trình sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.QuyTrinhSanXuat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi tiết quy trình sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.ChiTietQuyTrinhSanXuat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian xếp hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian chờ';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian di chuyển';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian tối đa';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF2132.ResourceUnitID', @FormID, @LanguageValue, @Language;
