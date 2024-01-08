-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2131- M
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
SET @FormID = 'MF2131';

SET @LanguageValue = N'Cập nhật quy trình sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã quy trình';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.RoutingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên quy trình';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.RoutingName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại quy trình';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.RoutingTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT quy trình';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian quy trình';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.RoutingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.PhaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trình tự';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.PhaseOrder', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.PhaseTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn trước';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.PreviousOrders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn sau';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.NextOrders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.ResourceID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.ResourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.RoutingUnitID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.RoutingUnitName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.SettingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian xếp hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.LinedUpTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian chờ';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.WaittingTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian di chuyển';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.TransferTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian tối thiểu';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.MinTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian tối đa';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.MaxTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT nguồn lực';
EXEC ERP9AddLanguage @ModuleID, 'MF2131.ResourceUnitName', @FormID, @LanguageValue, @Language;
