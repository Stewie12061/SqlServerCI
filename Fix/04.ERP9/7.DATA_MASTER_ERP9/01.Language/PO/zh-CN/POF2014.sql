-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2014- PO
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
SET @Language = 'zh-CN' 
SET @ModuleID = 'PO';
SET @FormID = 'POF2014';

SET @LanguageValue = N'更新供應商能力';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leadtime_MOQ編號';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.LeadTimeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品組';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編制人員';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'適用從';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'適用到';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編制人員';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.GroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先級1';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.Priority1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先級2';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.Priority2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'優先級3';
EXEC ERP9AddLanguage @ModuleID, 'POF2014.Priority3', @FormID, @LanguageValue, @Language;

