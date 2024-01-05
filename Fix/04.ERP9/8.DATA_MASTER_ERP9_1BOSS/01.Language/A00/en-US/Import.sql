﻿------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ kỳ kế toán
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
 - Tieng Viet: en-US 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'en-US' 
SET @ModuleID = '00';
SET @FormID = 'Import';
------------------------------------------------------------------------------------------------------
-- Title
SET @LanguageValue = N'Import data';
EXEC ERP9AddLanguage @ModuleID, 'Import.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Import from excel';
EXEC ERP9AddLanguage @ModuleID, 'Import.TitleDynamic' , @FormID, @LanguageValue, @Language;


------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;
