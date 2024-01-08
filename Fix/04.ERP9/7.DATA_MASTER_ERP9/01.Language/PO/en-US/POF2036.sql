-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2036- PO
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
SET @ModuleID = 'PO';
SET @FormID = 'POF2036';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2036.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Document number';
EXEC ERP9AddLanguage @ModuleID, 'POF2036.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Day';
EXEC ERP9AddLanguage @ModuleID, 'POF2036.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'POF2036.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Petitioner';
EXEC ERP9AddLanguage @ModuleID, 'POF2036.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Object';
EXEC ERP9AddLanguage @ModuleID, 'POF2036.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subjects of THCP';
EXEC ERP9AddLanguage @ModuleID, 'POF2036.ObjectTHCP', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Explain';
EXEC ERP9AddLanguage @ModuleID, 'POF2036.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2036.EstimateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2036.InventoryTypeID', @FormID, @LanguageValue, @Language;

