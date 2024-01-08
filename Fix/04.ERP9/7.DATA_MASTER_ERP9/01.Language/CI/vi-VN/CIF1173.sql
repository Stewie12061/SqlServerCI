DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1173'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật mặt hàng - Tồn kho và doanh thu'
EXEC ERP9AddLanguage @ModuleID, 'CIF1173.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1173.InventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhóm tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1173.GroupID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1173.AccountID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1173.AccountName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhóm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1173.GroupID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhóm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1173.GroupName.CB',  @FormID, @LanguageValue, @Language;


SET @LanguageValue  = N'Mã tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1173.AccountID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên tài khoản';
EXEC ERP9AddLanguage @ModuleID, 'CIF1173.AccountName.CB',  @FormID, @LanguageValue, @Language;



