------------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF1081 - CRM
--            Ngày tạo                                    Người tạo
--            11/05/2017                                  Thành Luân
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10)

-- Gan gia tri tham so va thu thi truy van
-- SELECT * FROM A00001 WHERE FormID = 'CRMF1081'
------------------------------------------------------------------------------------------------------
/*
- Tieng Viet: vi-VN 
- Tieng Anh: en-US 
- Tieng Nhat: ja-JP 
- Tieng Trung: zh-CN
*/ 
SET @Language = 'vi-VN';
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF1081';
------------------------------------------------------------------------------------------------------

Exec ERP9AddLanguage @ModuleID, N'CRMF1081.Title', @FormID, N'Cập nhật hành động', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1081.NextActionID', @FormID, N'Mã hành động', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1081.NextActionName', @FormID, N'Tên hành động', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1081.Description', @FormID, N'Diễn giải', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1081.IsCommon', @FormID, N'Dùng chung', @Language, NULL

Exec ERP9AddLanguage @ModuleID, N'CRMF1081.Disabled', @FormID, N'Không hiển thị', @Language, NULL

