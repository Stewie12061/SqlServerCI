DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CI';
SET @FormID = 'CIF1523'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật chi tiết khuyến mãi cho điều kiện'
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng áp dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.Target',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Áp dụng từ số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.TargetQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đến số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.ToTargetQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Cách trả chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.PaymentMethod',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính áp dụng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.UnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.UnitName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Quà tặng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.InventoryGiftID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng quà tặng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.InventoryGiftQuantity',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã điều kiện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.ConditionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã hàng khuyến mãi';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.PromoteInventoryID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bậc khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.Level',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày trả quà';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.ReturnGifeDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Giá trị';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.Value',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.Notes',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.PromotionID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên điều kiện';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.ConditionName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Công cụ';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.ToolID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Điều kiện thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.PaymentID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đối tượng xác định khác';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.ObjectCustomID',  @FormID, @LanguageValue, @Language;
SET @LanguageValue  = N'Mã neo';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.AnchorID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.PaymentMethod.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.PaymentMethodName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.AnchorID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.AnchorName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã DVT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.UnitID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên DVT';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.UnitName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.Level.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.LevelName.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.Description.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã phép tính';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.MathID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Đơn vị chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.DiscountUnitID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền thanh toán';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.Spendinglevel',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Loại chiết khấu';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.ToolIDCIT1222',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.ToolIDCIT1222.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Tên';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.ToolNameCIT1222.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mức tăng trưởng tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.AccumulatedGrowUpValue',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian tích lũy từ ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.AccumulationFromDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thời gian tích lũy đến ngày';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.AccumulationToDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Áp dụng lũy kế';
EXEC ERP9AddLanguage @ModuleID, 'CIF1523.IsAccumulated',  @FormID, @LanguageValue, @Language;