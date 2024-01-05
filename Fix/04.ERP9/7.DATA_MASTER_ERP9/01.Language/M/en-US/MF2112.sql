-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2112- M
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
SET @FormID = 'MF2112';

SET @LanguageValue = N'Inventory structure view';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Structure ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.NodeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Structure name';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.NodeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Structure type';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory structure information';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.ThongTinCauTrucSanPham', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory structure details';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.ThongTinChiTietCauTrucSanPham', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Note';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Display name';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.DisplayMember', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory';
EXEC ERP9AddLanguage @ModuleID, 'MF2112.InventoryID', @FormID, @LanguageValue, @Language;