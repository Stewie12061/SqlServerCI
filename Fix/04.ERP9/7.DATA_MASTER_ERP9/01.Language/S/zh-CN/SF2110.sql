-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2110- S
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
SET @ModuleID = 'S';
SET @FormID = 'SF2110';

SET @LanguageValue = N'設定郵件伺服器';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'母機（SMTP）';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.Server', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'連接埠（Port）';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.Port', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.Email', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顯示名稱';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.DisplayName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'密碼';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.Password', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SSL（安全通訊端層）之使用';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.EnableSsl', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'母機（POP/IMAP）';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.ServerReceives', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'連接埠（Port）';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.PortReceives', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.EmailReceives', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'顯示名稱';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.DisplayNameReceives', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'密碼';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.PasswordReceives', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'SSL（安全通訊端層）之使用';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.EnableSslReceives', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'電子合約合作夥伴';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.EContractPartner', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'API路徑';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.EContractUrl', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'管理電子郵件';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.EContractEmail', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'密碼';
EXEC ERP9AddLanguage @ModuleID, 'SF2110.EContractPassword', @FormID, @LanguageValue, @Language;

