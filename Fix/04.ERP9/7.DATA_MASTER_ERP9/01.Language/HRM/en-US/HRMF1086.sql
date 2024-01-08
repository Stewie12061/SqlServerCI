﻿-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1032- OO
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


SET @Language = 'en-US ';
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1086'

SET @LanguageValue  = N'DivisionID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Update the definition of resignation code classification.'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Unit'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classification'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.STypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classification code'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.S',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Classification name'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.SName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'1.Classification'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.PhanLoai1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'2.Classification'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.PhanLoai2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'3.Classification'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.PhanLoai3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Disabled'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'CreateDate'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'CreateUserID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'LastModifyDate'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'LastModifyUserID'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1086.LastModifyUserID',  @FormID, @LanguageValue, @Language;
