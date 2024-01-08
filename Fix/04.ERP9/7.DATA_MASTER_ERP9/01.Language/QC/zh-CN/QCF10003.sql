﻿-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ QCF10003- QC
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
SET @Language = 'zh-CN' 
SET @ModuleID = 'QC';
SET @FormID = 'QCF10003';

SET @LanguageValue = N'标准清单';
EXEC ERP9AddLanguage @ModuleID, 'QCF10003.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF10003.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF10003.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准代码';
EXEC ERP9AddLanguage @ModuleID, 'QCF10003.StandardID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准名称';
EXEC ERP9AddLanguage @ModuleID, 'QCF10003.StandardName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准名称  (英文）';
EXEC ERP9AddLanguage @ModuleID, 'QCF10003.StandardNameE', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'QCF10003.UnitID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'單元';
EXEC ERP9AddLanguage @ModuleID, 'QCF10003.UnitName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'标准型';
EXEC ERP9AddLanguage @ModuleID, 'QCF10003.TypeName', @FormID, @LanguageValue, @Language;

