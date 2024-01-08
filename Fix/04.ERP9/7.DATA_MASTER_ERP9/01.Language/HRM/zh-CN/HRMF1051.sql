-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1051- HRM
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
SET @FormID = 'HRMF1051';

SET @LanguageValue = N'更新培訓課程';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.TrainingCourseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'訓練場';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.TrainingFieldID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓形式';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.TrainingType', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'培訓夥伴';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地址';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.Address', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'子系統名稱';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1051.FromToDate', @FormID, @LanguageValue, @Language;

