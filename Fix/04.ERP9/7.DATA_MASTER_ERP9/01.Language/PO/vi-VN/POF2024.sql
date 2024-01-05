-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2024- PO
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
SET @FormID = 'POF2024';

SET @LanguageValue = N'Kế thừa đơn đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số chứng từ';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ĐVT';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.OrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày yêu cầu giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.RequireDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn đặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.OrderTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.ID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'POF2024.Name.CB', @FormID, @LanguageValue, @Language;


