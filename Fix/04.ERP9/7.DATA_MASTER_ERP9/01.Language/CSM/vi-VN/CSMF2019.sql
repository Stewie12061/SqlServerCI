-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CSMF2019- CSM
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
SET @ModuleID = 'CSM';
SET @FormID = 'CSMF2019';

SET @LanguageValue = N'Cập nhật Checklist Kỹ thuật';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2019.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên công việc';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2019.DataName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đã thực hiện';
EXEC ERP9AddLanguage @ModuleID, 'CSMF2019.IsDone', @FormID, @LanguageValue, @Language;
