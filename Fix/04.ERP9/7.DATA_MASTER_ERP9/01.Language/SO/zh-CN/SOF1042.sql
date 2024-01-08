-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF1042- SO
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF1042';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF1042.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'SOF1042.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作代碼';
EXEC ERP9AddLanguage @ModuleID, 'SOF1042.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'工作名稱';
EXEC ERP9AddLanguage @ModuleID, 'SOF1042.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF1042.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'SOF1042.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'SOF1042.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF1042.LastModifyDate', @FormID, @LanguageValue, @Language;

