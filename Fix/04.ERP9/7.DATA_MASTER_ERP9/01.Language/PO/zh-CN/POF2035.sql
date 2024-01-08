-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2035- PO
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
SET @ModuleID = 'PO';
SET @FormID = 'POF2035';

SET @LanguageValue = N'選擇報價請求單';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'標題';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.RequestSubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'記錄時間';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'結束期限';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求內容';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.RequestDescription', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機會代碼';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.OpportunityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'機會';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.OpportunityName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'要求代碼';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.RequestCustomerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'地位';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.RequestStatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2035.RequestStatus', @FormID, @LanguageValue, @Language;

