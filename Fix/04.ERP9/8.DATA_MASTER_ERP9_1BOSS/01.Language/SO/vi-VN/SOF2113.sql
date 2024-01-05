------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2113 - CRM 
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
SET @FormID = 'SOF2113';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2113.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2113.NodeTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2113.NodeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên sản phẩm';
EXEC ERP9AddLanguage @ModuleID, 'SOF2113.NodeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'SOF2113.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phiên bản số lượng';
EXEC ERP9AddLanguage @ModuleID, 'SOF2113.QuantityVersion' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quy trình sản xuất';
EXEC ERP9AddLanguage @ModuleID, 'SOF2113.RoutingID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'SOF2113.Description' , @FormID, @LanguageValue, @Language;