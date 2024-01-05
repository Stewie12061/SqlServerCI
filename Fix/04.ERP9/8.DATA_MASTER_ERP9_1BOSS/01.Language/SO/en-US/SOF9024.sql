
-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SOF9024- OO
-- Đình Hòa - 29/03/2021 - Bổ sung ngôn ngũ
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
SET @ModuleID = 'SO';
SET @FormID = 'SOF9024';

SET @LanguageValue = N'Choose Account';
EXEC ERP9AddLanguage @ModuleID, 'SOF9024.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'SOF9024.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account code';
EXEC ERP9AddLanguage @ModuleID, 'SOF9024.AccountID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Account name';
EXEC ERP9AddLanguage @ModuleID, 'SOF9024.AccountName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Address';
EXEC ERP9AddLanguage @ModuleID, 'SOF9024.Address' , @FormID, @LanguageValue, @Language;


