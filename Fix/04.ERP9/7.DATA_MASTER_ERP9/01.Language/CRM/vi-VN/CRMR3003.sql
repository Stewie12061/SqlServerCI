----------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMR3003 - CRM
--            Ngày tạo                                    Người tạo
--            28/06/2017							  Thành Luân
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMR3003'
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
set @FormID = N'CRMR3003'
set @Language = N'vi-VN'

-------------------------------------------------------------------------------------------------------------------

Exec ERP9AddLanguage @ModuleID, N'CRMR3003.Title', @FormID, N'Thống kê hoạt động cơ hội theo giai đoạn', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3003.DivisionID', @FormID, N'Đơn vị', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3003.StageID', @FormID, N'Giai đoạn bán hàng', @Language, NULL
Exec ERP9AddLanguage @ModuleID, N'CRMR3003.EmployeeName', @FormID, N'Nhân viên', @Language, NULL