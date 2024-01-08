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
SET @Language = 'vi-VN';


EXEC ERP9AddLanguage @ModuleID, N'OOF2114.Title', @FormID, N'Cập nhật checklist công việc', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF2114.ChecklistName', @FormID, N'Tên checklist', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF2114.Description', @FormID, N'Mô tả', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF2114.IsComplete', @FormID, N'Hoàn thành', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF2114.IsConfirm', @FormID, N'Xác nhận', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF2114.CreateUserID', @FormID, N'Người tạo', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF2114.CreateDate', @FormID, N'Ngày tạo', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF2114.LastModifyUserID', @FormID, N'Người cập nhật', @Language;
EXEC ERP9AddLanguage @ModuleID, N'OOF2114.LastModifyDate', @FormID, N'Ngày cập nhật', @Language;
