-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2132- CRM
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
SET @FormID = 'CRMF2132';

SET @LanguageValue = N'Thông tin chi tiết profile theo modules';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên máy';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.ComputerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.ID1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.ID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.Modules', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.ReportOnly', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duyệt license';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.ApprovedLicense', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hủy license';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.CancelLicense', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File Lic';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.FileLic', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.APKCRMT2120', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hủy license';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.CancellationRecords', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID profile';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.ProfileID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên profile';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.ProfileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.ChooseProfile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Người sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày sửa';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.ReportOnlyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ghi chú';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đính kèm';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Lịch sử';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.LichSu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin profile';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.ThongTinProfile', @FormID, @LanguageValue, @Language

SET @LanguageValue = N'Thông tin file Lic';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.ThongTinFileLic', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Thông tin chi tiết profile theo modules';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.ChiTietProfileTheoModules', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File Lic';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.AttachName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Số hợp đồng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2132.FieldContractNo', @FormID, @LanguageValue, @Language;