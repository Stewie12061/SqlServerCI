
--------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1061 - CRM
--            Ngày tạo                                    Người tạo
--            11/05/2017								  Thành Luân
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMF1061'
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
set @FormID = N'CRMF1061'
set @Language = N'vi-VN'

-------------------------------------------------------------------------------------------------------------------
Exec ERP9AddLanguage @ModuleID, N'CRMF1061.Title', @FormID, N'Cập nhật từ khóa', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1061.SalesTagID', @FormID, N'Mã từ khóa', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1061.SalesTagName', @FormID, N'Tên từ khóa', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1061.Description', @FormID, N'Diễn giải', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1061.IsCommon', @FormID, N'Dùng chung', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1061.Disabled', @FormID, N'Không hiển thị', @Language, NULL


