------------------------------------------------------------------------------------------------------
-- Script t?o ngôn ng? CIF1112 
-----------------------------------------------------------------------------------------------------
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
SET @ModuleID = 'CI';
SET @FormID = 'CIF1112';
------------------------------------------------------------------------------------------------------
--- Title
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Category payment';
EXEC ERP9AddLanguage @ModuleID, 'CIF1112.Title' , @FormID, @LanguageValue, @Language;

--- TAB
-----------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'CIF1112.DivisionID' , @FormID, @LanguageValue, @Language;

------------------------------------------------------------------------------------------------------
SET @LanguageValue = N'Payment code';
EXEC ERP9AddLanguage @ModuleID, 'CIF1112.PaymentID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Payment name';
EXEC ERP9AddLanguage @ModuleID, 'CIF1112.PaymentName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Common';
EXEC ERP9AddLanguage @ModuleID, 'CIF1112.IsCommon' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Disable';
EXEC ERP9AddLanguage @ModuleID, 'CIF1112.Disabled' , @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1112.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify date';
EXEC ERP9AddLanguage @ModuleID, 'CIF1112.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Last modify user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1112.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Create user';
EXEC ERP9AddLanguage @ModuleID, 'CIF1112.CreateUserID',  @FormID, @LanguageValue, @Language;


    SET @LanguageValue = N'Information payment';
EXEC ERP9AddLanguage @ModuleID, 'CIF1112.ThongTinPhuongThucThanhToan' , @FormID, @LanguageValue, @Language;

    SET @LanguageValue = N'Information payment';
EXEC ERP9AddLanguage @ModuleID, 'CIF1121.ThongTinPhuongThucThanhToan' , @FormID, @LanguageValue, @Language;
------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
SET @Finished = 0;