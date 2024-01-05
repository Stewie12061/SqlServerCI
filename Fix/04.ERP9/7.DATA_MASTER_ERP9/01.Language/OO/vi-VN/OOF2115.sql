-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2115- OO
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
SET @FormID = 'OOF2115';

SET @LanguageValue = N'Chọn công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2115.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2115.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2115.TaskID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công việc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2115.TaskName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày bắt đầu';
EXEC ERP9AddLanguage @ModuleID, 'OOF2115.PlanStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày kết thúc';
EXEC ERP9AddLanguage @ModuleID, 'OOF2115.PlanEndDate', @FormID, @LanguageValue, @Language;


