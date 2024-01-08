                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ A00 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 2:57:53 PM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'A00' and Module = N'00'
-- SELECT * FROM A00001 WHERE FormID = 'A00' and Module = N'00' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_List_AreaCategory', N'A00', N'Area category', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_List_Member', N'A00', N'Member category', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_List_MemberCard', N'A00', N'Member card category', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_List_MemberCardType', N'A00', N'Card type category', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_List_Payment', N'A00', N'Payment forms list', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_List_Product', N'A00', N'Catalog of goods at the store', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_List_Shop', N'A00', N'Shop category', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_List_TableCategory', N'A00', N'Table category', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_List_Time', N'A00', N'Time category', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.List', N'A00', N'Category', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.List_AbsentType', N'A00', N'Permission types category', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.List_UnusualType', N'A00', N'Irregular category', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'CRM_DanhMuc', N'A00', N'Category', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.Business', N'A00', N'Business', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.BusinessAnalystID', N'A00', N'Business analysis code', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ST0007_TableID', N'A00', N'Business code', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ST0007_TableName', N'A00', N'Business name', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'CRM_NghiepVu', N'A00', N'Business', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'SO_NghiepVu', N'A00', N'Business', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.SYSTEM', N'A00', N'System', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.CommonConfig', N'A00', N'General setup', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.PermissionSeeDataAnotherPerson', N'A00', N'View for other people data permission', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ModuleCRM', N'A00', N'CRM Module', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.CRMF0000', N'A00', N'System setup', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.btnReturnAll', N'A00', N'<<', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ChangePass', N'A00', N'Change password', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_Business_ChangeWarehouse', N'A00', N'Adjustment warehouse form', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_Business_CheckWarehouse', N'A00', N'Check warehouse form', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_Business_DiarySale', N'A00', N'Inventory diary form', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_Business_Disparity', N'A00', N'Discrepancies', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_Business_Export', N'A00', N'Export inventory form', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_Business_Export_Refund', N'A00', N'Proposal to issue / return goods form', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_Business_Import', N'A00', N'Import coupon form', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_Business_Sale', N'A00', N'Sales form', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_List_Stock_Inventory', N'A00', N'Inventory balance form', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.POS_Stock_Inventory', N'A00', N'Exception opening balancing form', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'CRM_NghiepVu_DSPCDP', N'A00', N'Coordinator form', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'CRM_NghiepVu_DSPDDP', N'A00', N'Coordinated form', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ScreenPermission', N'A00', N'Screen permission', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.POrder', N'A00', N'Set up purchase orders', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.POST00801', N'A00', N'Update receipts', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.POST00802', N'A00', N'Update receipts details', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_List_Events', N'A00', N'Event', N'en-US', NULL

EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_List_MemberCardOKIA', N'A00', N'Customer card category', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_List_MemberOKIA', N'A00', N'Customer category', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.POST0010', N'A00', N'Event', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.POST0026', N'A00', N'Voucher type', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.POST0004', N'A00', N'Tax', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_Business_DepositVoucher', N'A00', N'Deposit voucher', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ItemPOS_Business_Receipt', N'A00', N'Receipt', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ComboVoucherID', N'A00', N'Voucher type code', N'en-US', NULL
EXEC ERP9AddLanguage N'00', N'A00.ComboVoucherName', N'A00', N'Voucher type name', N'en-US', NULL



