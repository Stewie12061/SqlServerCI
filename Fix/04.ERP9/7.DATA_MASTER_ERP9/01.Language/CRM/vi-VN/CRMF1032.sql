
--------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1032 - CRM
--            Ngày tạo                                    Người tạo
--            11/05/2017								  Thành Luân
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMF1032'
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
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1032'
---------------------------------------------------------------

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.Title', @FormID, N'Xem chi tiết nhóm nhận Email', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.DivisionID', @FormID, N'Đơn vị', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.GroupReceiverID', @FormID, N'Mã nhóm nhận email', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.GroupReceiverName', @FormID, N'Tên nhóm nhận email', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.Description', @FormID, N'Diễn giải', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.IsCommon', @FormID, N'Dùng chung', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.Disabled', @FormID, N'Không hiển thị', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.CreateUserID', @FormID, N'Người tạo', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.CreateDate', @FormID, N'Ngày tạo', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.LastModifyUserID', @FormID, N'Người cập nhật', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.LastModifyDate', @FormID, N'Ngày cập nhật', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.ThongTinNhomNguoiNhan', @FormID, N'Thông tin nhóm nhận email', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.TabCRMT20301', @FormID, N'Người nhận', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.TabCRMT00003', @FormID, N'Lịch sử', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.ReceiverID', @FormID, N'Mã người nhận', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.ReceiverName', @FormID, N'Tên người nhận', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.Address', @FormID, N'Địa chỉ', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.Mobile', @FormID, N'Điện thoại', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.Email', @FormID, N'Email', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1032.RelatedToTypeName', @FormID, N'Loại đối tượng liên quan', @Language, NULL






