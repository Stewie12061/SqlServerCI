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
SET @FormID = 'CIF1381'
SET @CustomerName = (SELECT CustomerName FROM CustomerIndex)
---------------------------------------------------------------

SET @LanguageValue  = N'Thiết lập mối quan hệ asm-sup-sales-dealer'
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.UserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.UserName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.SaleID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đại lý/cửa hàng (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.DealerID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'SUP';
IF(@CustomerName=162)
BEGIN
SET @LanguageValue  = N'Sale Manager';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.SUPID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ASM';
IF(@CustomerName=162)
BEGIN
SET @LanguageValue  = N'Area Sales Director';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.ASMID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Regional Sales Director';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.RSDID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'National Director';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.NDID',  @FormID, @LanguageValue, @Language;
-----

SET @LanguageValue  = N'Mã người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.UserID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên người sử dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.UserName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.SaleID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên nhân viên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.SaleName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã đại lý/cửa hàng (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.DealerID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên đại lý/cửa hàng (Dealer)';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.DealerName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã SUP';
IF(@CustomerName=162)
BEGIN
SET @LanguageValue  = N'Mã SM';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.SUPID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'SUP';
IF(@CustomerName=162)
BEGIN
SET @LanguageValue  = N'Tên SM';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.SUPName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ASM';
IF(@CustomerName=162)
BEGIN
SET @LanguageValue  = N'Mã ASD';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.ASMID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'ASM';
IF(@CustomerName=162)
BEGIN
SET @LanguageValue  = N'Tên ASD';
END
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.ASMName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã RSD';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.RSDID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên RSD';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.RSDName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã ND';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.NDID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên ND';
EXEC ERP9AddLanguage @ModuleID, 'CIF1381.NDName.CB',  @FormID, @LanguageValue, @Language;