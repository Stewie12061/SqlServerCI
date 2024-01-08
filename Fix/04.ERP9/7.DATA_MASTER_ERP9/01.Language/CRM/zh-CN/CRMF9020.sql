-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF9020- CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9020';

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9020.CodeMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'序號';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9020.OrderNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'代碼';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9020.ID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'描述';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9020.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'說明（英文）';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9020.DescriptionE', @FormID, @LanguageValue, @Language;

