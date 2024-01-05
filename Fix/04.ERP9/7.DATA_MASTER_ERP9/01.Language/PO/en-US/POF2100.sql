-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POF2100- PO
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
SET @ModuleID = 'PO';
SET @FormID = 'POF2100';

SET @LanguageValue = N'List of receipt schedule';
EXEC ERP9AddLanguage @ModuleID, 'POF2100.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'POF2100.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher No';
EXEC ERP9AddLanguage @ModuleID, 'POF2100.VoucherNo', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Voucher date';
EXEC ERP9AddLanguage @ModuleID, 'POF2100.VoucherDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POF2100.ObjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchase order';
EXEC ERP9AddLanguage @ModuleID, 'POF2100.POrderID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'POF2100.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'POF2100.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'POF2100.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified date';
EXEC ERP9AddLanguage @ModuleID, 'POF2100.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Purchaser order';
EXEC ERP9AddLanguage @ModuleID, 'POF2100.POrderName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Customer';
EXEC ERP9AddLanguage @ModuleID, 'POF2100.ObjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2100.FormToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'POF2100.VoucherTypeID', @FormID, @LanguageValue, @Language;

