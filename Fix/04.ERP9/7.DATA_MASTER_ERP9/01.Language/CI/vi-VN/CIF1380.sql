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
SET @FormID = 'CIF1380'
SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)
---------------------------------------------------------------

SET @LanguageValue  = N'Danh mục mối quan hệ asm-sup-sales-dealer'
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.DivisionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.UserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.UserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.SaleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.SaleName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đại lý/cửa hàng (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.DealerID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đại lý/cửa hàng (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.DealerName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'SUP';
IF(@CustomerName=162)
BEGIN
SET @LanguageValue  = N'Sale Manager';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.SUPID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'SUP';
IF(@CustomerName=162)
BEGIN
SET @LanguageValue  = N'Sale Manager';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.SUPName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ASM';
IF(@CustomerName=162)
BEGIN
SET @LanguageValue  = N'Area Sales Director';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.ASMID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ASM';
IF(@CustomerName=162)
BEGIN
SET @LanguageValue  = N'Area Sales Director';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.ASMName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Regional Sales Director';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.RSDID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Regional Sales Director';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.RSDName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'National Director';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.NDID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'National Director';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.NDName',  @FormID, @LanguageValue, @Language;

----------------------------------------------------------------------------------------------

SET @LanguageValue  = N'Mã người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.UserID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.UserName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.SaleID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.SaleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đại lý/cửa hàng (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.DealerID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đại lý/cửa hàng (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.DealerName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã SUP';
IF(@CustomerName=162)
BEGIN
SET @LanguageValue  = N'Mã SM';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.SUPID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'SUP';
IF(@CustomerName=162)
BEGIN
SET @LanguageValue  = N'Tên SM';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.SUPName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ASM';
IF(@CustomerName=162)
BEGIN
SET @LanguageValue  = N'Mã ASD';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.ASMID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ASM';
IF(@CustomerName=162)
BEGIN
SET @LanguageValue  = N'Tên ASD';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.ASMName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã RSD';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.RSDID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên RSD';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.RSDName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ND';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.NDID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ND';
EXEC ERP9AddLanguage @ModuleID, 'CIF1380.NDName.CB',  @FormID, @LanguageValue, @Language;