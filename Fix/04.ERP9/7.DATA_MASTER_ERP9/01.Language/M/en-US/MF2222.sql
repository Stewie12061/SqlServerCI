-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF2222- M
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
SET @FormID = 'MF2222';

SET @LanguageValue = N'Details Order Production';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order Date';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.OrderDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order type';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.ClassifyID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order status';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.OrderStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory type';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit SO';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.IsInheritSO', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inherit BOM';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.IsInheritBOM', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Followers';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ship date';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.ShipDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.Notes', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory ID';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.InventoryID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory Name';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.InventoryName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Quantity';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.OrderQuantity', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Link No';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.LinkNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Date';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.EndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ref Infor';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.RefInfor', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Period';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.IsPeriod', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Plan';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.IsPlan', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object Period';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.PeriodID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Modify User';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Modify Date';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create User';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create Date';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Details Order Production';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.ThongTinChiTietDonHangSanXuat', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Inventory Production';
EXEC ERP9AddLanguage @ModuleID, 'MF2222.VatLieuSanXuat', @FormID, @LanguageValue, @Language;
