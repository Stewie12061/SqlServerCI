-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2222 - CRM
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
SET @FormID = 'CRMF2222';

SET @LanguageValue = N'Chi tiết Server';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2222.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết server';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2222.ThongTinChiTietQLServer', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2222.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2222.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã máy chủ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2222.ServerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên máy chủ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2222.ServerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'IP máy chủ';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2222.ServerIP', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Port';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2222.MainAPIPort', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số lượng thuê bao tối đa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2222.MaximumRegister', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Không hiển thị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2222.Disabled', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Dùng thử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2222.IsTrial', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2222.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2222.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2222.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2222.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2222.LastModifyDate', @FormID, @LanguageValue, @Language;