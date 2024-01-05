DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2004'
---------------------------------------------------------------

SET @LanguageValue  = N'Cập nhật tiến độ kế hoạch nhận hàng'
EXEC ERP9AddLanguage @ModuleID, 'POF2004.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.VoucherNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.OrderDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.Description',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mẫu kế hoạch nhận hàng';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.FormPlanID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Bước kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.PlanName',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày nhận hàng kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.PlanReceivingDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.AmountPlan',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày nhận hàng thực tế';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.ReceivingDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số tiền thực tế';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.Amount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã bước kế hoạch';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.ID.CB',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mô tả';
EXEC ERP9AddLanguage @ModuleID, 'POF2004.Description.CB',  @FormID, @LanguageValue, @Language;

