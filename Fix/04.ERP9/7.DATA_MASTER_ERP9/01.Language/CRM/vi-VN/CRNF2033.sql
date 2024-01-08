--------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2033 - CRM
--            Ngày tạo                                    Người tạo
--            29/01/2021								  Đình Hòa
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
set @FormID = N'CRMF2033'
set @Language = N'vi-VN'

-------------------------------------------------------------------------------------------------------------------

Exec ERP9AddLanguage @ModuleID, N'CRMF2033.Title', @FormID, N'Cập nhật người phụ trách', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF2033.AssignedToUserID', @FormID, N'Người phụ trách', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF2033.AssignedToUserName', @FormID, N'Người phụ trách', @Language, NULL


