-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF3001 - CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF3001';

SET @LanguageValue = N'Báo cáo chiến dịch marketing';
EXEC ERP9AddLanguage @ModuleID, 'CRMF3001.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Marketing';
EXEC ERP9AddLanguage @ModuleID, 'AsoftCRM.BaoCaoKhac', @FormID, @LanguageValue, @Language;