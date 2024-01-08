

--------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1051 - CRM
--            Ngày tạo                                    Người tạo
--            11/05/2017								  Thành Luân
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMF1051'
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
set @FormID = N'CRMF1051'
set @Language = N'vi-VN'

-------------------------------------------------------------------------------------------------------------------

Exec ERP9AddLanguage @ModuleID, N'CRMF1051.Title', @FormID, N'Cập nhật lí do thất bại/thành công', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1051.CauseID', @FormID, N'Mã lý do', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1051.CauseName', @FormID, N'Tên lý do', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1051.CauseType', @FormID, N'Loại lý do', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1051.Description', @FormID, N'Diễn giải', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1051.IsCommon', @FormID, N'Dùng chung', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1051.Disabled', @FormID, N'Không hiển thị', @Language, NULL

