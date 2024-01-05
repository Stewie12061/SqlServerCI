-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ WMF2294- WM
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
SET @ModuleID = N'WM'
SET @FormID = 'WMF2294'

SET @LanguageValue = N'Kế thừa xuất kho mã vạch';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đối tượng';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đặt';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.Orders', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.ConvertedAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 1';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.Ana01ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 2';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.Ana02ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 3';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.Ana03ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 4';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.Ana04ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 5';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.Ana05ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 6';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.Ana06ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 7';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.Ana07ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 8';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.Ana08ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 9';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.Ana09ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã phân tích 10';
EXEC ERP9AddLanguage @ModuleID,  N'WMF2294.Ana10ID', @FormID, @LanguageValue, @Language;


