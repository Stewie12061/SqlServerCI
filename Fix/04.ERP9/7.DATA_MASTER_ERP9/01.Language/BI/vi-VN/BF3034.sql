-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ
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


SET @Language = 'vi-VN';
SET @ModuleID = 'BI';
SET @FormID = 'BF3034'

SET @LanguageValue  = N'Báo cáo SALES'
EXEC ERP9AddLanguage @ModuleID, 'BF3034.Title',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Đơn vị'
EXEC ERP9AddLanguage @ModuleID, 'BF3034.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày'
EXEC ERP9AddLanguage @ModuleID, 'BF3034.Date',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'BF3034.ObjectID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tài khoản'
EXEC ERP9AddLanguage @ModuleID, 'BF3034.AccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tiền tệ'
EXEC ERP9AddLanguage @ModuleID, 'BF3034.CurrencyID',  @FormID, @LanguageValue, @Language;


