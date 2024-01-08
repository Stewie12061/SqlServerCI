DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF9014'
---------------------------------------------------------------

SET @LanguageValue  = N'Chọn đầu mối'
EXEC ERP9AddLanguage @ModuleID, 'CRMF9014.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9014.LeadID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đầu mối';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9014.LeadName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Địa chỉ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9014.Address',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Email';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9014.Email',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số điện thoại';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9014.LeadMobile',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người phụ trách';
EXEC ERP9AddLanguage @ModuleID, 'CRMF9014.AssignedToUserID',  @FormID, @LanguageValue, @Language;