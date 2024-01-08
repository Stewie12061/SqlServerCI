-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2115- OO
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
SET @FormID = 'OOF2115';

SET @LanguageValue = N'Choose Task';
EXEC ERP9AddLanguage @ModuleID, 'OOF2115.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Unit';
EXEC ERP9AddLanguage @ModuleID, 'OOF2115.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'TaskID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2115.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Task Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2115.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2115.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'End Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2115.PlanEndDate', @FormID, @LanguageValue, @Language;


