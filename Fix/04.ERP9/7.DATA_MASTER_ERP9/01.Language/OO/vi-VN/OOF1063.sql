-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF1063- OO
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
SET @FormID = 'OOF1063';

SET @LanguageValue = N'Chọn mẫu công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1063.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã mẫu công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1063.TaskSampleID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mẫu công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1063.TaskSampleName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'OOF1063.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF1063.TaskTypeName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thời gian thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'OOF1063.ExecutionTime', @FormID, @LanguageValue, @Language;