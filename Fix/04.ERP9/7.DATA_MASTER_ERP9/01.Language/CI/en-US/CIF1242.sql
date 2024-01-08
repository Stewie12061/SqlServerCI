                   
                    ------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CIF1242 - CRM
--            Ngày tạo                                    Người tạo
--            6/21/2017 9:19:05 AM                                         Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@LanguageID VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CIF1242' and Module = N'CI'
-- SELECT * FROM A00001 WHERE FormID = 'CIF1242' and Module = N'CI' and LanguageID = N'en-US'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/
EXEC ERP9AddLanguage N'CI', N'TabAT1328', N'CIF1242', N'Details', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1242.ToDate', N'CIF1242', N'To date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1242.Description', N'CIF1242', N'Description', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1242.DivisionID', N'CIF1242', N'Division', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1242.IsCommon', N'CIF1242', N'Common', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1242.Disabled', N'CIF1242', N'Disabled', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1242.InventoryTypeID', N'CIF1242', N'Inventory type', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1242.PromoteID', N'CIF1242', N'Promotion code', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1242.OID', N'CIF1242', N'Analys code', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1242.LastModifyDate', N'CIF1242', N'Last modify date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1242.CreateDate', N'CIF1242', N'Create date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1242.LastModifyUserID', N'CIF1242', N'Last modify user', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1242.CreateUserID', N'CIF1242', N'Create user', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1242.ThongTinHangKhuyenMai', N'CIF1242', N'Promotion info', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1242.FromDate', N'CIF1242', N'From date', N'en-US', NULL
EXEC ERP9AddLanguage N'CI', N'CIF1242.Title', N'CIF1242', N'View promotion details', N'en-US', NULL

