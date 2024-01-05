                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ POSF0071 - CRM
--            Ngày tạo                                    Người tạo
--            6/16/2017 11:37:13 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'POSF0071' and Module = N'POS'
-- SELECT * FROM A00001 WHERE FormID = 'POSF0071' and Module = N'POS' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'POS', N'POSF0071.Title', N'POSF0071', N'Bảng cân đối nhập xuất tồn', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0071.ShopID', N'POSF0071', N'Shop', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0071.ToPeriod', N'POSF0071', N'To period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0071.ToDate', N'POSF0071', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0071.DivisionID', N'POSF0071', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0071.InventoryID', N'POSF0071', N'Inventory ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0071.WareHouseID', N'POSF0071', N'Warehouse ID', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0071.FromPeriod', N'POSF0071', N'From period', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0071.FromDate', N'POSF0071', N'From date', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0071.FromInventoryName', N'POSF0071', N'From inventory', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0071.ToInventoryName', N'POSF0071', N'To inventory', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0071.FromWareHouseID', N'POSF0071', N'From Warehouse', N'en-US', NULL
EXEC ERP9AddLanguage N'POS', N'POSF0071.ToWareHouseID', N'POSF0071', N'To Warehouse', N'en-US', NULL

