-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ SF2023- S
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
SET @ModuleID = 'S';
SET @FormID = 'SF2023';

SET @LanguageValue = N'Choose business voucher';
EXEC ERP9AddLanguage @ModuleID, 'SF2023.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business voucher';
EXEC ERP9AddLanguage @ModuleID, 'SF2023.VoucherBusiness', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Business voucher name';
EXEC ERP9AddLanguage @ModuleID, 'SF2023.VoucherBusinessName', @FormID, @LanguageValue, @Language;

