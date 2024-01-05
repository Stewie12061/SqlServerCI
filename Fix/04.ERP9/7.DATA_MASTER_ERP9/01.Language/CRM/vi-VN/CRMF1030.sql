--------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1030 - CRM
--            Ngày tạo                                    Người tạo
--            11/05/2017								  Thành Luân
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMF1030'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
-- Thêm ngôn ngữ bảng ERP9

DECLARE 
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(200)

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1030'
---------------------------------------------------------------

Exec ERP9AddLanguage @ModuleID, N'CRMF1030.Title', @FormID, N'Danh mục nhóm nhận Email', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1030.DivisionID', @FormID, N'Đơn vị', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1030.GroupReceiverID', @FormID, N'Mã nhóm nhận email', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1030.GroupReceiverName', @FormID, N'Tên nhóm nhận email', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1030.Description', @FormID, N'Diễn giải', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1030.IsCommon', @FormID, N'Dùng chung', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1030.Disabled', @FormID, N'Không hiển thị', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1030.CreateUserID', @FormID, N'Người tạo', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1030.CreateDate', @FormID, N'Ngày tạo', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1030.LastModifyUserID', @FormID, N'Người cập nhật', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1030.LastModifyDate', @FormID, N'Ngày cập nhật', @Language, NULL



