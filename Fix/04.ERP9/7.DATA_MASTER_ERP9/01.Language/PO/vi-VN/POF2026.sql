-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2026- PO
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
SET @FormID = 'POF2026';

SET @LanguageValue = N'Chọn nhà cung cấp';
EXEC ERP9AddLanguage @ModuleID, 'POF2026.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã NCC';
EXEC ERP9AddLanguage @ModuleID, 'POF2026.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên NCC';
EXEC ERP9AddLanguage @ModuleID, 'POF2026.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'POF2026.UnitPrice', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'POF2026.Quantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2026.DeliverDay', @FormID, @LanguageValue, @Language;

