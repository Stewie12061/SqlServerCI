-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2221 - CRM
------------------------------------------------------------------------------------------------------
DECLARE
@ModuleID VARCHAR(10),
@FormID VARCHAR(200),
@Language VARCHAR(10),
------------------------------------------------------------------------------------------------------
-- Tham so gen tu dong
------------------------------------------------------------------------------------------------------
@LanguageValue NVARCHAR(4000),

------------------------------------------------------------------------------------------------------
-- Finished
------------------------------------------------------------------------------------------------------
@Finished BIT


------------------------------------------------------------------------------------------------------
-- Gan gia tri tham so va thu thi truy van
------------------------------------------------------------------------------------------------------
/*
 - Tieng Viet: vi-VN 
 - Tieng Anh: en-US 
 - Tieng Nhat: ja-JP
 - Tieng Trung: zh-CN
*/
SET @Language = 'vi-VN' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2221';

SET @LanguageValue = N'Cập nhật Server';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2221.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2221.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã máy chủ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2221.ServerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên máy chủ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2221.ServerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IP máy chủ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2221.ServerIP', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Port';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2221.MainAPIPort', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng thuê bao tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2221.MaximumRegister', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng thử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2221.IsTrial', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2221.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2221.Description', @FormID, @LanguageValue, @Language;