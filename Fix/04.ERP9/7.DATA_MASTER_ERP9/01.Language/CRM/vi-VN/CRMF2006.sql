------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2006 - CRM 
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000)
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thuc thi truy van
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2006';
------------------------------------------------------------------------------------------------------

SET @LanguageValue = N'Thêm nhanh đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.Title' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chi nhánh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.DivisionID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.VoucherNo' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.OrderDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày giao hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.ShipDate' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.Notes' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.InventoryID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên mặt hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.InventoryName' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị tính';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.UnitID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.SalePrice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền quy đổi';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.ConvertedAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thành tiền';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.OriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.OrderQuantity' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải cọc, nợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.NotesDetail' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú 1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.Notes01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú 2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.Notes02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giao hàng kèm theo hóa đơn';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.IsInvoice' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã chi nhánh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.DivisionID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên chi nhánh';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.DivisionName.CB' , @FormID, @LanguageValue, @Language;
   
SET @LanguageValue = N'Mã hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.InventoryID.Auto' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.InventoryName.Auto' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng cọc, nợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.Parameter01' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn giá cọc, nợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.Parameter02' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số tiền cọc, nợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.Parameter03' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Nhóm thuế';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.VATGroupID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thuế GTGT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.VATOriginalAmount' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'% thuế VAT';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.VATPercent' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã nhóm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.VATGroupID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên nhóm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.VATGroupName.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Giờ đơn hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.OrderTime' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.PriceListID.CB' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Diễn giải';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.PriceListName.CB' , @FormID, @LanguageValue, @Language;
 
SET @LanguageValue = N'Bảng giá';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.PriceListID' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tham số';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.Varchar' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Cho mượn vật tư';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.IsBorrow' , @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Xem nhanh công nợ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.ViewDebit' , @FormID, @LanguageValue, @Language;

-------------- 21/09/2021 - Hoài Bảo: Bổ sung ngôn ngữ Khách hàng --------------
SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2006.AccountName' , @FormID, @LanguageValue, @Language;