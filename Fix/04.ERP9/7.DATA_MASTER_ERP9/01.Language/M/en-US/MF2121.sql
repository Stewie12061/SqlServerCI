-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2121- M
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
SET @Language = 'en-US' 
SET @ModuleID = 'M';
SET @FormID = 'MF2121';

SET @LanguageValue = N'Inventory norm Update';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.NodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.NodeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start date';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.StartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To date';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory name';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Structure type';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.NodeTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inheritance type';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.InheritID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create BOM';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.CreateBOMVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.Version', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production process';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.RoutingID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Version quantity';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.QuantityVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.NodeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Display name';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dictates name';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.DictatesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machining';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.OutsourceName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Production order';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.PhaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative type';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.QuantitativeTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.QuantitativeValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loss';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.LossValue', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material group ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.MaterialGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material group';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.MaterialGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Alternative material';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Coefficient';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.MaterialConstant', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.NodeTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.NodeTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.StandardID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Standard';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.StandardName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.QuantitativeTypeID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantitative';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.QuantitativeTypeName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.MaterialGroupID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Group';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.MaterialGroupName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.MaterialID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Material';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.MaterialName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.RoutingID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Routing';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.RoutingName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.OutsourceID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Machining';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.OutsourceName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.DictatesID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dictates';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.DictatesName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.PhaseID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Phase';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.PhaseName.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.InheritID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit';
EXEC ERP9AddLanguage @ModuleID, 'MF2121.InheritName.CB', @FormID, @LanguageValue, @Language;