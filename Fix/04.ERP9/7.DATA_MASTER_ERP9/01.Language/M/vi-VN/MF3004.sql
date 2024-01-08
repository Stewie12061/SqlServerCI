
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF0203- OO
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
SET @FormID = 'MF3004';

SET @LanguageValue = N'Báo cáo chi tiết tình hình kế hoạch sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF3004.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'MF3004.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lệnh sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF3004.ProductionOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn hàng sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'MF3004.ProduceOrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành phẩm';
EXEC ERP9AddLanguage @ModuleID, 'MF3004.InventoryID', @FormID, @LanguageValue, @Language;


