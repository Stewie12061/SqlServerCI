
--------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1031 - CRM
--            Ngày tạo                                    Người tạo
--            11/05/2017								  Thành Luân
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMF1031'
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
@Language VARCHAR(200),
@LanguageValue NVARCHAR(MAX)
--------------------------------------------------------

SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1031'
---------------------------------------------------------------

Exec ERP9AddLanguage @ModuleID, N'CRMF1031.Title', @FormID, N'Cập nhật nhóm nhận Email', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1031.GroupReceiverID', @FormID, N'Mã nhóm nhận email', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1031.GroupReceiverName', @FormID, N'Tên nhóm nhận email', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1031.Description', @FormID, N'Diễn giải', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1031.IsCommon', @FormID, N'Dùng chung', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1031.Disabled', @FormID, N'Không hiển thị', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1031.AssignedListUserName', @FormID, N'Người phụ trách', @Language, NULL

SET @LanguageValue  = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031.CreateUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031.CreateDate',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031.LastModifyUserID',  @FormID, @LanguageValue, @Language;

SET @LanguageValue  = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF1031.LastModifyDate',  @FormID, @LanguageValue, @Language;



