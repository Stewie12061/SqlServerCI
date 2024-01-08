
------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2004 - CRM 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2004';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Xem nhanh tồn kho';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2004.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi nhánh';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2004.DivisionID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Mã mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2004.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2004.InventoryName' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Mã kho';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2004.WareHouseID' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Tồn kho thực tế';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2004.EndQuantity' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Hàng đang về';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2004.PQuantity' , @FormID, @LanguageValue, @Language;

  SET @LanguageValue = N'Hàng giữ chổ';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2004.SQuantity' , @FormID, @LanguageValue, @Language;

 SET @LanguageValue = N'Tồn kho sẵn sàng';
 EXEC ERP9AddLanguage @ModuleID, 'SOF2004.ReadyQuantity' , @FormID, @LanguageValue, @Language;
