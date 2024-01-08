-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2211- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF2211';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單位';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發布代碼';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.ReleaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發布名稱';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.ReleaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發布類型';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.TypeOfRelease', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'項目';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'里程碑';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.MilestoneID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'里程碑';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.MilestoneName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'負責人';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'發行版本';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.ReleaseVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'摘要和文件下載鏈接';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創建日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.CreateUserID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創立日期';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.CreateDate2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'創作者';
EXEC ERP9AddLanguage @ModuleID, 'OOF2211.CreateUserName', @FormID, @LanguageValue, @Language;

