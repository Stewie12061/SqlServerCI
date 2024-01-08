-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF2052- SO
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
SET @FormID = 'SOF2052';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2052.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'SOF2052.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'職員';
EXEC ERP9AddLanguage @ModuleID, 'SOF2052.EmployeeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2052.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'SOF2052.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'改正人';
EXEC ERP9AddLanguage @ModuleID, 'SOF2052.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'SOF2052.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'授予的限額';
EXEC ERP9AddLanguage @ModuleID, 'SOF2052.TotalQuota', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'年';
EXEC ERP9AddLanguage @ModuleID, 'SOF2052.Year', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SOF2052.EmployeeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'債務限額';
EXEC ERP9AddLanguage @ModuleID, 'SOF2052.Beginning', @FormID, @LanguageValue, @Language;

