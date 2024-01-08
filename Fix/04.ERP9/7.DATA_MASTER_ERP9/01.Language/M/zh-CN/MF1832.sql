-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ MF1832- M
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
SET @ModuleID = 'M';
SET @FormID = 'MF1832';

SET @LanguageValue = N'替代材料的詳細信息之查看';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'集團程式碼';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.MaterialGroupID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'團隊名字';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.GroupName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'原料類型';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.InventoryTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'未显示';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'共享';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'建立日期';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'操作人';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯日期';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'編輯人';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'材料代號';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.MaterialID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'材料名稱';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.MaterialName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'MF1832.MaterialName_Temp', @FormID, @LanguageValue, @Language;

