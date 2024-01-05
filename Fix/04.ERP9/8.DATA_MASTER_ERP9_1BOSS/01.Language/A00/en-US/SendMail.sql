------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ kỳ kế toán
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
SET @ModuleID = '00';
SET @FormID = 'SendMail';
------------------------------------------------------------------------------------------------------
-- Title
SET @LanguageValue = N'Send mail';
EXEC ERP9AddLanguage @ModuleID, 'SendMail.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Assigned to';
EXEC ERP9AddLanguage @ModuleID, 'SendMail.AssignedToUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Email assigned to';
EXEC ERP9AddLanguage @ModuleID, 'SendMail.EmailAssignedTo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To';
EXEC ERP9AddLanguage @ModuleID, 'SendMail.ToReceiver' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'CC';
EXEC ERP9AddLanguage @ModuleID, 'SendMail.CCReceiver' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'BCC';
EXEC ERP9AddLanguage @ModuleID, 'SendMail.BCCReceiver' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Subject';
EXEC ERP9AddLanguage @ModuleID, 'SendMail.EmailSubject' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach file';
EXEC ERP9AddLanguage @ModuleID, 'SendMail.AttachFile' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'NO of attach file';
EXEC ERP9AddLanguage @ModuleID, 'SendMail.NoOfAttachfile' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach file name';
EXEC ERP9AddLanguage @ModuleID, 'SendMail.AttachmentFileName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attach';
EXEC ERP9AddLanguage @ModuleID, 'SendMail.AttachFileTitle' , @FormID, @LanguageValue, @Language;



------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;