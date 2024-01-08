-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2163- OO
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
SET @Language = 'vi-VN' 
SET @ModuleID = 'OO';
SET @FormID = 'OOF2163';

SET @LanguageValue = N'Chọn vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2163.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2163.IssuesID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2163.IssuesName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian phát sinh vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2163.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời hạn kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2163.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2163.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dự án';
EXEC ERP9AddLanguage @ModuleID, 'OOF2163.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'OOF2163.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại vấn đề';
EXEC ERP9AddLanguage @ModuleID, 'OOF2163.TypeOfIssues', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'OOF2163.CreateUserID2', @FormID, @LanguageValue, @Language;

