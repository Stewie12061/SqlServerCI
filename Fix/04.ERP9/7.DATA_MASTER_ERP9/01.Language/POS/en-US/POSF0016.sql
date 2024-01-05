                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0016 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:12:18 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0016' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0016' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0016.Title', N'POSF0016', N'Sales slip category', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.ToPeriod', N'POSF0016', N'To period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.ToDate', N'POSF0016', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.DivisionID', N'POSF0016', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.VoucherTypeID', N'POSF0016', N'Voucher type', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.CurrencyName', N'POSF0016', N'Currency type', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.ShopID', N'POSF0016', N'Shop ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.MemberID', N'POSF0016', N'Member ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.VoucherDate', N'POSF0016', N'Voucher date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.VoucherNo', N'POSF0016', N'Voucher NO', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.EVoucherNo', N'POSF0016', N'Voucher NO reference', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.IMEI1', N'POSF0016', N'IMEI 1', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.IMEI2', N'POSF0016', N'IMET 2', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.MemberName', N'POSF0016', N'Member name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.PaymentName', N'POSF0016', N'Payment', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.ChangeInventory', N'POSF0016', N'Change inventory', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.ReturnInventory', N'POSF0016', N'Return inventory', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.TotalDiscountAmount', N'POSF0016', N'Discount money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.TotalRedureAmount', N'POSF0016', N'Discount money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.TotalAmount', N'POSF0016', N'Total money', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.FromPeriod', N'POSF0016', N'From period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.FromDate', N'POSF0016', N'From date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.Receipt', N'POSF0016', N'Receipt', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.ExportPrints', N'POSF0016', N'Prepare the export ticket', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.MemberIDFilterOKIA', N'POSF0016', N'Customer code', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.MemberNameFilterOKIA', N'POSF0016', N'Customer name', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0016.DeleteFlg', N'POSF0016', N'Destruction site', N'en-US', NULL