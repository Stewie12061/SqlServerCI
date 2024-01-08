-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2013- PO
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
SET @FormID = 'POF2013';

SET @LanguageValue = N'供應商能力清單';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Leadtime_MOQ編號';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.LeadTimeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品組';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編制人員';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'適用從';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.FromDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'適用到';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.ToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'商品組';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.InventoryTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編制人員';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.GroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.Priority1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.Priority2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2013.Priority3', @FormID, @LanguageValue, @Language;

