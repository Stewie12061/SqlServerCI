-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF1071- HRM
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
SET @Language = 'en-US' 
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF1071';

SET @LanguageValue  = N'Female'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.IsMale',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Married'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.IsSingle',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Update user default profile'
EXEC ERP9AddLanguage @ModuleID, 'HRMF1071.Title',  @FormID, @LanguageValue, @Language;
