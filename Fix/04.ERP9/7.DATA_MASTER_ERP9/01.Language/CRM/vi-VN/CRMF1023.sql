-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1023 - CRM
------------------------------------------------------------------------------------------------------

DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
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
SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1023'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn nguồn đầu mối'
EXEC ERP9AddLanguage @ModuleID, 'CRMF1023.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nguồn đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1023.LeadTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nguồn đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1023.LeadTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1023.Description',  @FormID, @LanguageValue, @Language;