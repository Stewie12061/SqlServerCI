-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1032- CRM
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
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1032';

SET @LanguageValue = N'Email receipt group view';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1032.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1032.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email receipt group ID';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1032.GroupReceiverID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email receipt group name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1032.GroupReceiverName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1032.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common use';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1032.IsCommon', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1032.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1032.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1032.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1032.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Revision date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1032.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'History';
EXEC ERP9AddLanguage @ModuleID, N'CRMF1032.TabCRMT00003', @FormID, @LanguageValue , @Language;

SET @LanguageValue = N'Email receipt group information';
EXEC ERP9AddLanguage @ModuleID, N'CRMF1032.ThongTinNhomNguoiNhan', @FormID, @LanguageValue , @Language;

SET @LanguageValue = N'Receiver';
EXEC ERP9AddLanguage @ModuleID, N'CRMF1032.TabCRMT20301', @FormID, @LanguageValue , @Language;
