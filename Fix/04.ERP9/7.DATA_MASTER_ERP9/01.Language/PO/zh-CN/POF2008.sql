-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2008- PO
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
SET @FormID = 'POF2008';

SET @LanguageValue = N'繼承成本預算';
EXEC ERP9AddLanguage @ModuleID, 'POF2008.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2008.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'借款合約';
EXEC ERP9AddLanguage @ModuleID, 'POF2008.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'會計日期';
EXEC ERP9AddLanguage @ModuleID, 'POF2008.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'程式碼';
EXEC ERP9AddLanguage @ModuleID, 'POF2008.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'對象名稱';
EXEC ERP9AddLanguage @ModuleID, 'POF2008.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'注解';
EXEC ERP9AddLanguage @ModuleID, 'POF2008.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2008.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'申請人';
EXEC ERP9AddLanguage @ModuleID, 'POF2008.EmployeeName', @FormID, @LanguageValue, @Language;

