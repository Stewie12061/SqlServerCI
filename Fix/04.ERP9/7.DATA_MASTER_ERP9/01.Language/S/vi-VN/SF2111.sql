-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2111 - S
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
SET @ModuleID = 'S';
SET @FormID = 'SF2111';

SET @LanguageValue = N'Thiết lập phân hệ';
EXEC ERP9AddLanguage @ModuleID, 'SF2111.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Loại thiết lập';
EXEC ERP9AddLanguage @ModuleID, 'SF2111.MenuHeader', @FormID, @LanguageValue, @Language;