-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1080- S
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
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1080';

SET @LanguageValue = N'Định nghĩa ban đầu';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1080.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1080.CodeMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên dữ liệu';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1080.CodeMasterName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chi tiết';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1080.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chi tiết 01';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1080.ID1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số thứ tự';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1080.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1080.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải (Eng)';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1080.DescriptionE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1080.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'HRMF1080.Edit', @FormID, @LanguageValue, @Language;