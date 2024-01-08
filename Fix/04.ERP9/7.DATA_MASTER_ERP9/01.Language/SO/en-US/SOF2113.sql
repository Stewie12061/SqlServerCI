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
SET @Language = 'en-US';
SET @ModuleID = 'SO';
SET @FormID = 'SOF2113';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SOF2113.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Node Type';
EXEC ERP9AddLanguage @ModuleID, 'SOF2113.NodeTypeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Node ID';
EXEC ERP9AddLanguage @ModuleID, 'SOF2113.NodeID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Node Name';
EXEC ERP9AddLanguage @ModuleID, 'SOF2113.NodeName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'SOF2113.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity Version';
EXEC ERP9AddLanguage @ModuleID, 'SOF2113.QuantityVersion' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Routing';
EXEC ERP9AddLanguage @ModuleID, 'SOF2113.RoutingID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'SOF2113.Description' , @FormID, @LanguageValue, @Language;