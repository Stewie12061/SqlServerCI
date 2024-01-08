	-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2143- M
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
SET @FormID = 'MF2143';

SET @LanguageValue = N'Chọn phiếu kế hoạch sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2143.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2143.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã dự trù';
EXEC ERP9AddLanguage @ModuleID, 'MF2143.VoucherNoProduct', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'MF2143.DateDelivery', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2143.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2143.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phẩm/bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2143.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'MF2143.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Máy';
EXEC ERP9AddLanguage @ModuleID, 'MF2143.MachineName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian';
EXEC ERP9AddLanguage @ModuleID, 'MF2143.TimeNumber', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kế thừa thông tin sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2143.InheritSOT2080', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'MF2143.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF2143.StartDateManufacturing', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tình trạng';
EXEC ERP9AddLanguage @ModuleID, 'MF2143.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'MF2143.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Công đoạn';
EXEC ERP9AddLanguage @ModuleID, 'MF2143.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tổng số lao động';
EXEC ERP9AddLanguage @ModuleID, 'MF2143.WorkersLimit', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã thành phẩm/bán thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF2143.MaterialID', @FormID, @LanguageValue, @Language;