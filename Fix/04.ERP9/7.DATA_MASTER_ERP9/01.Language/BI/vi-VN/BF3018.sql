DECLARE
@ModuleID VARCHAR(5),
@FormID VARCHAR(50),
@Language VARCHAR(10),
@LanguageValue NVARCHAR(4000),
@LanguageCustomValue NVARCHAR(4000)

SET @Language = 'vi-VN'; 
SET @ModuleID = 'BI';
SET @FormID = 'BF3018';
SET @LanguageValue = N'Đơn vị';
SET @LanguageCustomValue = N'';

EXEC ERP9AddLanguage @ModuleID, 'BF3018.DivisionID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;	

-----------------------------
SET @Language = 'vi-VN'; 
SET @ModuleID = 'BI';
SET @FormID = 'BF3018';
SET @LanguageValue = N'Báo cáo số dư tiền mặt, tiền gửi ngân hàng 1';
SET @LanguageCustomValue = N'';

EXEC ERP9AddLanguage @ModuleID, 'BF3018.Title' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;	

--------------------
SET @Language = 'vi-VN'; 
SET @ModuleID = 'BI';
SET @FormID = 'BF3018';
SET @LanguageValue = N'Tài khoản';
SET @LanguageCustomValue = N'';

EXEC ERP9AddLanguage @ModuleID, 'BF3018.AccountID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;	

--------------------		
SET @Language = 'vi-VN'; 
SET @ModuleID = 'BI';
SET @FormID = 'BF3018';
SET @LanguageValue = N'Ngân hàng';
SET @LanguageCustomValue = N'';

EXEC ERP9AddLanguage @ModuleID, 'BF3018.BankID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;	

--------------------
SET @Language = 'vi-VN'; 
SET @ModuleID = 'BI';
SET @FormID = 'BF3018';
SET @LanguageValue = N'Loại tiền';
SET @LanguageCustomValue = N'';

EXEC ERP9AddLanguage @ModuleID, 'BF3018.CurrencyID' , @FormID, @LanguageValue, @Language, @LanguageCustomValue;	


