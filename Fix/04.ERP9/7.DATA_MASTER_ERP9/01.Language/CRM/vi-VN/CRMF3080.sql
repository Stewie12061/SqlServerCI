

--------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF3080 - CRM
--            Ngày tạo                                    Người tạo
--            11/05/2017								  Thành Luân
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMF3080'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
-- Thêm ngôn ngữ bảng ERP9

DECLARE @ModuleID VARCHAR(10),
		@FormID VARCHAR(200),
		@Language VARCHAR(10)

SET @ModuleID = N'CRM'
SET @FormID = N'CRMF3080'
SET @Language = N'vi-VN'

-------------------------------------------------------------------------------------------------------------------
EXEC ERP9AddLanguage @ModuleID, N'CRMR3080.Title', @FormID, N'Thống kê yêu cầu khách hàng', @Language, NULL

EXEC ERP9AddLanguage @ModuleID, N'CRMF3080.Title', @FormID, N'Thống kê yêu cầu khách hàng', @Language, NULL

EXEC ERP9AddLanguage @ModuleID, N'CRMF3080.DivisionID', @FormID, N'Đơn vị', @Language, NULL

EXEC ERP9AddLanguage @ModuleID, N'CRMF3080.FromAccountName', @FormID, N'Từ khách hàng', @Language, NULL

EXEC ERP9AddLanguage @ModuleID, N'CRMF3080.ToAccountName', @FormID, N'Đến khách hàng', @Language, NULL

EXEC ERP9AddLanguage @ModuleID, N'CRMF3080.FromEmployeeID', @FormID, N'Từ nhân viên', @Language, NULL

EXEC ERP9AddLanguage @ModuleID, N'CRMF3080.ToEmployeeID', @FormID, N'Đến nhân viên', @Language, NULL

EXEC ERP9AddLanguage @ModuleID, N'CRMF3080.EmployeeName', @FormID, N'Nhân viên', @Language, NULL

EXEC ERP9AddLanguage @ModuleID, N'CRMF3080.AccountName', @FormID, N'Khách hàng', @Language, NULL

EXEC ERP9AddLanguage @ModuleID, N'CRMF3080.Report', @FormID, N'Mẫu báo cáo', @Language, NULL