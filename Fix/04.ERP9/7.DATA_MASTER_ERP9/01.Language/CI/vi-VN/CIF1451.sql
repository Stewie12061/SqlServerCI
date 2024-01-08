DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1451'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật mã phân tích'
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bút toán'
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.TabTranSaction',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mặt hàng'
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.TabInventory',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng'
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.TabObject',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày'
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.TabDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú'
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.TabNotes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.TypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định nghĩa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.UserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Định nghĩa (tiếng Anh)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.UserNameE',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên gốc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.SystemName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.BusinessTypeName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích phụ thuộc';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.ReTypeID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quản lý hạn mức';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.Status',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chính sách khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.Status_Object',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Dùng chung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.IsCommon',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.Disabled',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.IsUsed',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nghiệp vụ mặc định';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.DefaultBusinessName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.AnaID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên phân tích';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.AnaName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.BusinessTypeID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nghiệp vụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1451.BusinessTypeName.CB',  @FormID, @LanguageValue, @Language;