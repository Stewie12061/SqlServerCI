-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2010- CSM
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
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF2022';

SET @LanguageValue = N'Chọn linh kiện';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2022.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã linh kiện';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2022.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên linh kiện';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2022.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Kho';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2022.WareHouseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng thực tế';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2022.ActualQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng giữ chỗ';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2022.OrderedQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng sẵn sàng';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2022.AvailableQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2022.AvailableQuantityTech', @FormID, @LanguageValue, @Language;

