----------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3004 - CRM
--            Ngày tạo                                    Người tạo
--            28/06/2017							  Thành Luân
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMR3004'
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
set @FormID = N'CRMR3004'
set @Language = N'vi-VN'

-------------------------------------------------------------------------------------------------------------------

Exec ERP9AddLanguage @ModuleID, N'CRMR3004.Title', @FormID, N'Tổng hợp giá trị cơ hội theo nhân viên', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3004.FromDate', @FormID, N'Từ ngày', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3004.ToDate', @FormID, N'Đến ngày', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3004.PeriodList', @FormID, N'Từ kỳ', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3004.DivisionID', @FormID, N'Đơn vị', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3004.FromStageID', @FormID, N'Từ giai đoạn', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3004.ToStageID', @FormID, N'Đến giai đoạn', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3004.FromEmployeeName', @FormID, N'Từ nhân viên', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3004.ToEmployeeName', @FormID, N'Đến nhân viên', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3004.FromEmployeeID', @FormID, N'Từ nhân viên', @Language, NULL
-- Exec ERP9AddLanguage @ModuleID, N'CRMR3004.ToEmployeeID', @FormID, N'Đến nhân viên', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3004.EmployeeName', @FormID, N'Nhân viên', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3004.StageID', @FormID, N'Giai đoạn', @Language, NULL
