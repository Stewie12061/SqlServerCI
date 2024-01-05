-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2021- PO
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
SET @ModuleID = 'PO';
SET @FormID = 'POF2021';

SET @LanguageValue = N'Kế hoạch mua hàng dự trữ';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.VoucherID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số LeadTime_MOQ';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.LeadTimeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.TranMonth', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.TranYear', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm hàng hóa';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.IsAVG', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.FromPeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.ToPeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày lập kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.VoucherFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.VoucherToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.OrderFromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đến';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.OrderToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên lập';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.OrderDateStr', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.Priority1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.Priority2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.Priority3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhân viên lập';
EXEC ERP9AddLanguage @ModuleID, 'POF2021.EmployeeName', @FormID, @LanguageValue, @Language;

