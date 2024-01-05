

------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0000 - POS
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
SET @ModuleID = 'POS';
SET @FormID = 'POSF0120';


SET @LanguageValue = N'Commissions category by accumulated revenue';
EXEC ERP9AddLanguage @ModuleID, 'POSF0120.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POSF0120.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Shop ID';
EXEC ERP9AddLanguage @ModuleID, 'POSF0120.ShopID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'From in come';
EXEC ERP9AddLanguage @ModuleID, 'POSF0120.FromIncome' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'To in come';
EXEC ERP9AddLanguage @ModuleID, 'POSF0120.ToIncome' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Commission rate';
EXEC ERP9AddLanguage @ModuleID, 'POSF0120.CommissionRate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description';
EXEC ERP9AddLanguage @ModuleID, 'POSF0120.Description' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'POSF0120.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disabled';
EXEC ERP9AddLanguage @ModuleID, 'POSF0120.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'POSF0120.CreateDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'POSF0120.CreateUserID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'POSF0120.LastModifyDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'POSF0120.LastModifyUserID' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;