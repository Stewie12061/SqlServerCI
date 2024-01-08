-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2004- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF2004';

SET @LanguageValue = N'Employee code';
EXEC ERP9AddLanguage @ModuleID, 'OOF2004.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Staff is name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2004.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Allowed time (Hours)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2004.TimeAllowance', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Overtime';
EXEC ERP9AddLanguage @ModuleID, 'OOF2004.OffsetTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'OT Time (Hours/Month)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2004.OvertTime', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time to exceed state OT (Hours/Month)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2004.OvertTimeNN', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Time exceeding company OT (Hours/Month)';
EXEC ERP9AddLanguage @ModuleID, 'OOF2004.OvertTimeCompany', @FormID, @LanguageValue, @Language;

