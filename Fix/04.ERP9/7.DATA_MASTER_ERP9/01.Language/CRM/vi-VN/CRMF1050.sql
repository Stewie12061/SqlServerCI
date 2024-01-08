
--------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1050 - CRM
--            Ngày tạo                                    Người tạo
--            11/05/2017								  Thành Luân
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMF1050'
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
set @FormID = N'CRMF1050'
set @Language = N'vi-VN'

-------------------------------------------------------------------------------------------------------------------

Exec ERP9AddLanguage @ModuleID, N'CRMF1050.Title', @FormID, N'Danh mục lý do thất bại/thành công', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1050.DivisionID', @FormID, N'Đơn vị', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1050.CauseID', @FormID, N'Mã lý do', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1050.CauseName', @FormID, N'Tên lý do', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1050.CauseType', @FormID, N'Loại lý do', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1050.Description', @FormID, N'Diễn giải', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1050.IsCommon', @FormID, N'Dùng chung', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1050.Disabled', @FormID, N'Không hiển thị', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1050.CauseTypeName', @FormID, N'Tên loại lý do', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1050.CreateUserID', @FormID, N'Người tạo', @Language, NULL



