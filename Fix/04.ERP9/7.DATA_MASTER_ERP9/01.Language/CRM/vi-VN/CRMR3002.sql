----------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3002 - CRM
--            Ngày tạo                                    Người tạo
--            28/06/2017							  Thành Luân
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMR3002'
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
SET @FormID = N'CRMR3002'
SET @Language = N'vi-VN'

-------------------------------------------------------------------------------------------------------------------

EXEC ERP9AddLanguage @ModuleID, N'CRMR3002.Title', @FormID, N'Tổng hợp cơ hội từ các nguồn', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMR3002.FromDate', @FormID, N'Từ ngày', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMR3002.ToDate', @FormID, N'Đến ngày', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMR3002.PeriodList', @FormID, N'Từ kỳ', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMR3002.DivisionID', @FormID, N'Đơn vị', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMR3002.FromLeadTypeID', @FormID, N'Từ nguồn đầu mối', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMR3002.ToLeadTypeID', @FormID, N'Đến nguồn đầu mối', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMR3002.FromEmployeeName', @FormID, N'Từ nhân viên', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMR3002.ToEmployeeName', @FormID, N'Đến nhân viên', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMR3002.FromEmployeeID', @FormID, N'Từ nhân viên', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMR3002.ToEmployeeID', @FormID, N'Đến nhân viên', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMR3002.EmployeeName', @FormID, N'Nhân viên', @Language, NULL
EXEC ERP9AddLanguage @ModuleID, N'CRMR3002.LeadTypeName', @FormID, N'Đầu mối', @Language, NULL