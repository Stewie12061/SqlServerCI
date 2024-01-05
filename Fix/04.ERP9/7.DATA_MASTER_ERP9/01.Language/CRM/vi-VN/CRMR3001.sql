--------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3001 - CRM
--            Ngày tạo                                    Người tạo
--            28/06/2017							  Thành Luân
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMR3001'
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
set @FormID = N'CRMR3001'
set @Language = N'vi-VN'

-------------------------------------------------------------------------------------------------------------------

 
Exec ERP9AddLanguage @ModuleID, N'CRMR3001.Title', @FormID, N'Tổng hợp đầu mối từ các nguồn', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3001.FromDate', @FormID, N'Từ ngày', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3001.ToDate', @FormID, N'Đến ngày', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3001.PeriodList', @FormID, N'Từ kỳ', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3001.DivisionID', @FormID, N'Đơn vị', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3001.FromLeadTypeID', @FormID, N'Từ nguồn đầu mối', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3001.ToLeadTypeID', @FormID, N'Đến nguồn đầu mối', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3001.FromEmployeeID', @FormID, N'Từ nhân viên', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3001.ToEmployeeID', @FormID, N'Đến nhân viên', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3001.FromEmployeeName', @FormID, N'Từ nhân viên', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3001.ToEmployeeName', @FormID, N'Đến nhân viên', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3001.EmployeeName', @FormID, N'Nhân viên', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3001.LeadTypeName', @FormID, N'Nguồn đầu mối', @Language, NULL