
--------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1062 - CRM
--            Ngày tạo                                    Người tạo
--            11/05/2017								  Thành Luân
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMF1062'
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
set @FormID = N'CRMF1062'
set @Language = N'vi-VN'

-------------------------------------------------------------------------------------------------------------------

Exec ERP9AddLanguage @ModuleID, N'CRMF1062.Title', @FormID, N'Xem chi tiết từ khóa', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1062.DivisionID', @FormID, N'Đơn vị', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1062.SalesTagID', @FormID, N'Mã từ khóa', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1062.SalesTagName', @FormID, N'Tên từ khóa', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1062.Description', @FormID, N'Diễn giải', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1062.IsCommon', @FormID, N'Dùng chung', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1062.Disabled', @FormID, N'Không hiển thị', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1062.CreateUserName', @FormID, N'Người tạo', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1062.CreateUserID', @FormID, N'Người tạo', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1062.CreateDate', @FormID, N'Ngày tạo', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1062.LastModifyUserName', @FormID, N'Người cập nhật', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1062.LastModifyDate', @FormID, N'Ngày cập nhật', @Language, NULL

-- Thêm ngôn ngữ cho group

Exec ERP9AddLanguage @ModuleID, N'CRMF1062.ThongTinLoaiHinhBanHang', @FormID, N'Thông tin từ khóa', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1062.TabCRMT00003', @FormID, N'Lịch sử', @Language, NULL

--ĐÌnh Hòa - [16/04/2021] - Thêm ngôn ngữ
 Exec ERP9AddLanguage @ModuleID, N'CRMF1062.LastModifyUserID', @FormID, N'Người cập nhật', @Language, NULL


