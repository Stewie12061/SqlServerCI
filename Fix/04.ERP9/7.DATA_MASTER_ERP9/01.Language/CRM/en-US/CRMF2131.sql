-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ CRMF2131- CRM
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
SET @Language = 'en-US' 
SET @ModuleID = 'CRM';
SET @FormID = 'CRMF2131';

SET @LanguageValue = N'Cập nhật thông tin profile';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.APKMaster', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Computer Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.ComputerName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID1';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.ID1', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID2';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.ID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Module';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.Modules', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.ReportOnly', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.StatusID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Duyệt license';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.ApprovedLicense', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hủy license';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.CancelLicense', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'File Lic';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.FileLic', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Create Date';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.APK', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Đơn vị';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.AccountID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Khách hàng';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.AccountName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.APKCRMT2120', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Hủy license';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.CancellationRecords', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'ID profile';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.ProfileID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Profile Name';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.ProfileName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Chọn profile';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.ChooseProfile', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Ngày tạo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.StatusName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Báo cáo';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.ReportOnlyName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Mã trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.StatusID.CB', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Tên trạng thái';
EXEC ERP9AddLanguage @ModuleID, 'CRMF2131.StatusName.CB', @FormID, @LanguageValue, @Language;

