-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ KPIF1011- KPI
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
SET @ModuleID = 'KPI';
SET @FormID = 'KPIF1011';

SET @LanguageValue = N'Targets group Update';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets group ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.TargetsGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets group name';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.TargetsGroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Targets type';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.TargetsTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.Note', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Order group';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.DivisionName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.DepartmentName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.DepartmentID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Department';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.DepartmentName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Percentage';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.Percentage',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Goal';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.Goal',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division ID';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.DivisionID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'KPIF1011.DivisionName.CB',  @FormID, @LanguageValue, @Language;