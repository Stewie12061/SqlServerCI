DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
@CustomerName INT,
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1382'
SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)
---------------------------------------------------------------

SET @LanguageValue  = N'Chi tiết mối quan hệ asm-sup-sales-dealer'
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.UserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.UserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.SaleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.SaleName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đại lý/cửa hàng (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.DealerID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đại lý/cửa hàng (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.DealerName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã SUP';
IF(@CustomerName=161)
BEGIN
SET @LanguageValue  = N'Mã Sale Manager';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.SUPID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'SUP';
IF(@CustomerName=161)
BEGIN
SET @LanguageValue  = N'Sale Manager';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.SUPName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ASM';
IF(@CustomerName=161)
BEGIN
SET @LanguageValue  = N'Mã Area Sales Director';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.ASMID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ASM';
IF(@CustomerName=161)
BEGIN
SET @LanguageValue  = N'Area Sales Director';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.ASMName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Regional Sales Director';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.RSDID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Regional Sales Director';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.RSDName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'National Director';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.NDID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'National Director';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.NDName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thông tin mối quan hệ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.ThongTinMoiQuanHe',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.StatusID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.LastModifyDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.LastModifyUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.CreateUserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CIF1382.TabCRMT00002',  @FormID, @LanguageValue, @Language;