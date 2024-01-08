-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2092- HRM
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
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2092';

SET @LanguageValue = N'查看培訓提議明細';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓建議代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.TrainingProposeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'擬議費用';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.ProposeAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'目标';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.Description1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'內容';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.Description2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.Description3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.IsAll', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.InheritID1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'遺產';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.InheritName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2092.InheritID2', @FormID, @LanguageValue, @Language;

