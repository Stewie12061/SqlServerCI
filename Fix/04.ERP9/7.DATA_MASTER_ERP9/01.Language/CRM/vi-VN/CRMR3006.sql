----------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3006 - CRM
--            Ngày tạo                                    Người tạo
--            28/06/2017							  Thành Luân
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMR3006'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
-- Thêm ngôn ngữ bảng ERP9

DECLARE @ModuleID varchar(10),
		@FormID varchar(200),
		@Language varchar(10)

set @ModuleID = N'CRM'
set @FormID = N'CRMR3006'
set @Language = N'vi-VN'

-------------------------------------------------------------------------------------------------------------------

Exec ERP9AddLanguage @ModuleID, N'CRMR3006.Title', @FormID, N'Thống kê cơ hội theo khu vực', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3006.FromDate', @FormID, N'Từ ngày', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3006.ToDate', @FormID, N'Đến ngày', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3006.PeriodList', @FormID, N'Từ kỳ', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3006.DivisionID', @FormID, N'Đơn vị', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3006.FromStageID', @FormID, N'Từ khu vực', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3006.ToStageID', @FormID, N'Đến khu vực', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3006.FromEmployeeID', @FormID, N'Từ nhân viên', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3006.ToEmployeeID', @FormID, N'Đến nhân viên', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3006.FromAreaID', @FormID, N'Từ khu vực', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3006.ToAreaID', @FormID, N'Đến khu vực', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3006.FromEmployeeName', @FormID, N'Từ nhân viên', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3006.ToEmployeeName', @FormID, N'Đến nhân viên', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3006.EmployeeName', @FormID, N'Nhân viên', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3006.AreaID', @FormID, N'Khu vực', @Language, NULL
