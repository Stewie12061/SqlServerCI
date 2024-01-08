declare @FormID varchar(50)
declare @ModuleID varchar(50)
declare @Language varchar(50)
declare @LanguageValue nvarchar(500)
SET @ModuleID = 'CRM'
SET @Language = 'vi-VN'

SET @FormID = 'CRMF0001'
SET @LanguageValue = N'Sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0001.IsUsed' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Tên gốc';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0001.TypeID' , @FormID, @LanguageValue, @Language; 
SET @LanguageValue = N'Tên gọi(VIE)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0001.UserName' , @FormID, @LanguageValue, @Language; 
SET @LanguageValue = N'Tên gọi(ENG)';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0001.UserNameE' , @FormID, @LanguageValue, @Language;
SET @LanguageValue = N'Định nghĩa tham số';
EXEC ERP9AddLanguage @ModuleID, 'CRMF0001.CRMF0001Title' , @FormID, @LanguageValue, @Language;