                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0002 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:02:09 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0002' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0002' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType05', N'POSF0002', N'Voucher', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType08', N'POSF0002', N'Discrepancies form', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType10', N'POSF0002', N'Internal transportation proposal form', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType07', N'POSF0002', N'Proposal to issue / return goods form', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType04', N'POSF0002', N'Adjustment warehouse form', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType12', N'POSF0002', N'Bills of exchange', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType02', N'POSF0002', N'Sales order returned bill', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType03', N'POSF0002', N'Inventory check form', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType01', N'POSF0002', N'Enter form', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType06', N'POSF0002', N'Diary form', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType13', N'POSF0002', N'Inventory warehouse form', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType11', N'POSF0002', N'Internal transportation form', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType09', N'POSF0002', N'Delivery bill', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.Title', N'POSF0002', N'Voucher info', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType14', N'POSF0002', N'Receipts', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType17', N'POSF0002', N'Request for invoice', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType18', N'POSF0002', N'Voucher request', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType19', N'POSF0002', N'Request for warehousing', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType20', N'POSF0002', N'General journal entry', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType15', N'POSF0002', N'Deposit card', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0002.VoucherType16', N'POSF0002', N'Proposal for payment', N'en-US', NULL



