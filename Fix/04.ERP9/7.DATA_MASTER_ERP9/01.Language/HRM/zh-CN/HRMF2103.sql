-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2103- HRM
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
SET @FormID = 'HRMF2103';

SET @LanguageValue = N'選擇培訓建議';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2103.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓要求代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2103.TrainingProposeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2103.DepartmentID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'部門名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2103.DepartmentName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2103.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2103.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2103.CreateDate', @FormID, @LanguageValue, @Language;

