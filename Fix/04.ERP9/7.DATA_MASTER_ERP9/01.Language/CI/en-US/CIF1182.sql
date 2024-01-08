-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1182- CI
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
SET @Language = 'en-US'; 
SET @ModuleID = 'CI';
SET @FormID = 'CIF1182';

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm set code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.KITID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Norm set name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.KITName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gift code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.InventoryGiftID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Gift name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.InventoryGiftName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shared';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Not displayed';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.EmployeeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Employee name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.EmployeeName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date created';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Edit date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Repairer';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Batch number - Item';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'The person who set it up';
EXEC ERP9AddLanguage @ModuleID, 'CIF1182.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Information KIT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1282.ThongTinDieuKhoanThanhToan',  @FormID, @LanguageValue, @Language;
