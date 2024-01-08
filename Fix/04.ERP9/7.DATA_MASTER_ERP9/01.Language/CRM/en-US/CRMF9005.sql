-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF9005- CRM
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
SET @FormID = 'CRMF9005';

SET @LanguageValue = N'Assigned list user';
EXEC ERP9AddLanguage @ModuleID, '.TitleCRMFCRMF9005.AssignedListUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assigned to user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event ending date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.EventEndDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event starting date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.CRMF9005.EventStartDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event status';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.EventStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event subject';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.EventSubject', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Location';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.Location', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Priority';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.PriorityID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Related type object';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.RelatedToTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Related type object';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.RelatedToTypeID_REL', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Update quotation form';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Event';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.Type1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Activity type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.TypeActive', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.TypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assigned User';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.AssignedListUserID', @FormID, @LanguageValue, @Language;

-- [Đình Hòa] [26/02/2021] - Bổ sung ngôn ngữ
SET @LanguageValue = N'Event Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9005.EventStartDate', @FormID, @LanguageValue, @Language;