DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200),
--------------------------------------------------------
@LanguageValue NVARCHAR(4000)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'PO';
SET @FormID = 'POF2010'



---------------------------------------------------------------
--==============================================================

SET @LanguageValue  = N'Thông tin chi phí'
EXEC ERP9AddLanguage @ModuleID, 'POF2010.Title',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số hóa đơn'
EXEC ERP9AddLanguage @ModuleID, 'POF2010.InvoiceNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Mã vận đơn'
EXEC ERP9AddLanguage @ModuleID, 'POF2010.BillOfLadingNo',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Số lượng container'
EXEC ERP9AddLanguage @ModuleID, 'POF2010.QuantityContainer',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí kéo 1 Cont'
EXEC ERP9AddLanguage @ModuleID, 'POF2010.CostTowing',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí kéo Cont'
EXEC ERP9AddLanguage @ModuleID, 'POF2010.CostAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí nâng 1 Cont'
EXEC ERP9AddLanguage @ModuleID, 'POF2010.ContLiftingCosts',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí nâng Cont'
EXEC ERP9AddLanguage @ModuleID, 'POF2010.ContLiftingCostsAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí hạ 1 Cont'
EXEC ERP9AddLanguage @ModuleID, 'POF2010.ContUnloadingCosts',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí hạ Cont'
EXEC ERP9AddLanguage @ModuleID, 'POF2010.ContUnloadingCostsAmount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí khác 1'
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DiffCosts1',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền 1'
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DiffCosts1Amount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí khác 2'
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DiffCosts2',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền 2'
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DiffCosts2Amount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Chi phí khác 3'
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DiffCosts3',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Thành tiền 3'
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DiffCosts3Amount',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Nội dung chi phí'
EXEC ERP9AddLanguage @ModuleID, 'POF2010.DescriptionCost',  @FormID, @LanguageValue, @Language;
