-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2090- HRM
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
SET @FormID = 'HRMF2090';

SET @LanguageValue = N'培訓建議清單';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓建議代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.TrainingProposeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Date';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.Date', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'擬議費用';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.ProposeAmount', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'描述1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.Description1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'描述2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.Description2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.Description3', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IsAll';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.IsAll', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'附件';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.Attach', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最後修改的使用者 ID';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'最後修改日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'繼承ID1';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.InheritID1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'繼承名';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.InheritName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'InhertiID2';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2090.InheritID2', @FormID, @LanguageValue, @Language;

