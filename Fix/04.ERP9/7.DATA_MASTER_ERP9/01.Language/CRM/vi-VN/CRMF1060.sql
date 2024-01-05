
--------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1060 - CRM
--            Ngày tạo                                    Người tạo
--            11/05/2017								  Thành Luân
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMF1060'
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
set @FormID = N'CRMF1060'
set @Language = N'vi-VN'

-------------------------------------------------------------------------------------------------------------------

Exec ERP9AddLanguage @ModuleID, N'CRMF1060.Title', @FormID, N'Danh mục từ khóa', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1060.DivisionID', @FormID, N'Đơn vị', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1060.SalesTagID', @FormID, N'Mã từ khóa', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1060.SalesTagName', @FormID, N'Tên từ khóa', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1060.Description', @FormID, N'Diễn giải', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1060.IsCommon', @FormID, N'Dùng chung', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1060.Disabled', @FormID, N'Không hiển thị', @Language, NULL


