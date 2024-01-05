-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF0007 - S
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
SET @ModuleID = 'S'
SET @FormID = 'SF0007'

SET @LanguageValue = N'Workspace'
EXEC ERP9AddLanguage @ModuleID, 'SF0007.Title', @FormID, @LanguageValue, @Language

SET @LanguageValue = N'Xin chào, '
EXEC ERP9AddLanguage @ModuleID, 'SF0007.Welcome', @FormID, @LanguageValue, @Language

SET @LanguageValue = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'SF0007.Division', @FormID, @LanguageValue, @Language

SET @LanguageValue = N'Chọn kỳ'
EXEC ERP9AddLanguage @ModuleID, 'SF0007.Period', @FormID, @LanguageValue, @Language

SET @LanguageValue = N'Dự án'
EXEC ERP9AddLanguage @ModuleID, 'SF0007.Project', @FormID, @LanguageValue, @Language