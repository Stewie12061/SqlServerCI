

--------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1052 - CRM
--            Ngày tạo                                    Người tạo
--            11/05/2017								  Thành Luân
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMF1052'
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
set @FormID = N'CRMF1052'
set @Language = N'vi-VN'

-------------------------------------------------------------------------------------------------------------------

Exec ERP9AddLanguage @ModuleID, N'CRMF1052.Title', @FormID, N'Xem chi tiết lí do thất bại/thành công', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1052.DivisionID', @FormID, N'Đơn vị', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1052.CauseID', @FormID, N'Mã lý do', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1052.CauseName', @FormID, N'Tên lý do', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1052.CauseType', @FormID, N'Loại lý do', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1052.Description', @FormID, N'Diễn giải', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1052.IsCommon', @FormID, N'Dùng chung', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1052.Disabled', @FormID, N'Không hiển thị', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1052.CauseTypeName', @FormID, N'Tên loại lý do', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1052.CreateDate', @FormID, N'Ngày tạo', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1052.CreateUserID', @FormID, N'Người tạo', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1052.CreateUserName', @FormID, N'Người tạo', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1052.LastModifyDate', @FormID, N'Ngày cập nhật', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1052.LastModifyUserName', @FormID, N'Người cập nhật', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1052.LastModifyUserID', @FormID, N'Người cập nhật', @Language, NULL

-- Thêm group

Exec ERP9AddLanguage @ModuleID, N'CRMF1052.ThongTinLyDo', @FormID, N'Thông tin lý do thất bại / thành công', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1052.TabCRMT00003', @FormID, N'Lịch sử', @Language, NULL


