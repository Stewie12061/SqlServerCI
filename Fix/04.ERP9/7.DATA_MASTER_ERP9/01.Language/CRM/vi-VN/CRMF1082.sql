------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1082 - CRM
--            Ngày tạo                                    Người tạo
--            11/05/2017                                  Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMF1082'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1082';
------------------------------------------------------------------------------------------------------

Exec ERP9AddLanguage @ModuleID, N'CRMF1082.Title', @FormID, N'Xem chi tiết hành động (next action)', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1082.DivisionID', @FormID, N'Đơn vị', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1082.NextActionID', @FormID, N'Mã hành động', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1082.NextActionName', @FormID, N'Tên hành động', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1082.Description', @FormID, N'Diễn giải', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1082.IsCommon', @FormID, N'Dùng chung', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1082.Disabled', @FormID, N'Không hiển thị', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1082.CreateDate', @FormID, N'Ngày tạo', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1082.CreateUserName', @FormID, N'Người tạo', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1082.CreateUserID', @FormID, N'Người tạo', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1082.LastModifyDate', @FormID, N'Ngày cập nhật', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1082.LastModifyUserName', @FormID, N'Ngày cập nhật', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1082.LastModifyUserID', @FormID, N'Ngày cập nhật', @Language, NULL

-- THêm ngôn ngữ cho group Thông tin hành động tiếp theo

Exec ERP9AddLanguage @ModuleID, N'CRMF1082.ThongTinHanhDong', @FormID, N'Thông tin hành động', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1082.TabCRMT00003', @FormID, N'Lịch sử', @Language, NULL


