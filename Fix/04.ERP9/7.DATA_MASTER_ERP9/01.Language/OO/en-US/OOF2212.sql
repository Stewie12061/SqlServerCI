-----------------------------------------------------------------------------------------------------
-- Script tạo ngôn ngữ OOF2212- OO
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
SET @ModuleID = 'OO';
SET @FormID = 'OOF2212';

SET @LanguageValue = N'Release view';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.Title', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Division';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.DivisionID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.ReleaseID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release Name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.ReleaseName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type of release';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.TypeOfRelease', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.ProjectID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Project';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.ProjectName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.MilestoneID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Milestone';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.MilestoneName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Person in charge';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.AssignedToUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.AssignedToUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release Version';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.ReleaseVersion', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Description and file download link';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.Description', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.DeleteFlg', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.CreateDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.CreateUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last modified user';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.LastModifyUserID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Last Modified  Date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.LastModifyDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.FromToDate', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.CreateUserID2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creation date';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.CreateDate2', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.VoucherTypeID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Creator';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.CreateUserName', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request From Customers ';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.TabCRMT20801', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Issue management';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.TabOOT2160', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Notes';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.GhiChu', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Attachment';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.DinhKem', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Release management details';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.ThongTinChiTietQuanLyRelease', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request ID';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.RequestCustomerID', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Type Of Request';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.TypeOfRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Status';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.RequestStatus', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Start time';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.TimeRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Deadline';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.DeadlineRequest', @FormID, @LanguageValue, @Language;

SET @LanguageValue = N'Request name';
EXEC ERP9AddLanguage @ModuleID, 'OOF2212.RequestSubject', @FormID, @LanguageValue, @Language;
