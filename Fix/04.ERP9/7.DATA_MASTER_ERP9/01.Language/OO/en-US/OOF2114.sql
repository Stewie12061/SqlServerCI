-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2114 - OO
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10)

/*
 - Tieng Viet: vi-VN
 - Tieng Anh: en-US
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @ModuleID = 'OO';
SET @FormID = 'OOF2114';
SET @Language = 'en-US';


EXEC ERP9AddLanguage @ModuleID, N'OOF2114.Title', @FormID, N'Update checklist', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF2114.ChecklistName', @FormID, N'Checklist name', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF2114.Description', @FormID, N'Description', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF2114.IsComplete', @FormID, N'Completed', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF2114.IsConfirm', @FormID, N'Confirmed', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF2114.CreateUserID', @FormID, N'Create user', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF2114.CreateDate', @FormID, N'Create date', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF2114.LastModifyUserID', @FormID, N'Last modify user', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF2114.LastModifyDate', @FormID, N'Update day', @Language;
