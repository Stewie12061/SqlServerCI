-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ HRMF2035- HRM
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
SET @ModuleID = 'HRM';
SET @FormID = 'HRMF2035';

SET @LanguageValue = N'選擇應聘人';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2035.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘人代碼';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2035.CandidateID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'應聘人姓名';
EXEC ERP9AddLanguage @ModuleID, 'HRMF2035.CandidateName', @FormID, @LanguageValue, @Language;

